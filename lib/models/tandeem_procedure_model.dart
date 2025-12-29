class TandeemProcedure {
  int? id;
  DateTime? createdAt;
  int? tandeemId;
  String? assignTo;
  int? procedureTypeId;
  String? procedureType;
  String? attachment;
  bool? deleted;
  String? byUser;
  String? byDevice;
  String? byEmail;
  int? empForwardToId;
  String? empForwardToName;
  String? note;
  String? status;
  bool? seen;

  TandeemProcedure(
      {this.createdAt,
      this.id,
      this.tandeemId,
      this.assignTo,
      this.procedureTypeId,
      this.procedureType,
      this.attachment,
      this.deleted,
      this.byUser,
      this.byDevice,
      this.byEmail,
      this.empForwardToId,
      this.empForwardToName,
      this.note,
      this.status,
      this.seen});

  factory TandeemProcedure.fromJson(Map<String, dynamic> json) {
    return TandeemProcedure(
      id: json['id'] as int,
      createdAt: DateTime.parse(json['created_at']),
      tandeemId: json['tandeem_id'],
      assignTo: json['assign_to'],
      procedureTypeId: json['procedure_type_id'],
      procedureType: json['procedure_type'],
      attachment: json['attachment'],
      deleted: json['deleted'],
      byUser: json['by_user'],
      byDevice: json['by_device'],
      byEmail: json['by_email'],
      empForwardToId: json['emp_forward_to_id'],
      empForwardToName: json['emp_forward_to_name'],
      note: json['note'],
      status: json['status'],
      seen: json['seen'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      // 'id': id,
      // 'created_at': createdAt?.toIso8601String(),
      'tandeem_id': tandeemId,
      'assign_to': assignTo,
      'procedure_type_id': procedureTypeId,
      'procedure_type': procedureType,
      'attachment': attachment,
      'deleted': deleted,
      'by_user': byUser,
      'by_device': byDevice,
      'by_email': byEmail,
      'emp_forward_to_id': empForwardToId,
      'emp_forward_to_name': empForwardToName,
      'note': note,
      'status': status,
      'seen': seen
    };
  }

  // Helper method to create a list of TandeemProcedures from JSON array
  static List<TandeemProcedure> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => TandeemProcedure.fromJson(json)).toList();
  }
}
