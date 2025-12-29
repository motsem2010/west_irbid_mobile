import 'dart:convert';

import 'package:west_irbid_mobile/services_utils/translation_service.dart';

class Department {
  final int? id;
  final DateTime? createdAt;
  final String? departmentName;
  final String? departmentNameAr;
  bool? active;

  Department({
    this.id,
    this.createdAt,
    this.departmentName,
    this.departmentNameAr,
    this.active,
  });

  factory Department.fromJson(Map<String, dynamic> json) {
    return Department(
      id: json['id'],
      // createdAt: DateTime.parse(json['created_at']),
      departmentName: json['department_name'],
      departmentNameAr: json['department_name_ar'],
      active: json['active'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      // 'id': id,
      // 'created_at': createdAt.toIso8601String(),
      'department_name': departmentName,
      'department_name_ar': departmentNameAr,
      'active': active,
    };
  }

  @override
  String toString() {
    return (TranslationService().isLocaleArabic()
            ? departmentNameAr
            : departmentName) ??
        departmentName.toString();
  }
}
