import 'dart:convert';

class Complaints {
  final int? id;
  final DateTime? created_at;
  String? comp_area;
  final String? comp_type;
  final String? comp_person_name;
  final String? comp_phone;
  final String? comp_land_number;
  final String? comp_land_hood;
  String? comp_details;
  final String? comp_forward_to;
  String? comp_section_department;
  final String? comp_forward_history;
  final String? comp_year;
  final DateTime? comp_date;
  String? comp_classification_type;
  String? comp_procedure;
  String? comp_notes;
  final String? comp_created_by;
  final String? comp_created_device_id;
  int? comp_status;
  String? comp_attach;
  int? depatment_id;
  Complaints({
    this.id,
    this.created_at,
    this.comp_area,
    this.comp_type,
    this.comp_person_name,
    this.comp_phone,
    this.comp_land_number,
    this.comp_land_hood,
    this.comp_details,
    this.comp_forward_to,
    this.comp_section_department,
    this.comp_forward_history,
    this.comp_year,
    this.comp_date,
    this.comp_classification_type,
    this.comp_procedure,
    this.comp_notes,
    this.comp_created_by,
    this.comp_created_device_id,
    this.comp_status,
    this.comp_attach,
    this.depatment_id,
  });

  factory Complaints.fromJson(Map<String, dynamic> json) {
    return Complaints(
      id: json['id'],
      created_at: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      comp_area: json['comp_area'],
      comp_type: json['comp_type'],
      comp_person_name: json['comp_person_name'],
      comp_phone: json['comp_phone'],
      comp_land_number: json['comp_land_number'],
      comp_land_hood: json['comp_land_hood'],
      comp_details: json['comp_details'],
      comp_forward_to: json['comp_forward_to'],
      comp_section_department: json['comp_section_department'],
      comp_forward_history: json['comp_forward_history'],
      comp_year: json['comp_year'].toString(),
      // comp_date: DateTime.parse(json['comp_date']),
      comp_classification_type: json['comp_classification_type'],
      comp_procedure: json['comp_procedure'],
      comp_notes: json['comp_notes'],
      comp_created_by: json['comp_created_by'],
      comp_created_device_id: json['comp_created_device_id'],
      comp_status: json['comp_status'],
      comp_attach: json['comp_attach'],
      depatment_id: json['department_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      // 'created_at': created_at.toIso8601String(),
      'comp_area': comp_area,
      'comp_type': comp_type,
      'comp_person_name': comp_person_name,
      'comp_phone': comp_phone,
      'comp_land_number': comp_land_number,
      'comp_land_hood': comp_land_hood,
      'comp_details': comp_details,
      'comp_forward_to': comp_forward_to,
      'comp_section_department': comp_section_department,
      'comp_forward_history': comp_forward_history,
      'comp_year': comp_year,
      // 'comp_date': comp_date != null ? comp_date?.toIso8601String() : null,
      'comp_classification_type': comp_classification_type,
      'comp_procedure': comp_procedure,
      'comp_notes': comp_notes,
      'comp_created_by': comp_created_by,
      'comp_created_device_id': comp_created_device_id,
      'comp_status': comp_status,
      'comp_attach': comp_attach,
      'department_id': depatment_id
    };
  }
}
