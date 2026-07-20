class CheckInOutRecord {
  bool? success;
  int? employeeID;
  String? transactionDate;
  List<EmployeeRecord>? employeeRecords;

  CheckInOutRecord({
    this.success,
    this.employeeID,
    this.transactionDate,
    this.employeeRecords,
  });

  factory CheckInOutRecord.fromJson(Map<String, dynamic> json) {
    return CheckInOutRecord(
      success: json['success'],
      employeeID: json['employeeID'],
      transactionDate: json['transactionDate'],
      employeeRecords: (json['records'] as List<dynamic>?)
          ?.map((e) => EmployeeRecord.fromJson(e))
          .toList(),
    );
  }
}

class EmployeeRecord {
  String? transactionTime;
  int? fingerprintType;

  EmployeeRecord({
    this.transactionTime,
    this.fingerprintType,
  });

  factory EmployeeRecord.fromJson(Map<String, dynamic> json) {
    return EmployeeRecord(
      transactionTime: json['transactionTime'],
      fingerprintType: json['fingerprintType'],
    );
  }
}
