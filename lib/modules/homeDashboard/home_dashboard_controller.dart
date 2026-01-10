import 'package:get/get.dart';
import 'package:west_irbid_mobile/modules/homeDashboard/category_one_view.dart';
import 'package:west_irbid_mobile/modules/homeDashboard/category_two_view.dart';
import 'package:west_irbid_mobile/modules/diwan/diwan_view.dart';
import 'package:west_irbid_mobile/modules/workflow/workflow_binding.dart';
import 'package:west_irbid_mobile/modules/workflow/workflow_view.dart';
import 'package:west_irbid_mobile/services_utils/constants.dart';
import 'package:west_irbid_mobile/services_utils/supa_api.dart';
import 'package:west_irbid_mobile/services_utils/ui_helpers.dart';

class HomeDashboardController extends GetxController {
  // Current user
  var currentUser = ConstantsData.currentUser;

  // Observable for selected category
  RxInt selectedCategory = 0.obs;

  @override
  void onInit() {
    super.onInit();
    // Initialize any dashboard data here
  }

  @override
  void onReady() {
    super.onReady();
  }

  // Navigate to category page 1
  void navigateToCategoryOne() {
    Get.to(() => const CategoryOneView());
  }

  // Navigate to category page 2
  void navigateToCategoryTwo() {
    Get.to(() => const CategoryTwoView());
  }

  // Navigate to Diwan view
  void navigateToDiwan() async {
    startLoading(Get.context!);
    await initailData();
    pop(Get.context!);
    Get.to(() => const DiwanView());
  }

  // Navigate to Workflow view
  void navigateToWorkflow() async {
    startLoading(Get.context!);
    await initailData();
    pop(Get.context!);
    Get.to(() => const WorkflowView(), binding: WorkflowBinding());
  }

  @override
  void onClose() {
    super.onClose();
  }

  initailData() async {
    if (ConstantsData.listUsers.isEmpty) {
      await SupaApi.get_users_list();
    }
    if (ConstantsData.departments.isEmpty) {
      await SupaApi.get_departments_list(context: Get.context!);
    }
    // if (ConstantsData.listUsers.isEmpty) {
    //   await SupaApi.get_users_list();
    // }
    if (ConstantsData.diwanCLassesList.isEmpty) {
      await SupaApi.get_diwan_classes(context: Get.context!);
    }
    update();
  }
}
