import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:west_irbid_mobile/models/case_procedures_model.dart';
import 'package:west_irbid_mobile/models/complaints.dart';
import 'package:west_irbid_mobile/models/departments.dart';
import 'package:west_irbid_mobile/models/diwan.dart';
import 'package:west_irbid_mobile/models/diwan_classes.dart';
import 'package:west_irbid_mobile/models/estemlakat.dart';
import 'package:west_irbid_mobile/models/floor_model.dart';
import 'package:west_irbid_mobile/models/licensed_model.dart';
import 'package:west_irbid_mobile/models/roles_model.dart';
import 'package:west_irbid_mobile/models/settings_model.dart';
import 'package:west_irbid_mobile/models/statistic_model.dart';
import 'package:west_irbid_mobile/models/tandeem_model.dart';
import 'package:west_irbid_mobile/models/user_model.dart';
import 'package:west_irbid_mobile/models/user_role_model.dart';
import 'package:west_irbid_mobile/models/wp_archive_model.dart';
import 'package:west_irbid_mobile/models/wp_model.dart';
import 'package:west_irbid_mobile/services_utils/constants.dart';
import 'package:west_irbid_mobile/services_utils/custom_apis_methods.dart';
import 'package:west_irbid_mobile/services_utils/ui_helpers.dart';
import 'package:uuid/uuid.dart';

class SupaApi {
  static final SupabaseClient supaInstCLient = Supabase.instance.client;
  static User? supaUser;
  static Future<User?> login(String email, String password) async {
    try {
      final response = await supaInstCLient.auth.signInWithPassword(
        email: email,
        password: password,
      );
      // Login successful, return the user
      supaUser = response.user;

      return supaUser;
    } catch (error) {
      print('Error during login: $error');
      return null;
    }
  }

  static Future<User?> resetPassword(String email, String password) async {
    try {
      final response = await supaInstCLient.auth.updateUser(
        UserAttributes(email: email, password: password),
        // email: email,
        // password: password,
      );
      // Login successful, return the user
      debugPrint(response.toString());
      supaUser = response.user;

      return supaUser;
    } catch (error) {
      print('Error during login: $error');
      return null;
    }
  }

  static Future<String?> upload_files_supa(
    String bucket_id,
    String file_path,
    String file_name,
    // , String upload_file_path
  ) async {
    String? upload_url;
    String upload_file_path = file_name;
    // file_path.split('''/''').last;
    try {
      final avatarFile = File(file_path);
      String uuidx = Uuid().v1();
      upload_url = await supaInstCLient.storage
          .from(bucket_id) //'mts-store-media'
          // .from('media')
          .upload(
            uuidx + upload_file_path,
            // 'product-media/avatar1.png',
            avatarFile,
            fileOptions: const FileOptions(cacheControl: '3600', upsert: false),
          );
    } catch (e) {
      upload_url = 'error';
      Get.log(e.toString());
    } finally {
      return upload_url;
    }
  }

  static Future<List<T>?> get_Table_List<T>({
    required BuildContext context,
    required int pageNumber,
    required int pageSize,
    required String table_name,
    required List<dynamic> coloumList,
    String idColuomn = 'id',
    String? order_by_fields,
    required T Function(Map<String, dynamic>)
    fromJson, // Pass a fromJson function
  }) async {
    List<T> returnData = [];
    try {
      // SupabaseQueryBuilder queryBuilder=  supaInstCLient.from('diwan').select().match(query);
      List<Map<String, dynamic>> x = await supaInstCLient
          .from(table_name)
          .select()
          .inFilter(idColuomn, coloumList)
          .range((pageNumber - 1) * pageSize, (pageNumber * pageSize) - 1)
          .order(order_by_fields ?? 'id', ascending: false);
      //.limit(500);

      Get.log(x.toString());
      if (x.isNotEmpty) {
        returnData = x.map((e) => fromJson(e)).toList();
      } else {
        Get.log('Empty');
      }
      // try {
    } catch (e) {
      Get.log(e.toString());
      show_snackBar(
        context,
        ConstantsData.absentClr,
        'Error to retrieve ${table_name.toString()}'.tr,
      );
    } finally {
      return returnData;
    }
  }

  static Future<List<T>?> get_search_table<T>({
    required BuildContext context,
    required Map<String, Object> query,
    required int pageNumber,
    required String table_name,
    required T Function(Map<String, dynamic>) fromJson,
    String? orderBy,
    // required Map<String, dynamic> toJson,
    required int pageSize,
  }) async {
    List<T> returnData = [];
    try {
      // SupabaseQueryBuilder queryBuilder=  supaInstCLient.from('diwan').select().match(query);
      List<Map<String, dynamic>> x = await supaInstCLient
          .from(table_name)
          .select()
          .match(query)
          .range((pageNumber - 1) * pageSize, (pageNumber * pageSize) - 1)
          .order(orderBy ?? 'creation_date', ascending: false);
      //.limit(500);

      Get.log(x.toString());
      if (x.isNotEmpty) {
        returnData = x.map((e) => fromJson(e)).toList();
      } else {
        Get.log('Empty');
      }
      // try {
    } catch (e) {
      Get.log(e.toString());
      show_snackBar(
        context,
        ConstantsData.absentClr,
        'Error to retrieve $table_name'.tr,
      );
    } finally {
      return returnData;
    }
  }

  static Future<(List<T>?, bool)> insert_table_multi_records<T>({
    required BuildContext context,
    required String table_name,
    required T Function(Map<String, dynamic>) fromJson,
    required List<Map<String, dynamic>> toJson,
  }) async {
    bool isAdded = false;
    List<T>? returnResp;
    try {
      List<Map<String, dynamic>> x = await supaInstCLient
          .from(table_name)
          .insert(toJson)
          .select();
      Get.log(x.toString());
      if (x.isNotEmpty) returnResp = x.map((e) => fromJson(e)).toList();
      // returnResp = fromJson(x[0]);
      isAdded = true;

      // try {
    } catch (e) {
      Get.log(e.toString());
      isAdded = false;
      show_snackBar(
        context,
        ConstantsData.absentClr,
        'Error to add ${table_name}'.tr,
      );
    } finally {
      return (returnResp, isAdded);
    }
  }

  static Future<(T?, bool)> insert_table<T>({
    required BuildContext context,
    required String table_name,
    required T Function(Map<String, dynamic>) fromJson,
    required Map<String, dynamic> toJson,
  }) async {
    bool isAdded = false;
    T? returnResp;
    try {
      List<Map<String, dynamic>> x = await supaInstCLient
          .from(table_name)
          .insert(toJson)
          .select();
      Get.log(x.toString());
      returnResp = fromJson(x[0]);
      isAdded = true;

      // try {
    } catch (e) {
      Get.log(e.toString());
      isAdded = false;
      show_snackBar(
        context,
        ConstantsData.absentClr,
        'Error to add ${table_name}'.tr,
      );
    } finally {
      return (returnResp, isAdded);
    }
  }

