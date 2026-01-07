class DiwanWFProcedure {
  int? id;
  DateTime? createdAt;
  int? diwanId;
  int? forwardToEmpId;
  String? forwardToEmpName;
  String? attachment;
  String? by_user_email;
  String? byUsername;
  String? caseType;
  int? caseTypeId;
  String? details;
  String? deviceId;

  DiwanWFProcedure({
    this.id,
    this.createdAt,
    this.diwanId,
    this.forwardToEmpId,
    this.forwardToEmpName,
    this.attachment,
    this.by_user_email,
    this.byUsername,
    this.caseType,
    this.caseTypeId,
    this.details,
    this.deviceId,
  });

  factory DiwanWFProcedure.fromJson(Map<String, dynamic> json) {
    return DiwanWFProcedure(
      id: json['id'],
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      diwanId: json['diwan_id'],
      forwardToEmpId: json['forward_to_emp_id'],
      forwardToEmpName: json['forward_to_emp_name'],
      attachment: json['attachment'],
      by_user_email: json['by_user_email'],
      byUsername: json['byUsername'],
      caseType: json['caseType'],
      caseTypeId: json['case_type_id'],
      details: json['details'],
      deviceId: json['deviceId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'diwan_id': diwanId,
      'forward_to_emp_id': forwardToEmpId,
      'forward_to_emp_name': forwardToEmpName,
      'attachment': attachment,
      'by_user_email': by_user_email,
      'byUsername': byUsername,
      'caseType': caseType,
      'case_type_id': caseTypeId,
      'details': details,
      'deviceId': deviceId,
    };
  }
}
