import 'package:get/get.dart';
import 'package:west_irbid_mobile/modules/homeDashboard/category_one_view.dart';
import 'package:west_irbid_mobile/modules/homeDashboard/category_two_view.dart';
import 'package:west_irbid_mobile/services_utils/constants.dart';

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

  @override
  void onClose() {
    super.onClose();
  }
}