  static Future<(T?, bool)> insertUpdateTable<T>({
    required BuildContext context,
    // required CaseProcedure caseProcedureObj,
    bool isInsert = true,
    int? objId,
    required Map<String, dynamic> query,
    required String table_name,
    required T Function(Map<String, dynamic>) fromJson,
  }) async {
    bool isAdded = false;
    T? returnResp;
    // try {
    List<Map<String, dynamic>> x = isInsert
        ? await supaInstCLient.from(table_name).insert(query).select()
        : await supaInstCLient
              .from(table_name)
              .update(query)
              .eq('id', objId!)
              .select();
    Get.log(x.toString());
    returnResp = fromJson(x[0]);
    isAdded = true;

    try {} catch (e) {
      Get.log(e.toString());
      isAdded = false;
      show_snackBar(
        context,
        ConstantsData.absentClr,
        'Error to add or update '.tr + table_name,
      );
    } finally {
      return (returnResp, isAdded);
    }
  }

  static Future<List<T>?> get_PRC<T>({
    required BuildContext context,
    required String function_name,
    required T Function(Map<String, dynamic>)
    fromJson, // Pass a fromJson function
  }) async {
    List<T> _data = [];
    try {
      List<Map<String, dynamic>> x = await supaInstCLient.rpc(function_name);

      Get.log(x.toString());
      List<dynamic> y = x[0]['user_data'];
      if (y.isNotEmpty) {
        _data = y.map((e) => fromJson(e)).toList(); // Use the fromJson function
      } else {
        Get.log('Empty');
      }
    } catch (e) {
      Get.log(e.toString());
      show_snackBar(
        context,
        ConstantsData.absentClr,
        'Error to retrieve PRC ${function_name}'.tr,
      );
    } finally {
      return _data;
    }
  }

  static Future<int?> get_PRC_insert_wf_diwan_copyto({
    required BuildContext context,
    required String function_name,
    required Diwan diwan_data,
    required List<Map<String, dynamic>?> copyto_data,
    // Pass a fromJson function
  }) async {
    int? _data;
    try {
      final response = await supaInstCLient.rpc(
        function_name, //'insert_diwan_with_copyto'
        params: {'diwan_data': diwan_data.toJson(), 'copyto_data': copyto_data},
      );

      Get.log(response.toString());
      if (response != null) {
        _data = response as int; // Use the fromJson function
      } else {
        Get.log('Empty');
      }
    } catch (e) {
      Get.log(e.toString());
      show_snackBar(
        context,
        ConstantsData.absentClr,
        'Error to retrieve PRC ${function_name}'.tr,
      );
    } finally {
      return _data;
    }
  }

  static Future<List<T>?> get_Table<T>({
    required BuildContext context,
    required Map<String, Object> query,
    required int pageNumber,
    required int pageSize,
    required String table_name,
    String? order_by_fields,
    bool ascending = false,
    required T Function(Map<String, dynamic>)
    fromJson, // Pass a fromJson function
  }) async {
    List<T> returnData = [];
    // try {
    // SupabaseQueryBuilder queryBuilder=  supaInstCLient.from('diwan').select().match(query);
    List<Map<String, dynamic>> x = await supaInstCLient
        .from(table_name)
        .select()
        .match(query)
        .range((pageNumber - 1) * pageSize, (pageNumber * pageSize) - 1)
        .order(order_by_fields ?? 'id', ascending: ascending);
    //.limit(500);

    Get.log(x.toString());
    if (x.isNotEmpty) {
      returnData = x.map((e) => fromJson(e)).toList();
    } else {
      Get.log('Empty');
    }
    try {} catch (e) {
      Get.log(e.toString());
      show_snackBar(
        context,
        ConstantsData.absentClr,
        'Error to retrieve ${table_name.toString()}'.tr,
      );
    } finally {
      return returnData;
    }
  }

  static Future<List<T>?> get_search_table_with_filter<T>({
    required BuildContext context,
    required String table_name,
    String? order_by_fields,
    required T Function(Map<String, dynamic>) fromJson,
    required String filterCol,
    String? filterValue,
    required int pageNumber,
    required int pageSize,
  }) async {
    List<T> returnObj = [];
    try {
      // SupabaseQueryBuilder queryBuilder=  supaInstCLient.from('diwan').select().match(query);
      List<Map<String, dynamic>> x = await supaInstCLient
          .from(table_name)
          .select()
          .textSearch(filterCol, filterValue ?? '')
          .range((pageNumber - 1) * pageSize, (pageNumber * pageSize) - 1)
          .order(order_by_fields ?? 'id', ascending: false);
      //.limit(500);

      Get.log(x.toString());
      if (x.isNotEmpty) {
        returnObj = x.map((e) => fromJson(e)).toList();
      } else {
        Get.log('Empty');
      }
      // try {
    } catch (e) {
      Get.log(e.toString());
      show_snackBar(
        context,
        ConstantsData.absentClr,
        'Error to retrieve $table_name'.tr,
      );
    } finally {
      return returnObj;
    }
  }

  // static Future<void> insertBuildLicence() async {
  //   try {
  //     BuildLicenseModel y = BuildLicenseModel(
  //         licenceOwnerName: 'Motasem adnan',
  //         licenceBuildDetailsArea: 'fdfd',
  //         insertUserName: 'msn',
  //         licenceCity: 'HAM',
  //         fileNumber: '12155');
  //     List<Map<String, dynamic>> x = await supaInstCLient
  //         .from('build_license_table')
  //         .insert(y.toJson())
  //         .select();
  //     Get.log(x.toString());
  //     BuildLicenseModel y1 = BuildLicenseModel.fromJson(x[0]);
  //     int licence_id = y1.id ?? -1;
  //     if (licence_id != -1) {
  //       Get.log(licence_id.toString());
  //       FloorModel floor1 = FloorModel(
  //           area: 2.3,
  //           fees: 888,
  //           buildLicenceId: licence_id,
  //           floor: 'الاول',
  //           reciptDate: '1/12/2021',
  //           reciptNumber: 123);
  //       FloorModel floor2 = FloorModel(
  //           area: 7.13,
  //           fees: 777,
  //           buildLicenceId: licence_id,
  //           floor: 'الثاني',
  //           reciptDate: '1/12/2021',
  //           reciptNumber: 124);
  //       List<Map<String, dynamic>> f = await supaInstCLient
  //           .from('floors')
  //           .insert([floor1.toJson(), floor2.toJson()]).select();
  //       Get.log(f.toString());
  //     }
  //   } catch (e) {}
  // }

