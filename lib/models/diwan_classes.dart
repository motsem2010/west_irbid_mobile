class DiwanClass {
  final int? id;
  final DateTime? createdAt;
  final String? description;
  final String? classId;
  bool? active;

  DiwanClass({
    this.id,
    this.createdAt,
    this.description,
    this.classId,
    this.active,
  });

  factory DiwanClass.fromJson(Map<String, dynamic> json) {
    return DiwanClass(
      id: json['id']?.toInt(),
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : null,
      description: json['description'],
      classId: json['class_id'],
      active: json['active'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      // 'id': id,
      // 'created_at': createdAt?.toIso8601String(),
      'description': description,
      'class_id': classId,
      'active': active,
    };
  }

  @override
  String toString() {
    return '${this.description} (${this.classId.toString()})';
  }
}
