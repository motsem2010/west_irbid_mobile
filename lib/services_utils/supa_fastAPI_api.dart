import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide FormData, MultipartFile;
import 'package:web_socket/web_socket.dart';
import 'package:west_irbid_mobile/models/diwan.dart';
import 'package:west_irbid_mobile/models/diwan_copy_to_model.dart';
import 'package:west_irbid_mobile/models/notification_data_object_model.dart';
import 'package:west_irbid_mobile/models/statistic_model.dart';
import 'package:west_irbid_mobile/models/user_model.dart';
import 'package:west_irbid_mobile/services_utils/constants.dart';
import 'package:west_irbid_mobile/services_utils/custom_apis_methods.dart';
import 'package:west_irbid_mobile/services_utils/custom_parser.dart';
import 'package:west_irbid_mobile/services_utils/endpoints.dart';
import 'package:west_irbid_mobile/services_utils/helper_methods.dart';
import 'package:west_irbid_mobile/services_utils/ui_helpers.dart';

class FastAPI_Api {
  static final String baseUrl = 'http://127.0.0.1:8000';

  Future<bool> login({
    String? user_email,
    String? password,
    // String? iqama,
    // String? verificationCode
  }) async {
    try {
      bool isLoged = false;

      // http.StreamedResponse response = await AuthApi.login(
      //     name, password, NotificationService.firebaseToken);
      int? statusCode = 0;
      String? responseBody;

      responseBody = await (CustomApi.SpeedApi(
        statusCode: (sc) => statusCode = sc,
        path: Endpoints.login,
        customBaseUrl: baseUrl,
        isPost: true,
        bodyParameters: {
          "user_email": user_email?.trim(),
          "password": password?.trim(),
          "user_name": user_email?.split('@')[0] ?? 'mazen',
        },
      ));
      debugPrint(responseBody);
      Map<String, dynamic> userData = jsonDecode(responseBody ?? '');

      /// in case of server error
      if (userData['detail'] != null) {
        // show(userData['deatails'] ?? ' ');
        HelperMethods.dialogView(
          context: Get.context!,
          message: userData['detail'],
          type: 1,
        );
        return isLoged;
      }

      // Map<String, dynamic> userData = jsonDecode(responseBody);
      CustomApi.userToken = userData['access_token'];
      ConstantsData.currentUser =
          await CustomParser.objectParser(
                res: responseBody ?? '',
                path: ['user'],
                object: UserModel(),
              )
              as UserModel;
      debugPrint('User id : ${ConstantsData.currentUser?.id}');

      /// if there's no token in the response then the user is not authorized
      if (ConstantsData.currentUser?.id != null &&
          CustomApi.userToken.isNotEmpty) {
        // saveUserInfo(user_email!, password!);
        isLoged = true;
        return isLoged;
      } else {
        // showToast('No user data or null token');
      }
      isLoged = false;
      return isLoged;

      // try {
      // write user data to prefs
    } catch (e) {
      debugPrint('AuthController login error:$e');
      return false;
    }
  }