  static Future<String?> getPublicUrl(String fileSupaUrl) async {
    // west-irbid/land_sketch/338455d0-f49b-1da8-8ab1-49f23bd81452build.png
    String bucket_id = fileSupaUrl.substring(0, fileSupaUrl.lastIndexOf('/'));
    String file_name = fileSupaUrl.lastIndexOf('/') > 0
        ? (fileSupaUrl.substring(fileSupaUrl.lastIndexOf('/') + 1))
        : fileSupaUrl;
    Get.log('bucket_id ${bucket_id},file_name $file_name');
    final String signedUrl = await supaInstCLient.storage
        .from(bucket_id)
        .createSignedUrl(
          file_name,
          60,
          // transform: TransformOptions(
          //   width: 100,
          //   height: 100,
          // ),
        );
    Get.log(signedUrl);
    return signedUrl;
  }

  static Future<bool> insertBuildLicenceWithFloor({
    required BuildContext context,
    required BuildLicenseModel myLicence,
    required List<FloorModel> floorList,
  }) async {
    bool isAdded = false;
    // try {
    List<Map<String, dynamic>> x = await supaInstCLient
        .from('building_archive')
        .insert(myLicence.toJson())
        .select();
    Get.log(x.toString());
    BuildLicenseModel y1 = BuildLicenseModel.fromJson(x[0]);
    int licence_id = y1.id ?? -1;
    if (licence_id != -1) {
      // Get.log(licence_id.toString());
      floorList.forEach((e1) {
        e1.buildLicenceId = licence_id;
      });

      List<dynamic> floorJson = floorList.map((e2) => e2.toJson()).toList();
      List<Map<String, dynamic>> f = await supaInstCLient
          .from('floors')
          .insert(floorJson)
          .select();
      Get.log(f.toString());
      isAdded = true;
      // return isAdded;
    }
    try {} catch (e) {
      Get.log(e.toString());
      isAdded = false;
      show_snackBar(
        context,
        ConstantsData.absentClr,
        'Error to Add Build Licence'.tr,
      );
    } finally {
      return isAdded;
    }
  }

  static Future<bool> insertWPWithFloor({
    required BuildContext context,
    required WPModel wp,
    required List<FloorModel> floorList,
  }) async {
    bool isAdded = false;
    try {
      List<Map<String, dynamic>> x = await supaInstCLient
          .from('wp_table')
          .insert(wp.toJson())
          .select();
      Get.log(x.toString());
      WPModel y1 = WPModel.fromJson(x[0]);
      int licence_id = y1.id ?? -1;
      if (licence_id != -1) {
        // Get.log(licence_id.toString());
        floorList.forEach((e1) {
          e1.workingPermissionId = licence_id.toString();
        });

        List<dynamic> floorJson = floorList.map((e2) => e2.toJson()).toList();
        List<Map<String, dynamic>> f = await supaInstCLient
            .from('wp_floors')
            .insert(floorJson)
            .select();
        Get.log(f.toString());
        isAdded = true;
        // return isAdded;
      }
      // try {
    } catch (e) {
      Get.log(e.toString());
      isAdded = false;
      show_snackBar(context, ConstantsData.absentClr, 'Error to Add WP'.tr);
    } finally {
      return isAdded;
    }
  }

  static Future<bool> insertWPArchiveWithFloor({
    required BuildContext context,
    required WPArchive wp,
    required List<FloorModel> floorList,
  }) async {
    bool isAdded = false;
    try {
      List<Map<String, dynamic>> x = await supaInstCLient
          .from('wp_archive')
          .insert(wp.toJson())
          .select();
      Get.log(x.toString());
      WPArchive y1 = WPArchive.fromJson(x[0]);
      int licence_id = y1.id ?? -1;
      if (licence_id != -1) {
        // Get.log(licence_id.toString());
        floorList.forEach((e1) {
          e1.workingPermissionId = licence_id.toString();
        });

        List<dynamic> floorJson = floorList.map((e2) => e2.toJson()).toList();
        List<Map<String, dynamic>> f = await supaInstCLient
            .from('floors_wp')
            .insert(floorJson)
            .select();
        Get.log(f.toString());
        isAdded = true;
        // return isAdded;
      }
      // try {
    } catch (e) {
      Get.log(e.toString());
      isAdded = false;
      show_snackBar(context, ConstantsData.absentClr, 'Error to Add WP'.tr);
    } finally {
      return isAdded;
    }
  }

  static Future<List<BuildLicenseModel>?> search_buildings_licence({
    required BuildContext context,
    String? searchText,
  }) async {
    List<BuildLicenseModel> returnLicenced = [];
    // try {
    List<Map<String, dynamic>>
    // var
    // List<dynamic> x =
    //  await supaInstCLient
    // List<json>
    x = await supaInstCLient
        .from('build_license_table')
        .select()
        .like('licence_city', '%${searchText?.trim()}%')
    // .eq('licence_city', '${searchText}')
    // .limit(50)
    ;
    Get.log(x.toString());
    if (x.isNotEmpty) {
      returnLicenced = x.map((e) => BuildLicenseModel.fromJson(e)).toList();
      // x.forEach((element) {
      //   print(element.toString());
      //   // returnLicenced
      //   //     .add(BuildLicenseModel.fromJson(jsonDecode(jsonEncode(element))));
      // });
      // final parsed =
      //     jsonDecode(x.toString()).cast();
      // returnLicenced = parsed
      //     .map<BuildLicenseModel>((json) => BuildLicenseModel.fromJson(json))
      //     .toList();
    } else {
      Get.log('Empty');
    }
    try {} catch (e) {
      Get.log(e.toString());
      show_snackBar(
        context,
        ConstantsData.absentClr,
        'Error to retrieve Build Licence'.tr,
      );
    } finally {
      return returnLicenced;
    }
  }

  static Future<List<WPModel>?> search_wp({
    required BuildContext context,
    String? searchText,
  }) async {
    List<WPModel> returnLicenced = [];
    // try {
    List<Map<String, dynamic>> x = await supaInstCLient
        .from('wp_table')
        .select()
        .like('licence_city', '%${searchText?.trim()}%')
    // .eq('licence_city', '${searchText}')
    // .limit(50)
    ;
    Get.log(x.toString());
    if (x.isNotEmpty) {
      returnLicenced = x.map((e) => WPModel.fromJson(e)).toList();
    } else {
      Get.log('Empty');
    }
    try {} catch (e) {
      Get.log(e.toString());
      show_snackBar(
        context,
        ConstantsData.absentClr,
        'Error to retrieve Build Licence'.tr,
      );
    } finally {
      return returnLicenced;
    }
  }

  static Future<List<FloorModel>?> search_buildLicence_floors({
    required BuildContext context,
    required int id,
  }) async {
    List<FloorModel> returnFloors = [];
    // try {
    List<Map<String, dynamic>> x = await supaInstCLient
        .from('floors')
        .select()
        .eq('build_licence_id', id.toString())
    // .eq('licence_city', '${searchText}')
    // .limit(50)
    ;
    Get.log(x.toString());
    if (x.isNotEmpty) {
      returnFloors = x.map((e) => FloorModel.fromJson(e)).toList();
    } else {
      Get.log('Empty');
    }
    try {} catch (e) {
      Get.log(e.toString());
      show_snackBar(
        context,
        ConstantsData.absentClr,
        'Error to retrieve Build Licence Floors'.tr,
      );
    } finally {
      return returnFloors;
    }
  }

