import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:west_irbid_mobile/modules/workflow/workflow_controller.dart';
import 'package:west_irbid_mobile/modules/workflow/create_workflow_view.dart';
import 'package:west_irbid_mobile/modules/workflow/my_workflow_view.dart';

class WorkflowView extends GetView<WorkflowController> {
  const WorkflowView({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(title: Text('workflow'.tr), centerTitle: true),
        body: GetBuilder<WorkflowController>(
          builder: (controller) {
            return IndexedStack(
              index: controller.selectedIndex,
              children: const [CreateWorkflowView(), MyWorkflowView()],
            );
          },
        ),
        bottomNavigationBar: GetBuilder<WorkflowController>(
          builder: (controller) => BottomNavigationBar(
            currentIndex: controller.selectedIndex,
            onTap: (index) {
              controller.selectedIndex = index;
              controller.update();
            },
            items: [
              BottomNavigationBarItem(
                icon: const Icon(Icons.add_circle_outline),
                label: 'workflowCreate'.tr,
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.list_alt),
                label: 'myWorkflow'.tr,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
