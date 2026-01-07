import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:west_irbid_mobile/models/attachment_model.dart';
import 'package:west_irbid_mobile/models/diwan.dart';
import 'package:west_irbid_mobile/models/diwan_copy_to_model.dart';
import 'package:west_irbid_mobile/models/diwan_wf_procedures_model.dart';
import 'package:west_irbid_mobile/models/result_object.dart';
import 'package:west_irbid_mobile/modules/diwan_details/diwan_details_controller.dart';
import 'package:west_irbid_mobile/services_utils/constants.dart';
import 'package:west_irbid_mobile/services_utils/helper_methods.dart';
import 'package:west_irbid_mobile/services_utils/supa_api.dart';
import 'package:west_irbid_mobile/services_utils/ui_helpers.dart';
import 'package:west_irbid_mobile/widgets/custom_text_field.dart';
import 'package:west_irbid_mobile/widgets/custome_file_scan_attachmet.dart';
import 'package:west_irbid_mobile/widgets/cutsom_view.dart';
import 'package:west_irbid_mobile/widgets_cc/custom_container_main.dart';
import 'package:west_irbid_mobile/widgets_cc/custom_drop_down_list.dart';
import 'package:west_irbid_mobile/widgets_cc/main_button.dart';

class DiwanDetailsView extends GetView<DiwanDetailsController> {
  DiwanDetailsView({
    super.key,
    int? diwan_id,
    Diwan? diwanObj,
    bool diwan_action = false,
  }) {
    controller.diwan_id = diwan_id;
    controller.diwanObj = diwanObj;
    controller.diwan_action = diwan_action;
    controller.initialFields(diwan_id);
  }

  @override
  Widget build(BuildContext context) {
    return CustomView<DiwanDetailsController>(
      title: 'diwanDetails'.tr,
      titleColor: Colors.green,
      builder: (p0) {
        return view_diwan_details(p0, context);
      },
    );
  }