  static Future<List<FloorModel>?> search_wp_floors({
    required BuildContext context,
    required int id,
  }) async {
    List<FloorModel> returnFloors = [];
    // try {
    List<Map<String, dynamic>> x = await supaInstCLient
        .from('wp_floors')
        .select()
        .eq('working_permission_id', id.toString())
    // .eq('licence_city', '${searchText}')
    // .limit(50)
    ;
    Get.log(x.toString());
    if (x.isNotEmpty) {
      returnFloors = x.map((e) => FloorModel.fromJson(e)).toList();
    } else {
      Get.log('Empty');
    }
    try {} catch (e) {
      Get.log(e.toString());
      show_snackBar(
        context,
        ConstantsData.absentClr,
        'Error to retrieve Build Licence Floors'.tr,
      );
    } finally {
      return returnFloors;
    }
  }

  static Future<List<RoleModel>?> get_roles_list({
    required BuildContext context,
  }) async {
    List<RoleModel> returnRoles = [];
    // try {
    List<Map<String, dynamic>> x = await supaInstCLient.from('roles').select()
    // .like('licence_city', '%${searchText?.trim()}%')
    // .eq('licence_city', '${searchText}')
    // .limit(50)
    ;
    Get.log(x.toString());
    if (x.isNotEmpty) {
      returnRoles = x.map((e) => RoleModel.fromJson(e)).toList();
      ConstantsData.rolesList = returnRoles ?? [];
    } else {
      Get.log('Empty');
    }
    try {} catch (e) {
      Get.log(e.toString());
      show_snackBar(
        context,
        ConstantsData.absentClr,
        'Error to retrieve roles list'.tr,
      );
    } finally {
      return returnRoles;
    }
  }

  static Future<List<UserRoleModel>?> get_roles_for_user({
    required BuildContext context,
    required String user_email,
    bool assignConstRoleList = true,
    bool allstate = false,
  }) async {
    List<UserRoleModel> userRolesList = [];
    if (assignConstRoleList) ConstantsData.userGrantedRoles = [];
    // try {
    List<Map<String, dynamic>> x = !allstate
        ? await supaInstCLient
              .from('users_role')
              .select()
              .eq('user_name', user_email)
              .eq('active', true)
        : await supaInstCLient
              .from('users_role')
              .select()
              .eq('user_name', user_email);
    // .eq('licence_city', '${searchText}')

    // .limit(50)
    ;
    Get.log(x.toString());
    if (x.isNotEmpty) {
      userRolesList = x.map((e) => UserRoleModel.fromJson(e)).toList();
      if (assignConstRoleList == true)
        ConstantsData.userGrantedRoles = userRolesList ?? [];
    } else {
      Get.log('Empty');
    }
    try {} catch (e) {
      Get.log(e.toString());
      show_snackBar(
        context,
        ConstantsData.absentClr,
        'Error to retrieve user granted roles'.tr,
      );
    } finally {
      return userRolesList;
    }
  }

  static Future<(UserRoleModel?, bool)> insertUserRoles({
    required BuildContext context,
    required UserRoleModel myRole,
  }) async {
    bool isAdded = false;
    UserRoleModel? returnResp;
    try {
      List<Map<String, dynamic>> x = await supaInstCLient
          .from('users_role')
          .insert(myRole.toJson())
          .select();
      Get.log(x.toString());
      returnResp = UserRoleModel.fromJson(x[0]);
      isAdded = true;

      // try {
    } catch (e) {
      Get.log(e.toString());
      isAdded = false;
      show_snackBar(
        context,
        ConstantsData.absentClr,
        'Error to add user roles'.tr,
      );
    } finally {
      return (returnResp, isAdded);
    }
  }

  static Future<(DiwanClass?, bool)> insertDiwanClass({
    required BuildContext context,
    required DiwanClass diwanClassObj,
    bool isInsert = true,
  }) async {
    bool isAdded = false;
    DiwanClass? returnResp;
    try {
      List<Map<String, dynamic>> x = isInsert
          ? (isInsert
                ? await supaInstCLient
                      .from('diwan_classes')
                      .insert(diwanClassObj.toJson())
                      .select()
                : await supaInstCLient
                      .from('diwan_classes')
                      .update(diwanClassObj.toJson())
                      .eq('id', diwanClassObj.id as Object)
                      .select())
          : (await supaInstCLient
                .from('diwan_classes')
                .update(diwanClassObj.toJson())
                .eq('id', diwanClassObj.id as Object)
                .select());
      Get.log(x.toString());
      returnResp = DiwanClass.fromJson(x[0]);
      isAdded = true;

      // try {
    } catch (e) {
      Get.log(e.toString());
      isAdded = false;
      show_snackBar(
        context,
        ConstantsData.absentClr,
        'Error to add DiwanClass'.tr,
      );
    } finally {
      return (returnResp, isAdded);
    }
  }

  static Future<(Complaints?, bool)> insertComplaints({
    required BuildContext context,
    required Complaints complaintObj,
    bool isInsert = true,
  }) async {
    bool isAdded = false;
    Complaints? returnResp;
    try {
      List<Map<String, dynamic>> x = isInsert
          ? await supaInstCLient
                .from('complaints')
                .insert(complaintObj.toJson())
                .select()
          : await supaInstCLient
                .from('complaints')
                .update(complaintObj.toJson())
                .eq('id', complaintObj.id as Object)
                .select();
      Get.log(x.toString());
      returnResp = Complaints.fromJson(x[0]);
      isAdded = true;

      // try {
    } catch (e) {
      Get.log(e.toString());
      isAdded = false;
      show_snackBar(
        context,
        ConstantsData.absentClr,
        'Error to add complaints'.tr,
      );
    } finally {
      return (returnResp, isAdded);
    }
  }

  static Future<(CaseProcedure?, bool)> insertUpdateCaseProcedure({
    required BuildContext context,
    required CaseProcedure caseProcedureObj,
    bool isInsert = true,
  }) async {
    bool isAdded = false;
    CaseProcedure? returnResp;
    try {
      List<Map<String, dynamic>> x = isInsert
          ? await supaInstCLient
                .from('tandeem_procedures')
                .insert(caseProcedureObj.toJson())
                .select()
          : await supaInstCLient
                .from('tandeem_procedures')
                .update(caseProcedureObj.toJson())
                .eq('id', caseProcedureObj.id as Object)
                .select();
      Get.log(x.toString());
      returnResp = CaseProcedure.fromJson(x[0]);
      isAdded = true;

      // try {
    } catch (e) {
      Get.log(e.toString());
      isAdded = false;
      show_snackBar(
        context,
        ConstantsData.absentClr,
        'Error to add or update case procedure'.tr,
      );
    } finally {
      return (returnResp, isAdded);
    }
  }

