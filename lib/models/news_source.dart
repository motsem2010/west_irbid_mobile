class NewsSource {
  final int id;
  final DateTime createdAt;
  final String name;
  final bool active;

  const NewsSource({
    required this.id,
    required this.createdAt,
    required this.name,
    required this.active,
  });

  // JSON Serialization
  factory NewsSource.fromJson(Map<String, dynamic> json) {
    return NewsSource(
      id: json['id'],
      createdAt: DateTime.parse(json['created_at']),
      name: json['name'],
      active: json['active'],
    );
  }

  // JSON Deserialization
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'created_at': createdAt.toIso8601String(),
      'name': name,
      'active': active,
    };
  }

  @override
  String toString() {
    return name;
  }
}
