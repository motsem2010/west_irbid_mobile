class DiwanWFProcedure {
  final String? createdAt;
  final int? diwanId;
  final int? forwardToEmpId;
  final String? forwardToEmpName;
  final String? attachment;
  final String? byUsername;
  final String? caseType;
  final int? caseTypeId;
  final String? deviceId;
  final int? id;
  final String? details;
  final bool? active;
  final bool? deleted;
  final String? by_user_email;

  DiwanWFProcedure({
    this.createdAt,
    this.diwanId,
    this.forwardToEmpId,
    this.forwardToEmpName,
    this.attachment,
    this.byUsername,
    this.caseType,
    this.caseTypeId,
    this.deviceId,
    this.id,
    this.details,
    this.active,
    this.deleted,
    this.by_user_email,
  });

  // Factory constructor with null checks
  factory DiwanWFProcedure.fromJson(Map<String, dynamic> json) {
    return DiwanWFProcedure(
      createdAt: json['created_at']?.toString() ?? '',
      diwanId: json['diwan_id'] ?? 0,
      forwardToEmpId: json['forward_to_emp_id'] != null
          ? int.tryParse(json['forward_to_emp_id'].toString())
          : null,
      forwardToEmpName: json['forward_to_emp_name']?.toString(),
      attachment: json['attachment']?.toString(),
      byUsername: json['by_username']?.toString() ?? '',
      caseType: json['case_type']?.toString() ?? '',
      caseTypeId: json['case_type_id'] != null
          ? int.tryParse(json['case_type_id'].toString())
          : 0,
      deviceId: json['device_id']?.toString() ?? '',
      id: json['id'] != null ? int.tryParse(json['id'].toString()) : 0,
      details: json['details']?.toString() ?? '',
      active: json['active'] ?? false,
      deleted: json['deleted'] ?? false,
      by_user_email: json['by_user_email']?.toString() ?? '',
    );
  }

  // Method to convert to JSON with null checks
  Map<String, dynamic> toJson() {
    return {
      // 'created_at': createdAt,
      'diwan_id': diwanId,
      'forward_to_emp_id': forwardToEmpId,
      'forward_to_emp_name': forwardToEmpName,
      'attachment': attachment,
      'by_username': byUsername,
      'case_type': caseType,
      'case_type_id': caseTypeId,
      'device_id': deviceId,
      // 'id': id,
      'details': details,

      'by_user_email': by_user_email,
    };
  }

  // Optional: Override toString for better debugging
  @override
  String toString() {
    return 'DiwanWFProcedure{'
        'id: $id, '
        'diwanId: $diwanId, '
        'caseType: $caseType, '
        'active: $active, '
        'forwardToEmpName: ${forwardToEmpName ?? 'null'}, '
        'byUsername: $byUsername'
        '}';
  }
}
