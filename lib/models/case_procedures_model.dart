import 'dart:convert';

class CaseProcedure {
  int? id;
  DateTime? createdAt;
  int? caseId;
  int? caseDepartmentId;
  String? caseDepartmentName;
  String? caseProcedureDetails;
  String? caseByUsername;
  String? caseType;
  String? complaintStatus;
  String? caseAttachment;
  String? caseForwardTo;
  String? caseReferance;
  int? caseTypeId;
  String? device_id;
  int? emp_forward_to_id;
  String? emp_forward_to_name;

  CaseProcedure(
      {this.id,
      this.createdAt,
      this.caseId,
      this.caseDepartmentId,
      this.caseDepartmentName,
      this.caseProcedureDetails,
      this.caseByUsername,
      this.caseType,
      this.complaintStatus,
      this.caseAttachment,
      this.caseForwardTo,
      this.caseReferance,
      this.caseTypeId,
      this.device_id,
      this.emp_forward_to_id,
      this.emp_forward_to_name});

  factory CaseProcedure.fromJson(Map<String, dynamic> json) {
    return CaseProcedure(
      id: json['id'],
      createdAt: DateTime.parse(json['created_at']),
      // createdAt: json['created_at'],
      caseId: json['case_id'] as int?,
      caseDepartmentId: json['case_department_id'] as int?,
      caseDepartmentName: json['case_department_name'] as String?,
      caseProcedureDetails: json['case_procedure_details'] as String?,
      caseByUsername: json['case_by_username'] as String?,
      caseType: json['case_type'] as String?,
      complaintStatus: json['complaint_status'] as String?,
      caseAttachment: json['case_attachment'] as String?,
      caseForwardTo: json['case_forward_to'] as String?,
      caseReferance: json['case_referance'] as String?,
      caseTypeId: json['case_type_id'] as int?,
      device_id: json['device_id'],
      emp_forward_to_id: json['emp_forward_to_id'],
      emp_forward_to_name: json['emp_forward_to_name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      // 'id': id,
      // 'created_at': createdAt.toIso8601String(),
      'case_id': caseId,
      'case_department_id': caseDepartmentId,
      'case_department_name': caseDepartmentName,
      'case_procedure_details': caseProcedureDetails,
      'case_by_username': caseByUsername,
      'case_type': caseType,
      'complaint_status': complaintStatus,
      'case_attachment': caseAttachment,
      'case_forward_to': caseForwardTo,
      'case_referance': caseReferance,
      'case_type_id': caseTypeId,
      'device_id': device_id,

      'emp_forward_to_id': emp_forward_to_id,
      'emp_forward_to_name': emp_forward_to_name,
    };
  }
}
