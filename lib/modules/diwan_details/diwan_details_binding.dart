import 'package:get/get.dart';
import 'diwan_details_controller.dart';

class DiwanDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DiwanDetailsController>(() => DiwanDetailsController());
  }
}
