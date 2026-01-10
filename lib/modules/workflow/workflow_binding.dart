import 'package:get/get.dart';
import 'package:west_irbid_mobile/modules/workflow/workflow_controller.dart';

class WorkflowBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WorkflowController>(() => WorkflowController());
  }
}
