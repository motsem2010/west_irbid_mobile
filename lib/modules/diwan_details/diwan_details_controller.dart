import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:west_irbid_mobile/models/attachment_model.dart';
import 'package:west_irbid_mobile/models/departments.dart';
import 'package:west_irbid_mobile/models/diwan.dart';
import 'package:west_irbid_mobile/models/diwan_classes.dart';
import 'package:west_irbid_mobile/models/diwan_wf_procedures_model.dart';
import 'package:west_irbid_mobile/models/user_model.dart';
import 'package:west_irbid_mobile/services_utils/constants.dart';
import 'package:west_irbid_mobile/services_utils/supa_api.dart';
import 'package:west_irbid_mobile/services_utils/ui_helpers.dart';

class DiwanDetailsController extends GetxController {
  int? diwan_id;
  Diwan? diwanObj;

  bool diwan_action = false;
  bool isSaved = false;
  bool isSwitchEnabled = true;

  int get attach_size {
    try {
      return int.parse(
        ConstantsData.settingsList
                .firstWhere(
                  (element) => element.settingKey == 'attch_size_diwan',
                )
                .settingValue ??
            '1',
      );
    } catch (e) {
      return 1;
    }
  }

  UserModel? transferToUser;
  final formKey = GlobalKey<FormState>();

  TextEditingController diwanSourceFromToController = TextEditingController();
  TextEditingController dateOfRecivedController = TextEditingController();
  TextEditingController employeeDepartmentController = TextEditingController();
  TextEditingController regionsClassificationController =
      TextEditingController();
  TextEditingController finalnumberController = TextEditingController();
  TextEditingController serialNumberController = TextEditingController();
  TextEditingController dateOfIssuesController = TextEditingController();
  TextEditingController diwanTypeController = TextEditingController();
  TextEditingController diwanClassificationController = TextEditingController();
  TextEditingController diwanFromToController = TextEditingController();
  TextEditingController departmentNameController = TextEditingController();
  TextEditingController summaryController = TextEditingController();
  TextEditingController trasolController = TextEditingController();
  TextEditingController procedureDetailsController = TextEditingController();
  TextEditingController procedureDepartmentController = TextEditingController();
  TextEditingController diwanSubjectController = TextEditingController();

  // update controller
  TextEditingController updateDiwanClassificationController =
      TextEditingController();
  Attachment? updateFileAttachment;
  TextEditingController updateSummaryController = TextEditingController();

  String? oldAttach;
  String? oldClassificationName;
  List<ButtonSegment<int>> segments = [];
  DiwanClass? selectedDiwanClass;

  Attachment? fileAttachment;
  Attachment? procedureAttachment;

  Set<int> selection = {0};
  bool forwardToDepartment = false;
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  List<DiwanWFProcedure>? caseProceduresList;
  bool addProcedure = false;
  DiwanWFProcedure? selectedCase;
  bool showEmployeeInDepartment = false;

  Department? department;
  UserModel? employeeDept;

  @override
  void onInit() {
    super.onInit();
    ConstantsData.complaintsStatus.forEach((key, value) {
      segments.add(ButtonSegment<int>(value: key, label: Text(value)));
    });
  }

  @override
  void onReady() async {
    super.onReady();
    if (ConstantsData.listUsers.isEmpty) {
      ConstantsData.listUsers =
          await SupaApi.get_Table<UserModel>(
            context: Get.context!,
            query: {},
            pageNumber: 1,
            pageSize: 200,
            table_name: 'user_pc_auth',
            fromJson: UserModel.fromJson,
          ) ??
          [];
    }
  }

  getProceduresList(int? diwanId) async {
    if (diwanId == null) return;
    caseProceduresList =
        await SupaApi.get_Table<DiwanWFProcedure>(
          context: Get.context!,
          query: {'diwan_id': diwanId},
          pageNumber: 1,
          pageSize: 200,
          table_name: 'diwan_wf_procedurs',
          fromJson: DiwanWFProcedure.fromJson,
        ) ??
        [];
    update();
  }

  Future<Diwan?> insert_update_diwan(
    BuildContext context, {
    required Diwan diwanObj,
    bool isInsert = true,
  }) async {
    var resp = await SupaApi.insertUpdateDiwan(
      context: context,
      diwanObj: diwanObj,
      isInsert: isInsert,
    );
    if (resp.$2 == true) {
      show_snackBar(context, Colors.green, 'diwanUpdatedSuccessfully'.tr);
    }
    return resp.$1;
  }

  Future<DiwanWFProcedure?> insert_diwan_wf_procedure(
    BuildContext context, {
    required DiwanWFProcedure procedureWFObj,
  }) async {
    var resp = await SupaApi.insert_table<DiwanWFProcedure>(
      table_name: 'diwan_wf_procedurs',
      fromJson: DiwanWFProcedure.fromJson,
      toJson: procedureWFObj.toJson(),
      context: context,
    );
    if (resp.$2 == true) {
      show_snackBar(context, Colors.green, 'caseAddedSuccessfully'.tr);
    }
    return resp.$1;
  }

  void initialFields(int? diwanId) async {
    transferToUser = null;
    forwardToDepartment = false;
    procedureDepartmentController.text = '';

    if (diwanId != null && diwanObj == null) {
      List<Diwan>? result = await SupaApi.get_Table<Diwan>(
        context: Get.context!,
        query: {'id': diwanId.toString()},
        pageNumber: 1,
        pageSize: 1,
        table_name: 'diwan_wf',
        fromJson: Diwan.fromJson,
      );
      if (result != null && result.isNotEmpty) {
        diwanObj = result[0];
      }
    }

    if (diwanObj != null) {
      selectedDiwanClass = null;
      updateDiwanClassificationController.text = '';

      oldClassificationName = diwanObj?.diwanClasificationName.toString() ?? '';
      oldAttach = diwanObj?.attachment.toString() ?? '';
      updateSummaryController.text = diwanObj?.summary.toString() ?? '';

      diwanTypeController.text = diwanObj?.diwanType.toString() ?? '';
      diwanClassificationController.text =
          diwanObj?.diwanClasificationName.toString() ?? '';
      diwanFromToController.text = diwanObj?.diwanFromTo.toString() ?? '';
      diwanSourceFromToController.text =
          diwanObj?.diwanSourceFromTo.toString() ?? '';
      dateOfIssuesController.text = diwanObj?.dateOfIssue.toString() ?? '';
      dateOfRecivedController.text = diwanObj?.dateOfRecived.toString() ?? '';
      departmentNameController.text = diwanObj?.departmentName.toString() ?? '';
      serialNumberController.text = diwanObj?.serialNumber.toString() ?? '';
      regionsClassificationController.text =
          diwanObj?.regionClassification.toString() ?? '';
      summaryController.text = diwanObj?.summary.toString() ?? '';
      trasolController.text = diwanObj?.trasol.toString() ?? '';
      finalnumberController.text = diwanObj?.overallNumber.toString() ?? '';
      diwanSubjectController.text = diwanObj?.subject.toString() ?? '';

      fileAttachment =
          (diwanObj?.attachment != null && diwanObj!.attachment!.isNotEmpty)
          ? Attachment(uploadFileUri: diwanObj?.attachment, isFTP: false)
          : null;

      await getProceduresList(diwanId);
    }
    update();
  }
}
