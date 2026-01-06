import 'package:get/get.dart';
import 'package:west_irbid_mobile/modules/diwan/diwan_controller.dart';

class DiwanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DiwanController>(() => DiwanController());
  }
}