  static Future<List<T>?> get_Table<T>({
    required BuildContext context,
    Map<String, Object>? query,
    required int pageNumber,
    required int pageSize,
    required String table_name,
    String? order_by_fields,
    bool ascending = false,
    String? query_string,
    required T Function(Map<String, dynamic>)
    fromJson, // Pass a fromJson function
  }) async {
    List<T> returnData = [];
    // try {
    int? statusCode = 0;

    String? responseBody;

    responseBody = await (CustomApi.SpeedApi(
      statusCode: (sc) => statusCode = sc,
      path: Endpoints.get_table + '/$table_name',
      customBaseUrl: baseUrl,
      isPost: false,
      urlParameters: {
        "page_number": pageNumber.toString(),
        "page_size": pageSize.toString(),
        if (query != null && query.isNotEmpty) "query": jsonEncode(query),
        if (query_string != null) "query_string": query_string,
        "order_by": (order_by_fields != null)
            ? '$order_by_fields ${ascending ? ' ASC' : ' DESC'}'
            : 'id DESC',
        // if (ascending != null) "ascending": ascending
      },
    ));
    debugPrint(responseBody);
    Map<String, dynamic> userData = jsonDecode(responseBody ?? '');

    // Get.log(userData.toString());
    if (userData['data'] != null) {
      List<dynamic> x = userData['data'];
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

  static Future<List<T>?> insert_Table_multiRec<T>({
    required BuildContext context,
    required String table_name,
    required T Function(Map<String, dynamic>) fromJson,
    required Map<String, dynamic> toJson,
    // required List<Map<String, dynamic>> toJson
  }) async {
    List<T> returnData = [];
    // try {
    int? statusCode = 0;

    String? responseBody;

    responseBody = await (CustomApi.SpeedApi(
      statusCode: (sc) => statusCode = sc,
      path: Endpoints.insert + '/$table_name',
      customBaseUrl: baseUrl,
      isPost: true,
      bodyParameters: toJson,
    ));
    debugPrint(responseBody);
    var userData = jsonDecode(responseBody ?? '');

    // Get.log(userData.toString());
    if (userData != null) {
      List<dynamic> x = userData;
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

  static Future<T?> insert_Table<T>({
    required BuildContext context,
    required String table_name,
    required T Function(Map<String, dynamic>) fromJson,
    required Map<String, dynamic> toJson,
    // required List<Map<String, dynamic>> toJson
  }) async {
    T returnData;
    // try {
    int? statusCode = 0;

    String? responseBody;

    responseBody = await (CustomApi.SpeedApi(
      statusCode: (sc) => statusCode = sc,
      path: Endpoints.insert_one + '/$table_name',
      customBaseUrl: baseUrl,
      isPost: true,
      bodyParameters: toJson,
    ));
    debugPrint(responseBody);
    // var userData = jsonDecode(responseBody ?? '');

    // // Get.log(userData.toString());
    // if (userData != null) {
    //   List<dynamic> x = userData;
    returnData = fromJson(jsonDecode(responseBody ?? ''));
    // } else {
    //   Get.log('Empty');
    // }
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
    int? statusCode = 0;

    String? responseBody;
    // try {
    responseBody = isInsert
        ? await (CustomApi.SpeedApi(
            statusCode: (sc) => statusCode = sc,
            path: Endpoints.insert_one + '/$table_name',
            customBaseUrl: baseUrl,
            isPost: true,
            bodyParameters: query,
          ))
        : await (CustomApi.SpeedApi(
            statusCode: (sc) => statusCode = sc,
            path: Endpoints.update_table + '/$table_name/$objId',
            customBaseUrl: baseUrl,
            isPost: true,
            isPut: true,
            bodyParameters: query,
          ));

    // var userData = jsonDecode(responseBody ?? '');
    // List<dynamic> x = userData;
    debugPrint(responseBody.toString());
    if (responseBody != null
    // && responseBody != 'حدث خطأ ما'
    ) {
      returnResp = fromJson(jsonDecode(responseBody ?? ''));
      isAdded = true;
    }

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

  static Future<(String?, bool)> getPublicUrl(String fileUrl) async {
    String? responseBody;
    int? statusCode;
    bool isSuccess = false;
    responseBody = await (CustomApi.SpeedApi(
      statusCode: (sc) => statusCode = sc,
      path: Endpoints.get_file_url,
      customBaseUrl: baseUrl,
      isPost: false,
      urlParameters: {
        "file_url": fileUrl,

        // if (ascending != null) "ascending": ascending
      },
    ));
    debugPrint(responseBody);
    Map<String, dynamic> userData = jsonDecode(responseBody ?? '');

    // Get.log(userData.toString());
    if (userData['temp_url'] != null && userData['status'] == 'success') {
      return ((baseUrl + userData['temp_url'].toString()), true);
    }
    if (userData['details'] != null) {
      return (userData['details'].toString(), false);
    }
    return (null, isSuccess);
  }

  static Future<List<WorkPerDay>?> get_work_per_day({
    required BuildContext context,
    required String date_col,
    required String email_col,
    required String table_name,
    String? filter_condition,
    // Pass a fromJson function
  }) async {
    List<WorkPerDay> returnData = [];
    try {
      int? statusCode = 0;

      String? responseBody;

      responseBody = await (CustomApi.SpeedApi(
        statusCode: (sc) => statusCode = sc,
        path: Endpoints.work_per_day + '/$table_name',
        customBaseUrl: baseUrl,
        isPost: false,
        urlParameters: {
          "date_col": date_col,
          "email_col": email_col,
          if (filter_condition != null && filter_condition.isNotEmpty)
            "filter_condition": filter_condition,
        },
      ));
      debugPrint(responseBody);
      List<dynamic> userData = jsonDecode(responseBody ?? '');

      // Get.log(userData.toString());

      // List<dynamic> x = userData;
      returnData = userData.map((e) => WorkPerDay.fromJson(e)).toList();

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

  static Future<List<StatisticData>?> get_work_statistics({
    required BuildContext context,
    required String group_col,
    required String table_name,
    String? filter_condition,
    // Pass a fromJson function
  }) async {
    List<StatisticData> returnData = [];
    try {
      int? statusCode = 0;

      String? responseBody;

      responseBody = await (CustomApi.SpeedApi(
        statusCode: (sc) => statusCode = sc,
        path: Endpoints.work_statistics + '/$table_name',
        customBaseUrl: baseUrl,
        isPost: false,
        urlParameters: {
          "group_col": group_col,
          if (filter_condition != null && filter_condition.isNotEmpty)
            "filter_condition": filter_condition,
        },
      ));
      debugPrint(responseBody);
      List<dynamic> userData = jsonDecode(responseBody ?? '');

      // Get.log(userData.toString());

      // List<dynamic> x = userData;
      returnData = userData.map((e) => StatisticData.fromJson(e)).toList();

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

  Future<(int? id, String? details)> register({
    required String user_name,
    required String password,
    required String user_email,
    required String pc_username,
    required String role_name_ar,
    required String department_name,
    required String mac_id,
  }) async {
    try {
      int? statusCode = 0;
      String? responseBody;

      responseBody = await CustomApi.SpeedApi(
        statusCode: (sc) => statusCode = sc,
        path: Endpoints.register,
        customBaseUrl: baseUrl,
        isPost: true,
        bodyParameters: {
          "user_name": user_name,
          "password": password,
          "user_email": user_email,
          "pc_username": pc_username,
          "role_name_ar": role_name_ar,
          "department_name": department_name,
          "mac_id": mac_id,
        },
      );

      var userData = json.decode(responseBody ?? '');

      if (userData['status'] == 'success') {
        return (userData['user_id'] as int?, userData['message']?.toString());
      } else if (userData['detail'] != null) {
        return (null, userData['detail'].toString());
      }

      return (null, "Unknown error occurred");
    } catch (e) {
      debugPrint('FastAPI_Api register error:$e');
      return (null, e.toString());
    }
  }

  static Future<int?> get_PRC_insert_wf_diwan_copyto({
    required Diwan diwanObj,
    required List<DiwanCopyTo> copyto_data,
    required BuildContext context,
  }) async {
    try {
      Map<String, dynamic> x = {
        "diwan_data": diwanObj.toJson(),
        "copyto_data": copyto_data.map((e) => e.toJson()).toList(),
      };
      int? statusCode = 0;
      String? responseBody;

      responseBody = await CustomApi.SpeedApi(
        statusCode: (sc) => statusCode = sc,
        path: Endpoints.insert_diwan_with_copyto,
        customBaseUrl: baseUrl,
        isPost: true,
        bodyParameters: x,
      );

      var userData = json.decode(responseBody ?? '');

      if (userData['status'] == 'success') {
        return userData['id'] as int?;
      } else if (userData['detail'] != null) {
        return null;
      }

      return null;
    } catch (e) {
      debugPrint('FastAPI_Api insert_diwan_with_copyto error:$e');
      return null;
    }
  }

  static Future<String?> upload_file({
    required String filePath,
    required String directory_name_to_save,
  }) async {
    try {
      Dio dio = Dio();
      FormData formData = FormData.fromMap({
        'directory_name_to_save': directory_name_to_save,
        'file': await MultipartFile.fromFile(filePath),
      });

      var response = await dio.post(
        '$baseUrl/upload_file',
        data: formData,
        options: Options(
          headers: {
            'accept': 'application/json',
            'Authorization': 'Bearer ${CustomApi.userToken}',
          },
        ),
      );

      dynamic responseData = response.data;
      if (responseData is String) {
        responseData = jsonDecode(responseData);
      }

      if (responseData['status'] == 'success') {
        return responseData['file_url']?.toString();
      }
      return 'error';
    } on DioException catch (e) {
      debugPrint('upload_file DioException: ${e.response?.data ?? e.message}');
      return 'error';
    } catch (e) {
      debugPrint('upload_file error: $e');
      return 'error';
    }
  }

  static Future<WebSocket?> connectToWebSocket({required String email}) async {
    try {
      Dio dio = Dio();
      var response = await dio.get(
        '$baseUrl/',
        options: Options(headers: {'accept': 'application/json'}),
      );

      if (response.statusCode == 200) {
        debugPrint('Server response: \${response.data}');
        String wsUrl = baseUrl.replaceAll('http', 'ws') + '/ws/$email';
        WebSocket webSocket = await WebSocket.connect(Uri.parse(wsUrl));
        debugPrint('Connected to WebSocket: $wsUrl');

        webSocket.events.listen(
          (event) {
            if (event is TextDataReceived) {
              debugPrint('WebSocket Message Received: \ ${event.text}');
              if (Get.context != null) {
                show_snackBar(
                  Get.context!,
                  ConstantsData.primaryClr,
                  'Notification: \ ${event.text}',
                );
                var _jsonMessage = jsonDecode(event.text);
                if (_jsonMessage['message'] != null) {
                  NoficationWebSocketModel noficationWebSocketModel =
                      CustomParser.objectParser(
                            res: event.text,
                            //event.text
                            // jsonEncode(_jsonMessage['message'].toString())
                            // .toString(),
                            object: NoficationWebSocketModel(),
                          )
                          as NoficationWebSocketModel;
                  if (noficationWebSocketModel.message != null) {
                    ConstantsData.notificationsList.insert(
                      0,
                      noficationWebSocketModel.message!,
                    );
                    debugPrint(
                      'Notification toJson All: \ ${noficationWebSocketModel.toJson()} \ ',
                    );
                  }
                }
                // debugPrint('Notification: \ ${_jsonMessage['type']}');
              }
            }
          },
          onError: (error) {
            debugPrint('WebSocket Error: $error');
          },
          onDone: () {
            debugPrint('WebSocket Connection Closed');
          },
        );

        return webSocket;
      }
      return null;
    } catch (e) {
      debugPrint('connectToWebSocket error: $e');
      return null;
    }
  }
  //hander to navigate to the notifications view

  static Future<bool> notifyWebSocket({
    required String email,
    required String message,
  }) async {
    try {
      Dio dio = Dio();
      var response = await dio.post(
        '$baseUrl/notify/$email',
        queryParameters: {'message': message},
        data: '',
        options: Options(headers: {'accept': 'application/json'}),
      );

      if (response.statusCode == 200) {
        debugPrint('notify response: \${response.data}');
        return true;
      }
      return false;
    } catch (e) {
      debugPrint('notifyWebSocket error: $e');
      return false;
    }
  }

  static Future<bool> sendActionNotifications({
    required String view,
    required String message,
    required String view_route,
    required String action_id,
    List<int>? user_ids,
    required String parameters,
    List<String>? user_emails,
    // String? user_id,
    String? from_user_id,
  }) async {
    try {
      Dio dio = Dio();
      var response = await dio.post(
        '$baseUrl/sendActionNotifications',
        data: {
          "view": view,
          "message": message,
          "view_route": view_route,
          "action_id": action_id,
          "user_ids": user_ids,
          "user_emails": user_emails,
          "parameters": parameters,
          // if (user_id != null) "user_id": user_id,
          if (from_user_id != null) "from_user_id": from_user_id,
        },
        options: Options(
          headers: {
            'accept': 'application/json',
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${CustomApi.userToken}',
          },
        ),
      );

      if (response.statusCode == 200) {
        debugPrint('sendActionNotifications response: \${response.data}');
        return true;
      }
      return false;
    } catch (e) {
      debugPrint('sendActionNotifications error: $e');
      return false;
    }
  }

  static Future<int?> get_diwan_count({
    required BuildContext context,
    required Map<String, Object> query,
  }) async {
    int? dataCount;
    try {
      // SupabaseQueryBuilder queryBuilder=  supaInstCLient.from('diwan').select().match(query);
      List<Diwan> x =
          await get_Table<Diwan>(
            context: context,
            table_name: 'diwan',
            query: query,
            pageNumber: 1,
            pageSize: 200,
            fromJson: Diwan.fromJson,
          ) ??
          [];
      //.limit(500);

      Get.log(x.toString());
      Get.log(x.toString());
      // Get.log(x.data.toString());

      Get.log(x.length.toString());

      if (x.length >= 0) {
        dataCount =
            x.length; // returnDiwan = x.map((e) => Diwan.fromJson(e)).toList();
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
}
