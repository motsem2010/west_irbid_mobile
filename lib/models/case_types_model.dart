import 'dart:convert';

class Casetypes {
  final int? id;
  final DateTime? createdAt;
  final String? caseTypeEn;
  final String? caseTypeAr;
  final String? caseAddBy;

  Casetypes({
    this.id,
    this.createdAt,
    this.caseTypeEn,
    this.caseTypeAr,
    this.caseAddBy,
  });

  factory Casetypes.fromJson(Map<String, dynamic> json) {
    return Casetypes(
      id: json['id'],
      createdAt: DateTime.parse(json['created_at']),
      caseTypeEn: json['case_type_en'],
      caseTypeAr: json['case_type_ar'],
      caseAddBy: json['case_add_by'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      // 'id': id,
      // 'created_at': createdAt.toIso8601String(),
      'case_type_en': caseTypeEn,
      'case_type_ar': caseTypeAr,
      'case_add_by': caseAddBy,
    };
  }
}
