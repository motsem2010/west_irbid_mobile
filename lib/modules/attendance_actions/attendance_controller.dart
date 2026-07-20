import 'dart:convert';

import 'package:get/get.dart';
import 'package:west_irbid_mobile/models/check_in_out.dart';
import 'package:west_irbid_mobile/models/check_in_out_record.dart';
import 'package:west_irbid_mobile/services_utils/constants.dart';
import 'package:west_irbid_mobile/services_utils/custom_apis_methods.dart';
import 'package:west_irbid_mobile/services_utils/endpoints.dart';
import 'package:west_irbid_mobile/services_utils/supa_fastAPI_api.dart';
import 'package:west_irbid_mobile/services_utils/translation_service.dart';

class AttendanceController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    // ever(
    //   TranslationService().rxLocale,
    //   (value) {
    //     update();
    //   },
    // );
  }

  Future<CheckInOut?> checkOutInByLocation(Map<String, dynamic> request) async {
    try {
      String? apiRes = await (CustomApi.SpeedApi(
        path: Endpoints.checkin, //+ Endpoints.check,
        isPost: true,
        bodyParameters: request,
        customBaseUrl: FastAPI_Api.baseUrl,

        // headers: Endpoints.authorizedHeaders
        //   ..addAll({'Authorization': 'Bearer $checkInOutToken'})
      ));
      if (apiRes != null) {
        final checkOutIn = CheckInOut.fromJson(jsonDecode(apiRes!));
        return checkOutIn;
      }
    } catch (e) {
      print('Error in checkOutInByLocation: $e');
      return null;
    }
  }

  Future<CheckInOutRecord?> checkOutInRecords() async {
    try {
      String? apiRes = await (CustomApi.SpeedApi(
        path: Endpoints.checkout,
        urlParameters: {
          'EmployeeID': ConstantsData.currentUser?.id.toString(),
          'TransactionDate': DateTime.now().toIso8601String().split('T')[0],
        },
        customBaseUrl: FastAPI_Api.baseUrl,
        // headers: Endpoints.authorizedHeaders
        //   ..addAll({'Authorization': 'Bearer $checkInOutToken'}),
      ));

      final checkInOutRecord = CheckInOutRecord.fromJson(
        jsonDecode(apiRes ?? ''),
      );
      return checkInOutRecord;
    } catch (e) {
      print('Error in checkOutInByLocation: $e');
      return null;
    }
  }
}
