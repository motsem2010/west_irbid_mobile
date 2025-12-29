class LoockupModel {
  final int id;
  final DateTime createdAt;
  final String? name;
  final String nameAr;
  final int? groupId;
  final String? groupName;
  final bool? active;
  final bool? deleted;

  LoockupModel({
    required this.id,
    required this.createdAt,
    this.name,
    required this.nameAr,
    this.groupId,
    this.groupName,
    this.active,
    this.deleted,
  });

  factory LoockupModel.fromJson(Map<String, dynamic> json) {
    return LoockupModel(
      id: json['id'],
      createdAt: DateTime.parse(json['created_at']),
      name: json['name'],
      nameAr: json['name_ar'],
      groupId: json['group_id'],
      groupName: json['group_name'],
      active: json['active'],
      deleted: json['deleted'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      // 'id': id,
      // 'created_at': createdAt.toIso8601String(),
      'name': name,
      'name_ar': nameAr,
      'group_id': groupId,
      'group_name': groupName,
      'active': active,
      'deleted': deleted,
    };
  }

  // Parse a list of transactions from JSON
  static List<LoockupModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => LoockupModel.fromJson(json)).toList();
  }

  @override
  String toString() {
    return nameAr;
  }
}