  static Future<bool> deleteUpdateUserRoles({
    required BuildContext context,
    required UserRoleModel myRole,
    required bool activeState,
  }) async {
    bool isDeleted = false;
    UserRoleModel? returnResp;
    try {
      Get.log(myRole.toJson().toString());
      List<Map<String, dynamic>> x = await supaInstCLient
          .from('users_role')
          .update({'active': activeState})
          .match({
            'active': myRole.active.toString(),
            'role_id': myRole.roleId.toString(),
            'user_name': myRole.userName.toString(),
          })
          .select();
      returnResp = UserRoleModel.fromJson(x[0]);
      // .execute();
      Get.log(x.toString());
      // returnResp = UserRoleModel.fromJson(x[0]);
      if (x.length > 0)
        isDeleted = true;
      else
        log(x.length.toString() + ' number of updated rows');

      // try {
    } catch (e) {
      Get.log(e.toString());
      isDeleted = false;
      show_snackBar(
        context,
        ConstantsData.absentClr,
        'Error to add user roles'.tr,
      );
    } finally {
      return isDeleted;
    }
  }

  static Future<bool> deleteUserRoles({
    required BuildContext context,
    required UserRoleModel myRole,
  }) async {
    bool isDeleted = false;
    UserRoleModel? returnResp;
    try {
      // dynamic x = await supaInstCLient
      //     .from('users_role')
      //     .delete()
      //     .eq('user_name', myRole.userName)
      //     .eq('active', myRole.active)
      //     .eq('role_id', myRole.roleId.toString());
      Get.log(myRole.toJson().toString());
      List<Map<String, dynamic>> x =
          await supaInstCLient.from('users_role').delete().match({
            'active': myRole.active.toString(),
            'role_id': myRole.roleId.toString(),
            'user_name': myRole.userName.toString(),
          }).select();
      // returnResp = UserRoleModel.fromJson(x[0]);
      // .execute();
      Get.log(x.toString());
      // returnResp = UserRoleModel.fromJson(x[0]);
      isDeleted = true;

      // try {
    } catch (e) {
      Get.log(e.toString());
      isDeleted = false;
      show_snackBar(
        context,
        ConstantsData.absentClr,
        'Error to add user roles'.tr,
      );
    } finally {
      return isDeleted;
    }
  }

  static Future<List<BuildLicenseModel>?> get_search_build_licences_archive({
    required BuildContext context,
    required Map<String, Object> query,
    required int pageNumber,
    required int pageSize,
  }) async {
    List<BuildLicenseModel> returnBL = [];
    try {
      // SupabaseQueryBuilder queryBuilder=  supaInstCLient.from('diwan').select().match(query);
      List<Map<String, dynamic>> x = await supaInstCLient
          .from('building_archive')
          .select()
          .match(query)
          .range((pageNumber - 1) * pageSize, (pageNumber * pageSize) - 1)
          .order('id', ascending: false);
      //.limit(500);

      Get.log(x.toString());
      if (x.isNotEmpty) {
        returnBL = x.map((e) => BuildLicenseModel.fromJson(e)).toList();
      } else {
        Get.log('Empty build licenses');
      }
      // try {
    } catch (e) {
      Get.log(e.toString());
      show_snackBar(
        context,
        ConstantsData.absentClr,
        'Error to retrieve BuildLicenses archive'.tr,
      );
    } finally {
      return returnBL;
    }
  }

  static Future<List<BuildLicenseModel>?> get_search_build_archive_with_filter({
    required BuildContext context,
    // required Map<String, Object> query,
    required String filterCol,
    String filterOperator = 'contains',
    String? filterValue,
    required int pageNumber,
    required int pageSize,
  }) async {
    List<BuildLicenseModel> returnBL = [];
    try {
      // SupabaseQueryBuilder queryBuilder=  supaInstCLient.from('diwan').select().match(query);
      List<Map<String, dynamic>> x = await supaInstCLient
          .from('building_archive')
          .select()
          // .contains(filterCol, filterValue ?? 'NULL')
          .textSearch(filterCol, filterValue ?? '')
          // .filter(filterCol, filterOperator, filterValue)
          .range((pageNumber - 1) * pageSize, (pageNumber * pageSize) - 1)
          .order('id', ascending: false);
      //.limit(500);

      Get.log(x.toString());
      if (x.isNotEmpty) {
        returnBL = x.map((e) => BuildLicenseModel.fromJson(e)).toList();
      } else {
        Get.log('Empty');
      }
      // try {
    } catch (e) {
      Get.log(e.toString());
      show_snackBar(
        context,
        ConstantsData.absentClr,
        'Error to retrieve building_archive'.tr,
      );
    } finally {
      return returnBL;
    }
  }

  static Future<int?> get_diwan_count({
    required BuildContext context,
    required Map<String, Object> query,
  }) async {
    int? dataCount;
    try {
      // SupabaseQueryBuilder queryBuilder=  supaInstCLient.from('diwan').select().match(query);
      PostgrestResponse<List<Map<String, dynamic>>> x = await supaInstCLient
          .from('diwan')
          .select()
          .count();
      //.limit(500);

      Get.log(x.toString());
      Get.log(x.toString());
      Get.log(x.data.toString());

      Get.log(x.count.toString());

      if (x.data != null) {
        dataCount =
            x.count; // returnDiwan = x.map((e) => Diwan.fromJson(e)).toList();
      } else {
        Get.log('Empty');
      }
      // try {
    } catch (e) {
      Get.log(e.toString());
      show_snackBar(
        context,
        ConstantsData.absentClr,
        'Error to retrieve diwan'.tr,
      );
    } finally {
      return dataCount;
    }
  }

  static Future<List<Diwan>?> get_search_diwan({
    required BuildContext context,
    required Map<String, Object> query,
    required int pageNumber,
    required int pageSize,
  }) async {
    List<Diwan> returnDiwan = [];
    try {
      // SupabaseQueryBuilder queryBuilder=  supaInstCLient.from('diwan').select().match(query);
      List<Map<String, dynamic>> x = await supaInstCLient
          .from('diwan')
          .select()
          .match(query)
          .range((pageNumber - 1) * pageSize, (pageNumber * pageSize) - 1)
          .order('id', ascending: false);
      //.limit(500);

      Get.log(x.toString());
      if (x.isNotEmpty) {
        returnDiwan = x.map((e) => Diwan.fromJson(e)).toList();
      } else {
        Get.log('Empty');
      }
      // try {
    } catch (e) {
      Get.log(e.toString());
      show_snackBar(
        context,
        ConstantsData.absentClr,
        'Error to retrieve diwan'.tr,
      );
    } finally {
      return returnDiwan;
    }
  }

