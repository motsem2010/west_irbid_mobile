import 'package:west_irbid_mobile/models/check_in_out_model.dart';

class CheckInOutRecord {
  bool? success;
  String? employeeID;
  String? transactionDate;
  String? message;
  List<CheckInOutModel>? employeeRecords;

  CheckInOutRecord({
    this.success,
    this.employeeID,
    this.transactionDate,
    this.message,
    this.employeeRecords,
  });

  factory CheckInOutRecord.fromJson(Map<String, dynamic> json) {
    return CheckInOutRecord(
      success: json['success'] as bool?,
      employeeID: json['employeeID'] as String?,
      transactionDate: json['transactionDate'] as String?,
      message: json['message'] as String?,
      employeeRecords: (json['records'] as List<dynamic>?)
          ?.map((e) => CheckInOutModel.fromJson(e))
          .toList(),
    );
  }
}

class EmployeeRecord {
  String? transactionTime;
  int? fingerprintType;

  EmployeeRecord({this.transactionTime, this.fingerprintType});

  factory EmployeeRecord.fromJson(Map<String, dynamic> json) {
    return EmployeeRecord(
      transactionTime: json['transactionTime'],
      fingerprintType: json['fingerprintType'],
    );
  }
}
