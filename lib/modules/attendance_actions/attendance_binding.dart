import 'package:get/get.dart';
import 'package:west_irbid_mobile/modules/attendance_actions/attendance_controller.dart';

class AttendanceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AttendanceController>(() => AttendanceController());
  }
}