  static Future<List<Diwan>?> get_search_diwan_with_filter({
    required BuildContext context,
    // required Map<String, Object> query,
    required String filterCol,
    String filterOperator = 'contains',
    String? filterValue,
    required int pageNumber,
    required int pageSize,
  }) async {
    List<Diwan> returnDiwan = [];
    try {
      // SupabaseQueryBuilder queryBuilder=  supaInstCLient.from('diwan').select().match(query);
      List<Map<String, dynamic>> x = await supaInstCLient
          .from('diwan')
          .select()
          // .contains(filterCol, filterValue ?? 'NULL')
          .textSearch(filterCol, filterValue ?? '')
          // .filter(filterCol, filterOperator, filterValue)
          .range((pageNumber - 1) * pageSize, (pageNumber * pageSize) - 1)
          .order('id', ascending: false);
      //.limit(500);

      Get.log(x.toString());
      if (x.isNotEmpty) {
        returnDiwan = x.map((e) => Diwan.fromJson(e)).toList();
      } else {
        Get.log('Empty');
      }
      // try {
    } catch (e) {
      Get.log(e.toString());
      show_snackBar(
        context,
        ConstantsData.absentClr,
        'Error to retrieve diwan'.tr,
      );
    } finally {
      return returnDiwan;
    }
  }

  static Future<List<WorkPerDay>?> get_diwan_static_work_by_day({
    required BuildContext context,
    required String function_name,
    // required Map<String, Object> query,
  }) async {
    List<WorkPerDay> diwanData = [];
    try {
      // SupabaseQueryBuilder queryBuilder=  supaInstCLient.from('diwan').select().match(query);
      // List<Map<String, dynamic>>
      List<Map<String, dynamic>> x = await supaInstCLient.rpc(function_name);
      //.limit(500);

      Get.log(x.toString());
      if (x.isNotEmpty) {
        diwanData = x.map((e) => WorkPerDay.fromJson(e)).toList();
        // x.forEach((element) {
        //   debugPrint(element.toString());
        // });
      } else {
        Get.log('Empty');
      }

      // try {
    } catch (e) {
      Get.log(e.toString());
      show_snackBar(
        context,
        ConstantsData.absentClr,
        'Error to retrieve PRC ${function_name}'.tr,
      );
    } finally {
      return diwanData;
    }
  }

  static Future<List<StatisticData>?> get_diwan_static_data({
    required BuildContext context,
    required String function_name,
    // required Map<String, Object> query,
  }) async {
    List<StatisticData> diwanData = [];
    try {
      // SupabaseQueryBuilder queryBuilder=  supaInstCLient.from('diwan').select().match(query);
      // List<Map<String, dynamic>>
      List<Map<String, dynamic>> x = await supaInstCLient.rpc(function_name);
      //.limit(500);

      Get.log(x.toString());
      if (x.isNotEmpty) {
        diwanData = x.map((e) => StatisticData.fromJson(e)).toList();
        // x.forEach((element) {
        //   debugPrint(element.toString());
        // });
      } else {
        Get.log('Empty');
      }
      // try {
    } catch (e) {
      Get.log(e.toString());
      show_snackBar(
        context,
        ConstantsData.absentClr,
        'Error to retrieve PRC ${function_name}'.tr,
      );
    } finally {
      return diwanData;
    }
  }

  static Future<List<Diwan>?> get_diwan_nulls({
    required BuildContext context,
    required String function_name,
    // required Map<String, Object> query,
  }) async {
    List<Diwan> diwanData = [];
    try {
      // SupabaseQueryBuilder queryBuilder=  supaInstCLient.from('diwan').select().match(query);
      // List<Map<String, dynamic>>
      List<Map<String, dynamic>> x = await supaInstCLient.rpc(function_name);
      //.limit(500);

      Get.log(x.toString());
      List<dynamic> y = x[0]['user_data'];
      if (y.isNotEmpty) {
        diwanData = y.map((e) => Diwan.fromJson(e)).toList();
        // x.forEach((element) {
        //   debugPrint(element.toString());
        // });
      } else {
        Get.log('Empty');
      }
      // try {
    } catch (e) {
      Get.log(e.toString());
      show_snackBar(
        context,
        ConstantsData.absentClr,
        'Error to retrieve PRC ${function_name}'.tr,
      );
    } finally {
      return diwanData;
    }
  }

  static Future<List<Estemlakat>?> get_estemlakat_nulls({
    required BuildContext context,
    required String function_name,
    // required Map<String, Object> query,
  }) async {
    List<Estemlakat> ESTData = [];
    try {
      // SupabaseQueryBuilder queryBuilder=  supaInstCLient.from('diwan').select().match(query);
      // List<Map<String, dynamic>>
      List<Map<String, dynamic>> x = await supaInstCLient.rpc(function_name);
      //.limit(500);

      Get.log(x.toString());
      List<dynamic> y = x[0]['user_data'];
      if (y.isNotEmpty) {
        ESTData = y.map((e) => Estemlakat.fromJson(e)).toList();
        // x.forEach((element) {
        //   debugPrint(element.toString());
        // });
      } else {
        Get.log('Empty');
      }
      // try {
    } catch (e) {
      Get.log(e.toString());
      show_snackBar(
        context,
        ConstantsData.absentClr,
        'Error to retrieve PRC ${function_name}'.tr,
      );
    } finally {
      return ESTData;
    }
  }

  static Future<WorkPerDay?> get_diwan_PRC_parms({
    required BuildContext context,
    required String function_name,
    required String email,
    // required Map<String, Object> query,
  }) async {
    List<WorkPerDay> diwanData = [];
    try {
      // SupabaseQueryBuilder queryBuilder=  supaInstCLient.from('diwan').select().match(query);
      // List<Map<String, dynamic>>
      List<Map<String, dynamic>> x = await supaInstCLient.rpc(
        function_name,
        params: {'email_par': email},
      );
      //.limit(500);

      Get.log(x.toString());
      if (x.isNotEmpty) {
        diwanData = x.map((e) => WorkPerDay.fromJson(e)).toList();
        // x.forEach((element) {
        //   debugPrint(element.toString());
        // });
      } else {
        Get.log('Empty');
      }
      // try {
    } catch (e) {
      Get.log(e.toString());
      show_snackBar(
        context,
        ConstantsData.absentClr,
        'Error to retrieve PRC ${function_name}'.tr,
      );
    } finally {
      return diwanData.isNotEmpty
          ? diwanData[0]
          : WorkPerDay(dateDay: '', email: ' ', count: 0);
    }
  }

  static Future<List<Diwan>?> get_search_my_diwan({
    required BuildContext context,
    String? department_id,
  }) async {
    List<Diwan> returnDiwan = [];
    try {
      // SupabaseQueryBuilder queryBuilder=  supaInstCLient.from('diwan').select().match(query);
      List<Map<String, dynamic>> x = await supaInstCLient
          .from('diwan')
          .select()
          .eq('department_id', department_id as Object)
          .limit(1000);

      Get.log(x.toString());
      if (x.isNotEmpty) {
        returnDiwan = x.map((e) => Diwan.fromJson(e)).toList();
      } else {
        Get.log('Empty');
      }
      // try {
    } catch (e) {
      Get.log(e.toString());
      show_snackBar(
        context,
        ConstantsData.absentClr,
        'Error to retrieve diwan'.tr,
      );
    } finally {
      return returnDiwan;
    }
  }

