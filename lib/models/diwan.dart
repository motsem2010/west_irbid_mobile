import 'dart:convert';

class Diwan {
  int? id;
  DateTime? createdAt;
  String? diwanType;
  int? diwanClasificationId;
  String? diwanClasificationName;
  String? diwanFromTo;
  String? diwanSourceFromTo;
  int? departmentId;
  String? departmentName;
  int? forwardEmpId;
  String? forwardEmpName;
  String? serialNumber;
  String? dateOfIssue;
  String? dateOfRecived;
  String? regionClassification;
  String? summary;
  String? trasol;
  String? overallNumber;
  String? attachment;
  String? copyTo;
  int? status;
  String? byEmail;
  String? byDevice;
  bool? active;
  bool? isDeleted;
  String? old_attachment;
  String? old_diwan_classification;
  String? update_actions;
  String? updated_by;
  bool? is_updated;
  String? supaSignedUrl;
  bool? diwan_action, processed_by_diwan; //workflow  هل تتطلب اجراء
  int? diwan_priority; //workflow   الاولويه للمعامله المنشئه
  String? subject,
      from,
      to,
      city; //workflow تفاصيل المعاملو المنشئه م ناليوزرات
  int? from_id; //workflow الشخص المنشذ للمعامله
  int? diwan_id; //تخزين رقم الديون workflow
  String? from_name_user; //workflow تخزين اي دي المحول لهم المعامله
  String? copy_to_ids,
      copy_to_names; //workflow تخزين اسماء المحولل لهم المعامله
  int? wf_id; // workflow رقم المعاملة الاصليه المنشئه
  Diwan(
      {this.id,
      this.createdAt,
      this.diwanType,
      this.diwanClasificationId,
      this.diwanClasificationName,
      this.diwanFromTo,
      this.diwanSourceFromTo,
      this.departmentId,
      this.departmentName,
      this.forwardEmpId,
      this.forwardEmpName,
      this.serialNumber,
      this.dateOfIssue,
      this.dateOfRecived,
      this.regionClassification,
      this.summary,
      this.trasol,
      this.overallNumber,
      this.attachment,
      this.copyTo,
      this.status,
      this.byEmail,
      this.byDevice,
      this.active,
      this.isDeleted,
      this.old_attachment,
      this.old_diwan_classification,
      this.update_actions,
      this.updated_by,
      this.is_updated,
      this.supaSignedUrl,
      this.diwan_action,
      this.diwan_priority,
      this.from,
      this.subject,
      this.to,
      this.from_id,
      this.city,
      this.diwan_id,
      this.from_name_user,
      this.copy_to_ids,
      this.copy_to_names,
      this.processed_by_diwan = false,
      this.wf_id});

  factory Diwan.fromJson(Map<String, dynamic> json) {
    return Diwan(
        id: json['id'] as int?,
        createdAt: json['created_at'] != null
            ? DateTime.parse(json['created_at'])
            : null,
        diwanType: json['diwan_type'] as String?,
        diwanClasificationId: json['diwan_clasification_id'] as int?,
        diwanClasificationName: json['diwan_clasification_name'] as String?,
        diwanFromTo: json['diwan_from_to'] as String?,
        diwanSourceFromTo: json['diwan_source_from_to'] as String?,
        departmentId: json['department_id'] as int?,
        departmentName: json['department_name'] as String?,
        forwardEmpId: json['forward_emp_id'] as int?,
        forwardEmpName: json['forward_emp_name'] as String?,
        serialNumber: json['serial_number'] as String?,
        dateOfIssue: json['date_of_issue'] as String?,
        dateOfRecived: json['date_of_recived'] as String?,
        regionClassification: json['region_classification'] as String?,
        summary: json['summary'] as String?,
        trasol: json['trasol'] as String?,
        overallNumber: json['overall_number'] as String?,
        attachment: json['attachment'] as String?,
        copyTo: json['copy_to'] as String?,
        status: json['status'] != null ? int.parse(json['status']) : null,
        byEmail: json['by_email'] as String?,
        byDevice: json['by_device'] as String?,
        active: json['active'] as bool?,
        isDeleted: json['is_deleted'],
        old_attachment: json['old_attachment'],
        old_diwan_classification: json['old_diwan_classification'],
        update_actions: json['update_actions'],
        updated_by: json['updated_by'],
        is_updated: json['is_updated'],
        diwan_action: json['diwan_action'],
        diwan_priority: json['diwan_priority'],
        subject: json['subject'],
        from: json['from'],
        to: json['to'],
        city: json['city'],
        from_id: json['from_id'] as int?,
        diwan_id: json['diwan_id'] as int?,
        from_name_user: json['from_name_user'],
        copy_to_ids: json['copy_to_ids'],
        copy_to_names: json['copy_to_names'],
        processed_by_diwan: json['processed_by_diwan'],
        wf_id: json['wf_id'] as int?);
  }

  Map<String, dynamic> toJson() {
    return {
      // 'id': id,
      // 'created_at': createdAt?.toIso8601String(),
      'diwan_type': diwanType,
      'diwan_clasification_id': diwanClasificationId,
      'diwan_clasification_name': diwanClasificationName,
      'diwan_from_to': diwanFromTo,
      'diwan_source_from_to': diwanSourceFromTo,
      'department_id': departmentId,
      'department_name': departmentName,
      'forward_emp_id': forwardEmpId,
      'forward_emp_name': forwardEmpName,
      'serial_number': serialNumber,
      'date_of_issue': dateOfIssue,
      'date_of_recived': dateOfRecived,
      'region_classification': regionClassification,
      'summary': summary,
      'trasol': trasol,
      'overall_number': overallNumber,
      'attachment': attachment,
      'copy_to': copyTo,
      'status': status,
      'by_email': byEmail,
      'by_device': byDevice,
      'active': active,
      'is_deleted': isDeleted,
      'old_attachment': old_attachment,
      'old_diwan_classification': old_diwan_classification,
      'update_actions': update_actions,
      'updated_by': updated_by,
      'is_updated': is_updated,
      'diwan_action': diwan_action,
      'diwan_priority': diwan_priority,
      'from': from,
      'to': to,
      'subject': subject,
      'from_id': from_id,
      'city': city,
      'diwan_id': diwan_id,
      'from_name_user': from_name_user,
      'copy_to_names': copy_to_names,
      'copy_to_ids': copy_to_ids,
      'processed_by_diwan': processed_by_diwan ?? false,
      'wf_id': wf_id
    };
  }
}