  ListView view_diwan_details(DiwanDetailsController p0, BuildContext context) {
    return ListView(
      children: [
        CustomContainerMain(
          isEnabled: false,
          cardColor: Colors.grey[100],
          titleColor: Colors.redAccent,
          textColor: Colors.white,
          title:
              'diwan'.tr + " " + (p0.diwanObj?.overallNumber.toString() ?? ''),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: CustomDropDownList(
                      title: 'diwanType'.tr,
                      textController: p0.diwanTypeController,
                      list: ConstantsData.diwan_type,
                      prefixIcon: Icons.type_specimen_outlined,
                      disableSearch: false,
                    ).paddingSymmetric(horizontal: 5, vertical: 10),
                  ),
                  Expanded(
                    child: CustomDropDownList(
                      title: 'diwanClassification'.tr,
                      textController: p0.diwanClassificationController,
                      list: ConstantsData.diwanCLassesList,
                      disableSubmit: false,
                      prefixIcon: Icons.hotel_class_sharp,
                      disableSearch: false,
                    ).paddingSymmetric(horizontal: 5, vertical: 10),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: CustomDropDownList(
                      title: 'diwanFromTo'.tr,
                      textController: p0.diwanFromToController,
                      list: ConstantsData.diwan_to,
                      prefixIcon: Icons.call_missed_sharp,
                      disableSearch: false,
                    ).paddingSymmetric(horizontal: 5, vertical: 10),
                  ),
                  Expanded(
                    child: CustomTextField(
                      textFieldController: p0.diwanSourceFromToController,
                      textInputType: TextInputType.name,
                      title: 'sourceFromTo'.tr,
                      hint: 'Enter'.tr + ' ' + 'name'.tr,
                      maxLength: 70,
                      leading: const Icon(
                        Icons.business_outlined,
                        color: Colors.green,
                      ),
                    ).paddingSymmetric(horizontal: 10, vertical: 10),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CustomDropDownList(
                          title: 'department'.tr,
                          textController: p0.departmentNameController,
                          list: ConstantsData.departments,
                          prefixIcon: Icons.twenty_one_mp,
                          disableSearch: true,
                        ).paddingSymmetric(horizontal: 5, vertical: 10),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Checkbox(
                              value: p0.forwardToDepartment,
                              onChanged: (bool? v) {
                                p0.forwardToDepartment = v ?? false;
                                p0.update();
                              },
                            ),
                            const Text(' تحويل الى القسم المعني'),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const Expanded(child: SizedBox()), // spacer for 2nd column
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      textFieldController: p0.serialNumberController,
                      validator: (String? val) {
                        if (val == null || val == '')
                          return 'This Field is required'.tr;
                        return null;
                      },
                      textInputType: TextInputType.number,
                      title: 'serialNumber'.tr,
                      hint: 'Enter'.tr + ' ' + 'serialNumber'.tr,
                      InputFormatter: ConstantsData.numberInputFormatter,
                      maxLength: 4,
                    ).paddingSymmetric(horizontal: 10, vertical: 10),
                  ),
                  Expanded(
                    child: CustomTextField(
                      textFieldController: p0.dateOfIssuesController,
                      validator: (String? val) {
                        if (val == null || val == '')
                          return 'This Field is required'.tr;
                        return null;
                      },
                      title: 'dateOfIssues'.tr,
                      hint: 'dateOfIssues'.tr,
                      textInputType: TextInputType.text,
                    ).paddingSymmetric(horizontal: 10, vertical: 10),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      textFieldController: p0.dateOfRecivedController,
                      textInputType: TextInputType.text,
                      title: 'dateOfRecived'.tr,
                      hint: 'dateOfRecived'.tr,
                    ).paddingSymmetric(horizontal: 10, vertical: 10),
                  ),
                  Expanded(
                    child: CustomTextField(
                      textFieldController: p0.regionsClassificationController,
                      title: 'regionsClassification'.tr,
                      hint: 'Enter'.tr + ' ' + 'regionsClassification'.tr,
                      maxLength: 12,
                      textInputType: TextInputType.text,
                      leading: const Icon(
                        Icons.class_outlined,
                        color: Colors.blue,
                      ),
                    ).paddingSymmetric(horizontal: 10, vertical: 10),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      textFieldController: p0.diwanSubjectController,
                      title: 'subject'.tr,
                      hint: 'Enter'.tr + ' ' + 'subject'.tr,
                      maxLine: 2,
                      textInputType: TextInputType.text,
                      leading: const Icon(
                        Icons.class_outlined,
                        color: Colors.blue,
                      ),
                    ).paddingSymmetric(horizontal: 10, vertical: 10),
                  ),
                  Expanded(
                    child: CustomTextField(
                      textFieldController: p0.summaryController,
                      title: 'summary'.tr,
                      hint: 'Enter'.tr + ' ' + 'summary'.tr,
                      maxLength: 300,
                      maxLine: 2,
                      textInputType: TextInputType.multiline,
                      leading: const Icon(
                        Icons.summarize,
                        color: Colors.greenAccent,
                      ),
                    ).paddingSymmetric(horizontal: 10, vertical: 10),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      textFieldController: p0.trasolController,
                      title: 'trasol'.tr,
                      hint: 'Enter'.tr + ' ' + 'trasol'.tr,
                      maxLength: 15,
                      textInputType: TextInputType.text,
                      leading: const Icon(
                        Icons.nine_mp_outlined,
                        color: Colors.blue,
                      ),
                    ).paddingSymmetric(horizontal: 10, vertical: 10),
                  ),
                  const Expanded(child: SizedBox()),
                ],
              ),
              if (p0.diwanObj?.copy_to_ids != null &&
                  p0.diwanObj?.copy_to_ids != '')
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'نسخه الى:' + (p0.diwanObj?.copy_to_names ?? ''),
                      style: Get.textTheme.bodyMedium?.copyWith(
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 220),
              child: CustomFIleScanAttachment(
                enable: false,
                title: 'إضغط للتحميل'.tr,
                onPress: () async {
                  p0.fileAttachment = await HelperMethods.getFileAttachment(
                    context,
                    null,
                  );
                  p0.update();
                },
                attachment: p0.fileAttachment,
              ),
            ),
            if (p0.diwan_action)
              MainButton(
                enabled: true,
                color: Colors.blue,
                text: 'addProcedure'.tr,
                onPressed: () {
                  p0.addProcedure = !p0.addProcedure;
                  p0.update();
                },
              ).paddingSymmetric(horizontal: 10, vertical: 0),
          ],
        ),
        if (p0.diwanObj?.diwanClasificationName == null ||
            p0.diwanObj?.attachment == null ||
            p0.diwanObj?.attachment == 'error')
          CustomContainerMain(
            isEnabled: true,
            cardColor: Colors.grey[100],
            titleColor: Colors.redAccent,
            textColor: Colors.white,
            title: 'update'.tr,
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: CustomDropDownList(
                        title: 'diwanClassification'.tr,
                        textController: p0.updateDiwanClassificationController,
                        list: ConstantsData.diwanCLassesList,
                        disableSubmit: false,
                        prefixIcon: Icons.hotel_class_sharp,
                        disableSearch: false,
                        onChange: (v) {
                          p0.selectedDiwanClass = v;
                        },
                      ).paddingSymmetric(horizontal: 5, vertical: 10),
                    ),
                    Expanded(
                      child: CustomTextField(
                        textFieldController: p0.updateSummaryController,
                        title: 'summary'.tr,
                        hint: 'Enter'.tr + ' ' + 'summary'.tr,
                        maxLength: 300,
                        maxLine: 2,
                        textInputType: TextInputType.multiline,
                        leading: const Icon(
                          Icons.summarize,
                          color: Colors.greenAccent,
                        ),
                      ).paddingSymmetric(horizontal: 10, vertical: 10),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 220),
                            child: CustomFIleScanAttachment(
                              title: 'New'.tr + ' ' + 'Attachments'.tr,
                              onPress: () async {
                                p0.updateFileAttachment =
                                    await HelperMethods.getFileAttachment(
                                      context,
                                      p0.attach_size,
                                    );
                                p0.update();
                              },
                              attachment: p0.updateFileAttachment,
                            ),
                          ),
                          MainButton(
                            enabled: true,
                            color: Colors.blue,
                            text: 'update'.tr,
                            onPressed: () async {
                              if (p0.diwanObj?.diwanClasificationId == null &&
                                  (p0.selectedDiwanClass == null ||
                                      p0.selectedDiwanClass?.id == null)) {
                                show_snackBar(
                                  context,
                                  Colors.red,
                                  'ارجوا اختيار التصنيف اولا'.tr,
                                );
                                return;
                              }

                              startLoading(context, willPop: true);
                              if (p0.updateFileAttachment?.url != null &&
                                  p0.updateFileAttachment?.uploadFileUri !=
                                      'error') {
                                try {
                                  p0.updateFileAttachment?.uploadFileUri =
                                      await SupaApi.upload_files_supa(
                                        'west-irbid/diwan',
                                        p0.updateFileAttachment?.url ?? '',
                                        p0.updateFileAttachment?.fileName ?? '',
                                      );
                                } catch (e) {
                                  pop(context);
                                  show_snackBar(
                                    context,
                                    Colors.red,
                                    'خطأ في تحميل الملفات FTP'.tr,
                                  );
                                  return;
                                }
                              }

                              Diwan? updateDiwanObj = p0.diwanObj;
                              if (p0.diwanObj?.attachment == null &&
                                  p0.updateFileAttachment?.uploadFileUri
                                          ?.trim() !=
                                      null) {
                                updateDiwanObj?.attachment = p0
                                    .updateFileAttachment
                                    ?.uploadFileUri
                                    ?.toString();
                              }
                              updateDiwanObj?.old_attachment = p0.oldAttach;

                              if (p0.selectedDiwanClass != null &&
                                  p0.selectedDiwanClass?.id != null) {
                                updateDiwanObj?.diwanClasificationId =
                                    p0.selectedDiwanClass?.id;
                                updateDiwanObj?.diwanClasificationName = p0
                                    .selectedDiwanClass
                                    ?.toString();
                                updateDiwanObj?.old_diwan_classification =
                                    p0.oldClassificationName;
                                updateDiwanObj?.overallNumber =
                                    '${p0.diwanObj?.serialNumber}\\${p0.selectedDiwanClass?.classId.toString()}';
                              }

                              if (p0.diwanObj?.summary !=
                                  p0.updateSummaryController.text.trim()) {
                                updateDiwanObj?.summary = p0
                                    .updateSummaryController
                                    .text
                                    .trim();
                              }

                              updateDiwanObj?.updated_by = SupaApi
                                  .supaInstCLient
                                  .auth
                                  .currentSession
                                  ?.user
                                  .email;
                              updateDiwanObj?.is_updated = true;

                              Diwan? c = await p0.insert_update_diwan(
                                context,
                                diwanObj: updateDiwanObj!,
                                isInsert: false,
                              );
                              pop(context);
                              if (c != null) {
                                p0.diwanObj = c;
                                p0.update();
                                Get.back(
                                  result: ResultObject(
                                    actionName: 'update',
                                    actionId: (updateDiwanObj.id ?? -1),
                                    returnObject: c,
                                  ),
                                );
                              }
                            },
                          ).paddingSymmetric(horizontal: 10, vertical: 10),
                        ],
                      ),
                    ),
                    Expanded(
                      child: MainButton(
                        enabled: true,
                        color: Colors.red,
                        prefex: const Icon(Icons.delete),
                        text: 'delete'.tr,
                        onPressed: () async {
                          HelperMethods.dialogView(
                            context: context,
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Are you sure to delete this record?',
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    MainButton(
                                      color: Colors.red,
                                      text: 'ok'.tr,
                                      onPressed: () async {
                                        Diwan? deleteDiwanObj = p0.diwanObj;
                                        deleteDiwanObj?.updated_by = SupaApi
                                            .supaInstCLient
                                            .auth
                                            .currentSession
                                            ?.user
                                            .email;
                                        deleteDiwanObj?.is_updated = true;
                                        deleteDiwanObj?.update_actions =
                                            'Delete record';
                                        deleteDiwanObj?.isDeleted = true;
                                        deleteDiwanObj?.active = false;

                                        Diwan? c = await p0.insert_update_diwan(
                                          context,
                                          diwanObj: deleteDiwanObj!,
                                          isInsert: false,
                                        );
                                        pop(context);
                                        if (c != null) {
                                          Get.back(
                                            result: ResultObject(
                                              actionName: 'delete',
                                              actionId:
                                                  (deleteDiwanObj.id ?? -1),
                                            ),
                                          );
                                        }
                                      },
                                    ),
                                    MainButton(
                                      color: Colors.grey,
                                      text: 'cancel'.tr,
                                      onPressed: () => pop(context),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      ).paddingSymmetric(horizontal: 10, vertical: 10),
                    ),
                  ],
                ),
              ],
            ),
          ),
        if (p0.addProcedure)
          CustomContainerMain(
            isEnabled: true,
            cardColor: Colors.grey[100],
            titleColor: Colors.blueGrey,
            textColor: Colors.white,
            title: 'diwan'.tr + " / " + 'procedures'.tr,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: CustomTextField(
                        textFieldController: p0.procedureDetailsController,
                        textInputType: TextInputType.text,
                        validator: (String? val) {
                          if (val == null || val == '')
                            return 'This Field is required'.tr;
                          return null;
                        },
                        title: 'procedureDetails'.tr,
                        hint: 'Enter'.tr + ' ' + 'procedureDetails'.tr,
                        maxLength: 200,
                        maxLine: 3,
                      ).paddingSymmetric(horizontal: 10, vertical: 10),
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (p0.forwardToDepartment)
                            CustomDropDownList(
                              title: 'transformTo'.tr,
                              list: ConstantsData.listUsers,
                              multiSelect: false,
                              textController: p0.procedureDepartmentController,
                              prefixIcon: Icons.person,
                              validator: (String? val) {
                                if (val == null || val == '')
                                  return 'This Field is required'.tr;
                                return null;
                              },
                              disableSearch: false,
                              onChange: (val) {
                                p0.transferToUser = val;
                                p0.update();
                              },
                            ).paddingSymmetric(horizontal: 5, vertical: 10),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Checkbox(
                                value: p0.forwardToDepartment,
                                onChanged: (bool? v) {
                                  p0.forwardToDepartment = v ?? false;
                                  p0.update();
                                },
                              ),
                              Text('transformTo'.tr),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 220),
                        child: CustomFIleScanAttachment(
                          title: 'attachment'.tr,
                          onPress: () async {
                            p0.procedureAttachment =
                                await HelperMethods.getFileAttachment(
                                  context,
                                  null,
                                );
                            p0.update();
                          },
                          attachment: p0.procedureAttachment,
                        ),
                      ),
                    ),
                    const Expanded(child: SizedBox()),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SegmentedButton<int>(
                      segments: p0.segments,
                      selected: p0.selection,
                      onSelectionChanged: (Set<int> newSelection) {
                        p0.selection = newSelection;
                        p0.update();
                      },
                      multiSelectionEnabled: false,
                    ),
                    MainButton(
                      text: 'add'.tr,
                      color: Colors.green,
                      onPressed: () async {
                        if (p0.procedureDetailsController.text.trim() == '') {
                          HelperMethods.dialogView(
                            context: context,
                            message: 'أرجوا إدخال تفاصيل الاجراء للمتابعه',
                            type: 1,
                          );
                          return;
                        }
                        if (p0.forwardToDepartment == true &&
                            p0.transferToUser == null) {
                          HelperMethods.dialogView(
                            context: context,
                            message: 'أرجوا ختيار الشخص المحول له',
                            type: 1,
                          );
                          return;
                        }
                        if (p0.forwardToDepartment == true &&
                            p0.transferToUser?.id ==
                                ConstantsData.currentUser?.id) {
                          HelperMethods.dialogView(
                            context: context,
                            message: 'لايجوز التحول لنفس المستخدم',
                            type: 1,
                          );
                          return;
                        }

                        startLoading(context, willPop: true);
                        if (p0.procedureAttachment?.url != null &&
                            p0.procedureAttachment?.uploadFileUri != 'error') {
                          p0.procedureAttachment?.uploadFileUri =
                              await SupaApi.upload_files_supa(
                                'west-irbid/diwan_procedure',
                                p0.procedureAttachment!.url!,
                                p0.procedureAttachment!.fileName!,
                              );
                        }

                        if (p0.forwardToDepartment == true &&
                            p0.transferToUser != null) {
                          await SupaApi.insert_table<DiwanCopyTo>(
                            context: context,
                            table_name: 'diwan_copy_to',
                            fromJson: DiwanCopyTo.fromJson,
                            toJson: DiwanCopyTo(
                              forwardToUserId: p0.transferToUser?.id,
                              requireAction: true,
                              addByUserId: ConstantsData.currentUser?.id,
                              forwardToUserName: p0.transferToUser?.userName,
                              isDeleted: false,
                              actionDone: false,
                              diwanId: p0.diwan_id,
                              from_name: p0.diwanSourceFromToController.text,
                              subject: p0.diwanSubjectController.text,
                            ).toJson(),
                          );
                        }

                        WindowsDeviceInfo? winDeviceInfo;
                        String deviceId = '';
                        try {
                          winDeviceInfo = await DeviceInfoPlugin().windowsInfo;
                          deviceId = winDeviceInfo.deviceId;
                        } catch (e) {
                          deviceId = 'mobile_device';
                        }

                        DiwanWFProcedure procedure = DiwanWFProcedure(
                          diwanId: p0.diwanObj?.id,
                          forwardToEmpId: p0.transferToUser?.id,
                          forwardToEmpName: p0.transferToUser?.userName,
                          attachment: p0.procedureAttachment?.uploadFileUri,
                          by_user_email: SupaApi
                              .supaInstCLient
                              .auth
                              .currentSession
                              ?.user
                              .email,
                          byUsername: ConstantsData.currentUser?.userName,
                          caseType: 'ديوان',
                          caseTypeId: 2,
                          details: p0.procedureDetailsController.text,
                          deviceId: deviceId,
                        );

                        await p0.insert_diwan_wf_procedure(
                          context,
                          procedureWFObj: procedure,
                        );
                        await p0.getProceduresList(p0.diwan_id);

                        p0.diwanObj?.status = p0.selection.first;

                        List<Map<String, dynamic>> copies = await SupaApi
                            .supaInstCLient
                            .from('diwan_copy_to')
                            .select()
                            .eq('diwan_id', p0.diwanObj?.id ?? -1)
                            .eq(
                              'forward_to_user_id',
                              ConstantsData.currentUser?.id ?? -1,
                            );

                        if (copies.isNotEmpty) {
                          List<DiwanCopyTo> diwanCopyToItems = copies
                              .map((e) => DiwanCopyTo.fromJson(e))
                              .toList();
                          if (diwanCopyToItems.isNotEmpty &&
                              diwanCopyToItems.last.actionDone == false) {
                            // DiwanCopyTo lastCopy = diwanCopyToItems.last;
                            // Update lastCopy to done
                            // This part would ideally update the record in Supabase
                          }
                        }

                        p0.addProcedure = false;
                        p0.selectedCase = null;
                        p0.update();
                        pop(context);
                      },
                    ),
                  ],
                ).paddingSymmetric(vertical: 10),
              ],
            ),
          ),
        if ((p0.caseProceduresList ?? []).isNotEmpty)
          CustomContainerMain(
            isEnabled: true,
            cardColor: Colors.grey[100],
            titleColor: Colors.green,
            textColor: Colors.white,
            title: 'procedures'.tr + " " + (p0.diwanObj?.id.toString() ?? ''),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: p0.caseProceduresList!
                  .map(
                    (e) => Card(
                      child: ListTile(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'رقم الاجراء التسلسلي:'.tr + '${e.id.toString()}',
                            ),
                            Text(
                              'من:${e.byUsername.toString()}',
                            ).paddingSymmetric(horizontal: 10),
                            Expanded(
                              child: Text(
                                'details: '.tr + e.details.toString(),
                                maxLines: 3,
                                overflow: TextOverflow.fade,
                                style: Get.textTheme.bodyMedium?.copyWith(
                                  color: Colors.blue,
                                ),
                              ),
                            ),
                            if (e.forwardToEmpId != null)
                              Text(
                                'transformTo'.tr +
                                    ':' +
                                    e.forwardToEmpName.toString(),
                              ).paddingSymmetric(horizontal: 10),
                            CustomFIleScanAttachment(
                              enable: false,
                              title: 'إضغط للتحميل'.tr,
                              onPress: () async {},
                              attachment: Attachment(
                                uploadFileUri: e.attachment,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
      ],
    );
  }
}