  static Future<List<Complaints>?> get_search_complaints({
    required BuildContext context,
    String? searchText,
    String? department_id,
  }) async {
    List<Complaints> returnComp = [];
    // try {
    List<Map<String, dynamic>> x = searchText != null
        ? await supaInstCLient
              .from('complaints')
              .select()
              .like('comp_area', '%${searchText?.trim()}%')
              .order('created_at', ascending: false)
              // .eq('licence_city', '${searchText}')
              .limit(100)
        : (department_id != null)
        ? await supaInstCLient
              .from('complaints')
              .select()
              .eq('department_id', department_id)
              .order('created_at', ascending: false)
              .limit(100)
        : await supaInstCLient
              .from('complaints')
              .select()
              .order('created_at', ascending: false)
              // .like('licence_city', '%${searchText?.trim()}%')
              // .eq('licence_city', '${searchText}')
              .limit(200);
    Get.log(x.toString());
    if (x.isNotEmpty) {
      returnComp = x.map((e) => Complaints.fromJson(e)).toList();
    } else {
      Get.log('Empty');
    }
    try {} catch (e) {
      Get.log(e.toString());
      show_snackBar(
        context,
        ConstantsData.absentClr,
        'Error to retrieve complantes'.tr,
      );
    } finally {
      return returnComp;
    }
  }

  static Future<List<Complaints>?> get_search_complaints_filters({
    required BuildContext context,
    String? searchText,
    String? region,
    String? landNumber,
    String? status,
  }) async {
    List<Complaints> returnComp = [];
    try {
      Map<String, Object> filterJson = Map();
      if (region != null) filterJson.addAll({'comp_area': region});
      if (landNumber != null)
        filterJson.addAll({'comp_land_number': landNumber.toString()});
      if (status != null) filterJson.addAll({'comp_status': status});

      List<Map<String, dynamic>> x = filterJson.length > 0
          ? await supaInstCLient
                .from('complaints')
                .select()
                // .like('comp_area', '%${searchText?.trim()}%')
                .match(filterJson)
                // .eq('comp_land_number', landNumber ?? '')
                // .eq('comp_status', status ?? '')
                .limit(50)
          : await supaInstCLient
                .from('complaints')
                .select()
                // .eq('comp_area', region)
                // .eq('comp_land_number', landNumber)
                // .eq('comp_status', status ?? 0)
                .limit(200);
      Get.log(x.toString());
      if (x.isNotEmpty) {
        returnComp = x.map((e) => Complaints.fromJson(e)).toList();
      } else {
        Get.log('Empty');
      }
    } catch (e) {
      Get.log(e.toString());
      show_snackBar(
        context,
        ConstantsData.absentClr,
        'Error to retrieve complantes'.tr,
      );
    } finally {
      return returnComp;
    }
  }

  static Future<List<CaseProcedure>?> get_procedures_case_list({
    required BuildContext context,
    required String case_id,
    required String case_type,
  }) async {
    List<CaseProcedure> caseProceduresList = [];
    // try {
    List<Map<String, dynamic>> x = await supaInstCLient
        .from('case_procedurs')
        .select()
        .eq('case_id', case_id)
        .eq('case_type', case_type);

    Get.log(x.toString());
    if (x.isNotEmpty) {
      caseProceduresList = x.map((e) => CaseProcedure.fromJson(e)).toList();
    } else {
      Get.log('Empty');
    }
    try {} catch (e) {
      Get.log(e.toString());
      show_snackBar(
        context,
        ConstantsData.absentClr,
        'Error to retrieve case procedures'.tr,
      );
    } finally {
      return caseProceduresList;
    }
  }

  static Future<List<Department>?> get_departments_list({
    required BuildContext context,
  }) async {
    List<Department> departmentsList = [];
    try {
      List<Map<String, dynamic>> x = await supaInstCLient
          .from('department')
          .select();

      Get.log(x.toString());
      if (x.isNotEmpty) {
        departmentsList = x.map((e) => Department.fromJson(e)).toList();
        if (departmentsList.isNotEmpty)
          ConstantsData.departments = departmentsList;
      } else {
        Get.log('Empty');
      }
      // try {
    } catch (e) {
      Get.log(e.toString());
      show_snackBar(
        context,
        ConstantsData.absentClr,
        'Error to retrieve departments'.tr,
      );
    } finally {
      return departmentsList;
    }
  }

  // static Future<List<T>?> get_generic_list<T extends DataGenericModel<T>>({
  //   required BuildContext context,
  // }) async {
  //   List<T> genericList = [];
  //   try {
  //     List<Map<String, dynamic>> x = await supaInstCLient
  //         .from('department')
  //         .select();

  //     Get.log(x.toString());
  //     if (x.isNotEmpty) {
  //       genericList = x.map((e) => T.fromJson(e)).toList();
  //       // if (genericList.isNotEmpty)
  //       // ConstantsData.departments = departmentsList;
  //     } else {
  //       Get.log('Empty');
  //     }
  //   } catch (e) {
  //     Get.log(e.toString());
  //     show_snackBar(
  //         context, ConstantsData.absentClr, 'Error to retrieve departments'.tr);
  //   } finally {
  //     return genericList;
  //   }
  // }

  static Future<List<DiwanClass>?> get_diwan_classes({
    required BuildContext context,
  }) async {
    List<DiwanClass> diwanCLassesList = [];
    // try {
    List<Map<String, dynamic>> x = await supaInstCLient
        .from('diwan_classes')
        .select();

    Get.log(x.toString());
    if (x.isNotEmpty) {
      diwanCLassesList = x.map((e) => DiwanClass.fromJson(e)).toList();
      if (diwanCLassesList.isNotEmpty)
        ConstantsData.diwanCLassesList = diwanCLassesList;
    } else {
      Get.log('Empty');
    }
    try {} catch (e) {
      Get.log(e.toString());
      show_snackBar(
        context,
        ConstantsData.absentClr,
        'Error to retrieve diwanCLassesList'.tr,
      );
    } finally {
      return diwanCLassesList;
    }
  }

  static Future<List<SettingModel>?> get_settings({
    required BuildContext context,
  }) async {
    List<SettingModel> settingsList = [];
    try {
      List<Map<String, dynamic>> x = await supaInstCLient
          .from('settings')
          .select();

      Get.log(x.toString());
      if (x.isNotEmpty) {
        settingsList = x.map((e) => SettingModel.fromJson(e)).toList();
        if (settingsList.isNotEmpty) ConstantsData.settingsList = settingsList;
      } else {
        Get.log('Empty');
      }
    } catch (e) {
      Get.log(e.toString());
      show_snackBar(
        context,
        ConstantsData.absentClr,
        'Error to retrieve settingsList'.tr,
      );
    } finally {
      return settingsList;
    }
  }

