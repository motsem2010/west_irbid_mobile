import 'dart:developer';
import 'package:d_chart/commons/data_model/data_model.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:west_irbid_mobile/models/attachment_model.dart';
import 'package:west_irbid_mobile/models/case_procedures_model.dart';
import 'package:west_irbid_mobile/models/departments.dart';
import 'package:west_irbid_mobile/models/diwan.dart';
import 'package:west_irbid_mobile/models/diwan_copy_to_model.dart';
import 'package:west_irbid_mobile/models/roles_model.dart';
import 'package:west_irbid_mobile/models/statistic_model.dart';
import 'package:west_irbid_mobile/models/tandeem_procedure_model.dart';
import 'package:west_irbid_mobile/models/user_model.dart';
import 'package:west_irbid_mobile/models/user_role_model.dart';
import 'package:west_irbid_mobile/services_utils/constants.dart';
import 'package:west_irbid_mobile/services_utils/helper_excel.dart';
import 'package:west_irbid_mobile/services_utils/helper_methods.dart';
import 'package:west_irbid_mobile/services_utils/supa_api.dart';
import 'package:west_irbid_mobile/services_utils/ui_helpers.dart';
import 'package:west_irbid_mobile/widgets/custom_text_field.dart';

class WorkflowController extends GetxController
    with GetSingleTickerProviderStateMixin {
  bool isSaved = false;
  bool isSwitchEnabled = true;
  bool isLIstView = true;

  int get attach_size {
    try {
      return int.parse(
        ConstantsData.settingsList
                .where(
                  (element) => element.settingKey == 'attch_workflow_diwan',
                )
                .first
                .settingValue ??
            '1',
      );
    } catch (e) {
      return 1;
    }
  }

  String? languageText;
  final formKey = GlobalKey<FormState>();
  final formKey2 = GlobalKey<FormState>();
  final formExportKey = GlobalKey<FormState>();

  TextEditingController toTextController = TextEditingController();
  TextEditingController fromTextController = TextEditingController();
  TextEditingController cityTextController = TextEditingController();
  TextEditingController subjectTextController = TextEditingController();
  TextEditingController summaryController = TextEditingController();
  int priority_value = 1; //0 low , 1 normal , 2 high

  TextEditingController departmentNameController = TextEditingController();
  TextEditingController trasolController = TextEditingController();
  TextEditingController fileNameController = TextEditingController();

  List<ButtonSegment<int>> segments = [];
  TextEditingController diwanClassificationFilterController =
      TextEditingController();
  TextEditingController summaryFilterController = TextEditingController();
  TextEditingController serialNumberFilterController = TextEditingController();
  TextEditingController idFilterController = TextEditingController();

  TextEditingController diwanSourceFromToFilterController =
      TextEditingController();
  TextEditingController trasolFilterController = TextEditingController();

  Attachment? fileAttachment;
  int selectedIndex = 0;
  Department? department;
  List<Diwan>? wFList = [];

  List<Diwan>? mainMyWFDiwanTranseerToMyList = [];
  List<Diwan>? myWFList = [];
  List<DiwanCopyTo> myWFDiwanCopyTo = [];
  List<TandeemProcedure>? myProcList = [];

  String? filterText;
  RoleModel? selectedRole;
  List<UserRoleModel>? userRoles = [];
  Set<int> selection = {0};
  bool diwan_action = false;
  bool chartRegion = true;
  bool chartDepartment = false;
  List<OrdinalData> ordinalDataListRegions = [];
  List<OrdinalData> ordinalDataListDepartments = [];

  List<bool> selectedIndexToggle = [false, false, false, false];
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  bool showEmployeeInDepartment = true;
  UserModel? employeeDept;
  int pageSize = 200;
  int? dataCount = 0;
  int pageCurrent = 1;
  bool loadMore = true;
  bool debounce = true;
  List<Widget> statusList = <Widget>[
    Text('Low'.tr),
    Text('Normal'.tr),
    Text('High'.tr),
  ];

  late TabController tabController;

  String? selectionFileLocation;
  String? selectionDailyWorkFileLocation;

  List<String> users = [];

  List<StatisticData>? usersCountStatics;
  List<StatisticData>? diwanTypeCountStatics;
  List<WorkPerDay>? worksPerDayData;
  WorkPerDay? currentUserCount;

  getPaginationData(bool withLoadData, Map<String, Object>? query) async {
    if (withLoadData) {
      Map<String, Object> query1 = query ?? {};
      dataCount = await SupaApi.get_diwan_count(
        context: Get.context!,
        query: query1,
      );
    }
  }

  @override
  void onInit() {
    fromTextController.text = ConstantsData.currentUser?.userName ?? '';
    tabController = TabController(initialIndex: 0, length: 2, vsync: this);
    super.onInit();
  }

  @override
  void onReady() async {
    super.onReady();
    await refreshMyListsData();
    await refreshMyWFProceduresData();
  }

  refreshMyListsData() async {
    myWFList = await SupaApi.get_Table<Diwan>(
      table_name: 'workflow',
      fromJson: Diwan.fromJson,
      context: Get.context!,
      pageNumber: 1,
      pageSize: 200,
      query: {'from_id': ConstantsData.currentUser?.id ?? -1},
    );
    Get.log('myWFList: ' + (myWFList?.length ?? 0).toString());
    update();
  }

  refreshMyWFProceduresData() async {
    myWFDiwanCopyTo =
        await SupaApi.get_Table<DiwanCopyTo>(
          table_name: 'diwan_copy_to',
          fromJson: DiwanCopyTo.fromJson,
          context: Get.context!,
          pageNumber: 1,
          pageSize: 200,
          query: {'forward_to_user_id': ConstantsData.currentUser?.id ?? -1},
        ) ??
        [];
    Get.log('myWFDiwanCopyTo: ' + (myWFDiwanCopyTo).toString());
    if (myWFDiwanCopyTo.isNotEmpty) {
      List<int> diwan_id_copy_to_list = [];
      for (var a1 in myWFDiwanCopyTo) {
        diwan_id_copy_to_list.add(a1.diwanId ?? -1);
      }

      mainMyWFDiwanTranseerToMyList = await SupaApi.get_Table_List<Diwan>(
        context: Get.context!,
        pageNumber: 1,
        pageSize: 200,
        table_name: 'workflow',
        coloumList: diwan_id_copy_to_list,
        idColuomn: 'diwan_id',
        fromJson: Diwan.fromJson,
      );

      if ((mainMyWFDiwanTranseerToMyList ?? []).isNotEmpty) {
        for (var a1 in mainMyWFDiwanTranseerToMyList!) {
          var matching = myWFDiwanCopyTo.where((s) => s.diwanId == a1.diwan_id);
          if (matching.isNotEmpty) {
            DiwanCopyTo _myObj = matching.first;
            a1.action_done = _myObj.requireAction == false
                ? true
                : _myObj.actionDone;
            a1.require_user_action = _myObj.requireAction;
          }
        }
      }
    }
    update();
  }

  Future exportDailyWork(context) async {
    HelperMethods.dialogView(
      context: context,
      type: 2,
      content: StatefulBuilder(
        builder: (context, dialogState) {
          return Form(
            key: formExportKey,
            child: Material(
              child: ListView(
                shrinkWrap: true,
                children: [
                  CustomTextField(
                    textFieldController: fileNameController,
                    textInputType: TextInputType.text,
                    title: 'fileName'.tr,
                    hint: 'Enter'.tr + ' ' + 'fileName'.tr,
                    maxLength: 30,
                    validator: (val0) {
                      if (val0 == null || val0 == '') {
                        return 'This Field is required'.tr;
                      }
                      if (val0.endsWith('.xlsx') ||
                          val0.endsWith('.xls') ||
                          val0.endsWith('.')) {
                        return 'remove .xlsx extension'.tr;
                      }
                      return null;
                    },
                  ).paddingSymmetric(horizontal: 10, vertical: 10),
                  ElevatedButton(
                    onPressed: () async {
                      if (formExportKey.currentState!.validate()) {
                        if ((worksPerDayData ?? []).isEmpty) {
                          pop(context);
                          HelperMethods.dialogView(
                            context: context,
                            type: 1,
                            message: 'قم باستدعاء الاعمال اليوميه اولا',
                          );
                          return;
                        }
                        selectionDailyWorkFileLocation =
                            await HelperMethods.selectFolderLocation();
                        if (selectionDailyWorkFileLocation != null) {
                          selectionDailyWorkFileLocation =
                              selectionDailyWorkFileLocation!.replaceAll(
                                '\\',
                                '/',
                              );
                          exportDiwanDailyWorkToExcel(
                            worksPerDayData ?? [],
                            selectionDailyWorkFileLocation ?? '',
                            fileNameController.text,
                          );
                          pop(context);
                        }
                      }
                    },
                    child: const Text('Export'),
                  ).paddingSymmetric(horizontal: 50),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Future prepareWorkCountsStatisticsPerDayData() async {
    startLoading(Get.context!, willPop: true);
    worksPerDayData = await SupaApi.get_diwan_static_work_by_day(
      context: Get.context!,
      function_name: 'get_records_by_date',
    );
    update();
    pop(Get.context!);
  }

  Future prepareChartData() async {
    startLoading(Get.context!, willPop: true);
    usersCountStatics = await SupaApi.get_diwan_static_data(
      context: Get.context!,
      function_name: 'diwan_users_counts',
    );
    diwanTypeCountStatics = await SupaApi.get_diwan_static_data(
      context: Get.context!,
      function_name: 'get_diwan_types_count',
    );

    ordinalDataListRegions = [];
    if (usersCountStatics != null) {
      for (var e1 in usersCountStatics!) {
        ordinalDataListRegions.add(
          OrdinalData(
            domain: e1.criteria?.substring(0, 5) ?? 'n',
            measure: e1.count ?? 0,
          ),
        );
      }
    }

    ordinalDataListDepartments = [];
    if (diwanTypeCountStatics != null) {
      for (var e1 in diwanTypeCountStatics!) {
        ordinalDataListDepartments.add(
          OrdinalData(domain: e1.criteria ?? 'n', measure: e1.count ?? 0),
        );
      }
    }
    pop(Get.context!);
    update();
  }

  Future<bool> uploadAttachmentFiles() async {
    bool isUploaded = false;
    try {
      if (fileAttachment?.url != null &&
          fileAttachment?.uploadFileUri != 'error' &&
          (fileAttachment?.uploadFileUri ?? '').isEmpty) {
        fileAttachment?.uploadFileUri = await SupaApi.upload_files_supa(
          'west-irbid/workflow',
          fileAttachment?.url ?? '',
          'workflow',
        );
      }
      isUploaded = true;
      return isUploaded;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  Future<void> get_workflow(BuildContext context) async {
    List<Diwan>? myDiwanItems = await SupaApi.get_Table<Diwan>(
      context: context,
      table_name: 'workflow',
      query: {'from_id': ConstantsData.currentUser?.id ?? -1},
      fromJson: Diwan.fromJson,
      pageNumber: 1,
      pageSize: 300,
    );
    log('my diwan items =${myDiwanItems?.length.toString()}');
  }

  Future<Diwan?> insert_workflow(
    BuildContext context, {
    required Diwan workFlowData,
  }) async {
    var resp = await SupaApi.insert_table<Diwan>(
      table_name: 'workflow',
      toJson: workFlowData.toJson(),
      context: context,
      fromJson: Diwan.fromJson,
    );
    if (resp.$2 == true) {
      show_snackBar(context, Colors.green, 'diwanAddedSuccessfully'.tr);
    }
    return resp.$1;
  }

  Future<CaseProcedure?> insert_case_procedure(
    BuildContext context, {
    required CaseProcedure caseObj,
  }) async {
    var resp = await SupaApi.insertUpdateCaseProcedure(
      context: context,
      caseProcedureObj: caseObj,
    );
    if (resp.$2 == true) {
      show_snackBar(context, Colors.green, 'caseAddedSuccessfully'.tr);
    }
    return resp.$1;
  }

  void clearFields() {
    debounce = true;
    departmentNameController.text = '';
    toTextController.text = '';
    priority_value = 1;
    subjectTextController.text = '';
    summaryController.text = '';
    trasolController.text = '';
    cityTextController.text = '';
    diwan_action = false;
    fileNameController.text = '';
    department = null;
    fileAttachment = null;
    update();
  }

  @override
  void onClose() {
    toTextController.dispose();
    fromTextController.dispose();
    cityTextController.dispose();
    subjectTextController.dispose();
    summaryController.dispose();
    departmentNameController.dispose();
    trasolController.dispose();
    fileNameController.dispose();
    diwanClassificationFilterController.dispose();
    summaryFilterController.dispose();
    serialNumberFilterController.dispose();
    idFilterController.dispose();
    diwanSourceFromToFilterController.dispose();
    trasolFilterController.dispose();
    tabController.dispose();
    super.onClose();
  }
}
