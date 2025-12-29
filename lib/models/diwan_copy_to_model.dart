class DiwanCopyTo {
  final int? id;
  final String? createdAt;
  final int? diwanId;
  final int? forwardToUserId;
  final bool? requireAction;
  final int? addByUserId;
  final String? forwardToUserName;
  final bool? isDeleted;
  final bool? actionDone;
  final int? actionProcedureId;
  String? from_name, subject;

  DiwanCopyTo(
      {this.id,
      this.createdAt,
      this.diwanId,
      this.forwardToUserId,
      this.requireAction,
      this.addByUserId,
      this.forwardToUserName,
      this.isDeleted,
      this.actionDone,
      this.actionProcedureId,
      this.from_name,
      this.subject});

  factory DiwanCopyTo.fromJson(Map<String, dynamic> json) {
    return DiwanCopyTo(
      id: json['id'] as int,
      createdAt: json['created_at'] as String,
      diwanId: json['diwan_id'] as int,
      forwardToUserId: json['forward_to_user_id'] as int,
      requireAction: json['require_action'] as bool,
      addByUserId: json['add_by_user_id'] as int,
      forwardToUserName: json['forward_to_user_name'] as String,
      isDeleted: json['is_deleted'] as bool,
      actionDone: json['action_done'] as bool,
      actionProcedureId: json['action_procedure_id'] as int?,
      from_name: json['from_name'],
      subject: json['subject'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      // 'id': id,
      // 'created_at': createdAt,
      'diwan_id': diwanId,
      'forward_to_user_id': forwardToUserId,
      'require_action': requireAction,
      'add_by_user_id': addByUserId,
      'forward_to_user_name': forwardToUserName,
      'is_deleted': isDeleted,
      'action_done': actionDone,
      'action_procedure_id': actionProcedureId,
      'from_name': from_name,
      'subject': subject
    };
  }
}
