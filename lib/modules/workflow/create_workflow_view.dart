import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:west_irbid_mobile/models/diwan.dart';
import 'package:west_irbid_mobile/modules/workflow/workflow_controller.dart';
import 'package:west_irbid_mobile/services_utils/constants.dart';
import 'package:west_irbid_mobile/services_utils/helper_methods.dart';
import 'package:west_irbid_mobile/services_utils/supa_api.dart';
import 'package:west_irbid_mobile/services_utils/ui_helpers.dart';
import 'package:west_irbid_mobile/widgets/custom_text_field.dart';
import 'package:west_irbid_mobile/widgets/custome_file_scan_attachmet.dart';
import 'package:west_irbid_mobile/widgets_cc/custom_container_main.dart';
import 'package:west_irbid_mobile/widgets_cc/custom_drop_down_list.dart';
import 'package:west_irbid_mobile/widgets_cc/main_button.dart';

class CreateWorkflowView extends StatelessWidget {
  const CreateWorkflowView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WorkflowController>(
      builder: (controller) => Form(
        key: controller.formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            CustomContainerMain(
              isEnabled: !controller.isSaved,
              title: 'workflowCreate'.tr,
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: CustomTextField(
                          textFieldController: controller.fromTextController,
                          title: 'from'.tr,
                          hint: '${'enter'.tr} ${'from'.tr}',
                          validator: (String? val) {
                            if (val == null || val == '')
                              return 'This Field is required'.tr;
                            return null;
                          },
                          maxLength: 100,
                          textInputType: TextInputType.text,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: CustomTextField(
                          textFieldController: controller.toTextController,
                          title: 'to'.tr,
                          hint: '${'enter'.tr} ${'to'.tr}',
                          validator: (String? val) {
                            if (val == null || val == '')
                              return 'This Field is required'.tr;
                            return null;
                          },
                          maxLength: 100,
                          textInputType: TextInputType.text,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: CustomTextField(
                          textFieldController: controller.subjectTextController,
                          title: 'subject'.tr,
                          hint: '${'enter'.tr} ${'subject'.tr}',
                          validator: (String? val) {
                            if (val == null || val == '')
                              return 'This Field is required'.tr;
                            return null;
                          },
                          maxLength: 100,
                          textInputType: TextInputType.text,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: CustomDropDownList(
                          title: 'City'.tr,
                          textController: controller.cityTextController,
                          list: ConstantsData.city,
                          prefixIcon: Icons.location_city,
                          disableSearch: false,
                          validator: (String? val) {
                            if (val == null || val == '')
                              return 'This Field is required'.tr;
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  CustomTextField(
                    textFieldController: controller.summaryController,
                    validator: (String? val) {
                      if (val == null || val == '')
                        return 'This Field is required'.tr;
                      return null;
                    },
                    title: 'summary'.tr,
                    hint: '${'Enter'.tr} ${'summary'.tr}',
                    maxLength: 300,
                    maxLine: 3,
                    textInputType: TextInputType.multiline,
                    leading: const Icon(
                      Icons.summarize,
                      color: Colors.greenAccent,
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildSectionHeader('requireAction'.tr),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      _buildRadioOptionGeneral(
                        0,
                        'yes'.tr,
                        Colors.green,
                        controller.diwan_action == true ? 0 : 1,
                        () {
                          controller.diwan_action = true;
                          controller.update();
                        },
                      ),
                      const SizedBox(width: 10),
                      _buildRadioOptionGeneral(
                        1,
                        'no'.tr,
                        Colors.amber,
                        controller.diwan_action == true ? 0 : 1,
                        () {
                          controller.diwan_action = false;
                          controller.update();
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  _buildSectionHeader('priority'.tr),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      _buildRadioOption(0, 'low'.tr, Colors.green, controller),
                      const SizedBox(width: 8),
                      _buildRadioOption(
                        1,
                        'normal'.tr,
                        Colors.amber,
                        controller,
                      ),
                      const SizedBox(width: 8),
                      _buildRadioOption(2, 'high'.tr, Colors.red, controller),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 2,
                        child: CustomFIleScanAttachment(
                          title: 'attachment'.tr,
                          onPress: () async {
                            controller.fileAttachment =
                                await HelperMethods.getFileAttachment(
                                  context,
                                  controller.attach_size,
                                );
                            controller.update();
                          },
                          attachment: controller.fileAttachment,
                        ),
                      ),
                      // Expanded(

                      //   child: Container(width: 2, height: 30, color: Colors.grey)),
                      Expanded(
                        flex: 2,
                        child: MainButton(
                          text: 'add'.tr,
                          color: Colors.blue,
                          textColor: Colors.white,
                          prefex: const Icon(
                            Icons.add_box_sharp,
                            color: Colors.white,
                          ),
                          onPressed: () async {
                            if (!controller.formKey.currentState!.validate())
                              return;

                            if (controller.fileAttachment == null) {
                              coolAlert(
                                context: context,
                                type: CoolAlertType.error,
                                text: 'addRequiredAttachment'.tr,
                              );
                              return;
                            }

                            startLoading(context, willPop: true);
                            bool fileAdded = await controller
                                .uploadAttachmentFiles();
                            if (fileAdded == true) {
                              Diwan diwanObj = Diwan(
                                from: controller.fromTextController.text,
                                from_id: ConstantsData.currentUser?.id ?? -1,
                                from_name_user:
                                    ConstantsData.currentUser?.userName,
                                to: controller.toTextController.text,
                                city: controller.cityTextController.text,
                                subject: controller.subjectTextController.text,
                                summary: controller.summaryController.text,
                                diwan_priority: controller.priority_value,
                                diwan_action: controller.diwan_action,
                                attachment:
                                    controller.fileAttachment?.uploadFileUri,
                                byEmail: SupaApi
                                    .supaInstCLient
                                    .auth
                                    .currentSession
                                    ?.user
                                    .email,
                              );
                              Diwan? c = await controller.insert_workflow(
                                context,
                                workFlowData: diwanObj,
                              );
                              pop(context);

                              if (c != null) {
                                controller.clearFields();
                              }
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Align(
      alignment: Alignment.centerRight,
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
    );
  }

  Widget _buildRadioOption(
    int value,
    String label,
    Color color,
    WorkflowController controller,
  ) {
    bool isSelected = controller.priority_value == value;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          controller.priority_value = value;
          controller.update();
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? color : Colors.grey[100],
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: isSelected ? color : Colors.grey[300]!),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: color.withOpacity(0.3),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : null,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                isSelected ? Icons.check_circle : Icons.circle_outlined,
                color: isSelected ? Colors.white : color,
                size: 18,
              ),
              const SizedBox(width: 8),
              Text(
                label,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.black87,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRadioOptionGeneral(
    int value,
    String label,
    Color color,
    int currentValue,
    VoidCallback onPress,
  ) {
    bool isSelected = currentValue == value;
    return Expanded(
      child: GestureDetector(
        onTap: onPress,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? color : Colors.grey[100],
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: isSelected ? color : Colors.grey[300]!),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: color.withOpacity(0.3),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : null,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                isSelected ? Icons.check_circle : Icons.circle_outlined,
                color: isSelected ? Colors.white : color,
                size: 18,
              ),
              const SizedBox(width: 8),
              Text(
                label,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.black87,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