  static Future<bool> get_user_data({
    required BuildContext context,
    required String user_email,
  }) async {
    bool isGet = false;
    List<UserModel> _users;
    // try {
    List<Map<String, dynamic>> x = await supaInstCLient
        .from('user_pc_auth')
        .select()
        .eq('user_email', user_email);

    Get.log(x.toString());
    if (x.isNotEmpty) {
      _users = x.map((e) => UserModel.fromJson(e)).toList();
      if (_users.length > 0) ConstantsData.currentUser = _users[0];
      isGet = true;
    } else {
      Get.log('Empty');
    }
    try {} catch (e) {
      Get.log(e.toString());
      show_snackBar(
        context,
        ConstantsData.absentClr,
        'Error to retrieve user data'.tr,
      );
    } finally {
      return isGet;
    }
  }

  static Future<bool> get_user_in_department({
    required BuildContext context,
    String? department_id,
  }) async {
    print(ConstantsData.currentUser?.userEmail.toString() ?? ' nn');
    bool isGet = false;
    try {
      List<Map<String, dynamic>> x = await supaInstCLient
          .from('user_pc_auth')
          .select()
          .eq(
            'department_id',
            department_id ?? ConstantsData.currentUser?.departmentId as Object,
          )
          .eq('active', true);

      Get.log(x.toString());
      if (x.isNotEmpty) {
        ConstantsData.departmentsUser = x
            .map((e) => UserModel.fromJson(e))
            .toList();
        isGet = true;
      } else {
        Get.log('Empty');
      }
      // try {
    } catch (e) {
      Get.log(e.toString());
      show_snackBar(
        context,
        ConstantsData.absentClr,
        'Error to retrieve department  user'.tr,
      );
    } finally {
      return isGet;
    }
  }

  static Future get_users_list() async {
    ConstantsData.listUsers =
        await get_Table<UserModel>(
          context: Get.context!,
          query: {
            // 'department_id': 4
          },
          pageNumber: 1,
          pageSize: 400,
          table_name: 'user_pc_auth',
          fromJson: UserModel.fromJson,
        ) ??
        [];
  }

  static Future<(Diwan?, bool)> insertUpdateDiwan({
    required BuildContext context,
    required Diwan diwanObj,
    bool isInsert = true,
  }) async {
    bool isAdded = false;
    Diwan? returnResp;
    try {
      List<Map<String, dynamic>> x = isInsert
          ? await supaInstCLient
                .from('diwan')
                .insert(diwanObj.toJson())
                .select()
          : await supaInstCLient
                .from('diwan')
                .update(diwanObj.toJson())
                .eq('id', diwanObj.id.toString())
                .select();
      Get.log(x.toString());
      returnResp = Diwan.fromJson(x[0]);
      isAdded = true;

      // try {
    } catch (e) {
      Get.log(e.toString());
      isAdded = false;
      show_snackBar(context, ConstantsData.absentClr, 'Error to add diwan'.tr);
    } finally {
      return (returnResp, isAdded);
    }
  }

  static Future<(Tandeem?, bool)> insertUpdateTandeem({
    required BuildContext context,
    required Tandeem tandeemObj,
    bool isInsert = true,
  }) async {
    bool isAdded = false;
    Tandeem? returnResp;
    try {
      List<Map<String, dynamic>> x = isInsert
          ? await supaInstCLient
                .from('tandeem')
                .insert(tandeemObj.toJson())
                .select()
          : await supaInstCLient
                .from('tandeem')
                .update(tandeemObj.toJson())
                .eq('id', tandeemObj.id.toString())
                .select();
      Get.log(x.toString());
      returnResp = Tandeem.fromJson(x[0]);
      isAdded = true;

      // try {
    } catch (e) {
      Get.log(e.toString());
      isAdded = false;
      show_snackBar(
        context,
        ConstantsData.absentClr,
        'Error to add tandheem'.tr,
      );
    } finally {
      return (returnResp, isAdded);
    }
  }

  static Future<(Estemlakat?, bool)> insertUpdateEST({
    required BuildContext context,
    required Estemlakat estObj,
    bool isInsert = true,
  }) async {
    bool isAdded = false;
    Estemlakat? returnResp;
    try {
      List<Map<String, dynamic>> x = isInsert
          ? await supaInstCLient
                .from('estemlakat2')
                .insert(estObj.toJson())
                .select()
          : await supaInstCLient
                .from('estemlakat2')
                .update(estObj.toJson())
                .eq('id', estObj.id.toString())
                .select();
      Get.log(x.toString());
      returnResp = Estemlakat.fromJson(x[0]);
      isAdded = true;

      // try {
    } catch (e) {
      Get.log(e.toString());
      isAdded = false;
      show_snackBar(
        context,
        ConstantsData.absentClr,
        'Error to add Estemlakat'.tr,
      );
    } finally {
      return (returnResp, isAdded);
    }
  }

  static Future<List<Estemlakat>?> get_search_EST({
    required BuildContext context,
    required Map<String, Object> query,
    required int pageNumber,
    required int pageSize,
  }) async {
    List<Estemlakat> returnData = [];
    try {
      // SupabaseQueryBuilder queryBuilder=  supaInstCLient.from('diwan').select().match(query);
      List<Map<String, dynamic>> x = await supaInstCLient
          .from('estemlakat2')
          .select()
          .match(query)
          .range((pageNumber - 1) * pageSize, (pageNumber * pageSize) - 1)
          .order('creation_date', ascending: false);
      //.limit(500);

      Get.log(x.toString());
      if (x.isNotEmpty) {
        returnData = x.map((e) => Estemlakat.fromJson(e)).toList();
      } else {
        Get.log('Empty');
      }
      // try {
    } catch (e) {
      Get.log(e.toString());
      show_snackBar(
        context,
        ConstantsData.absentClr,
        'Error to retrieve Estemlakat'.tr,
      );
    } finally {
      return returnData;
    }
  }

  static Future<String?> sendSMS({
    required String mobile_number,
    required String msg,
  }) async {
    Map<String, String> map = {
      'login_name': 'westirbid',
      'login_password': 'Muni@irbid27',
      'msg': msg,
      'mobile_number': mobile_number, //'962795358369,962785733110',
      'from': 'W.IrbidMuni',
      'charset': 'UTF-8',
    };
    String? apiRes = await (CustomApi.SpeedApi(
      path: '/http/send_sms_http.php',
      customBaseUrl: 'https://sendsms.ngt.jo',
      urlParameters: map,
    ));
    return apiRes;
    // calenderYears = CustomParser.listParser(res: apiRes, object: CalenderYear())
    //     .cast<CalenderYear>();
  }
}

abstract class DataGenericModel<T> {
  T? fromJson(Map<String, dynamic> e);
}
