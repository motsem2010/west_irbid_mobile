class Estemlakat {
  final int? id;
  final String? serialNumber;
  final String? type;
  final String? personName;
  final int? areaNumber;
  final int? palletNumber;
  final String? hoodh;
  final String? city;
  final String? orgType;
  final String? procedureDecisionNumber;
  final String? dateOfDecision;
  final String? fadhlahType;
  final String? fadhlahCurrent;
  final String? fadhlahArea;
  final String? baladyahToMinistryNumber;
  final String? baladyahToMinistryDate;
  String? ministryToBaladyah;
  String? ministryToBaladyahDate;
  final String? sarfNumber;
  final String? sarfDate;
  final String? sarfAmt;
  final String? note;
  String? attachment;
  final int? status;
  final DateTime? creationDate;
  final String? byEmail;
  final String? byDevice;
  final bool? active;
  final bool? isDeleted;
  String? supaSignedUrl;

  Estemlakat(
      {this.id,
      this.serialNumber,
      this.type,
      this.personName,
      this.areaNumber,
      this.palletNumber,
      this.hoodh,
      this.city,
      this.orgType,
      this.procedureDecisionNumber,
      this.dateOfDecision,
      this.fadhlahType,
      this.fadhlahCurrent,
      this.fadhlahArea,
      this.baladyahToMinistryNumber,
      this.baladyahToMinistryDate,
      this.ministryToBaladyah,
      this.ministryToBaladyahDate,
      this.sarfNumber,
      this.sarfDate,
      this.sarfAmt,
      this.note,
      this.attachment,
      this.status,
      this.creationDate,
      this.byEmail,
      this.byDevice,
      this.active,
      this.isDeleted,
      this.supaSignedUrl});

  factory Estemlakat.fromJson(Map<String, dynamic> json) {
    return Estemlakat(
      id: json['id'],
      serialNumber: json['serial_number'],
      type: json['type'],
      personName: json['person_name'],
      areaNumber: json['area_number'],
      palletNumber: json['pallet_number'],
      hoodh: json['hoodh'],
      city: json['city'],
      orgType: json['org_type'],
      procedureDecisionNumber: json['procedure_decision_number'],
      dateOfDecision: json['date_of_decision'],
      fadhlahType: json['fadhlah_type'],
      fadhlahCurrent: json['fadhlah_current'],
      fadhlahArea: json['fadhlah_area'],
      baladyahToMinistryNumber: json['baladyah_to_ministry_number'],
      baladyahToMinistryDate: json['baladyah_to_ministry_date'],
      ministryToBaladyah: json['ministry_to_baladyah'],
      ministryToBaladyahDate: json['ministry_to_baladyah_date'],
      sarfNumber: json['sarf_number'],
      sarfDate: json['sarf_date'],
      sarfAmt: json['sarf_amt'],
      note: json['note'],
      attachment: json['attachment'],
      status: int.parse(json['status'] ?? '0'),
      creationDate: DateTime.parse(json['creation_date']),
      byEmail: json['by_email'],
      byDevice: json['by_device'],
      active: json['active'],
      isDeleted: json['is_deleted'],
    );
  }

  Map<String, dynamic> toJson() => {
        // 'id': id,
        'serial_number': serialNumber,
        'type': type,
        'person_name': personName,
        'area_number': areaNumber,
        'pallet_number': palletNumber,
        'hoodh': hoodh,
        'city': city,
        'org_type': orgType,
        'procedure_decision_number': procedureDecisionNumber,
        'date_of_decision':
            dateOfDecision.toString(), // Convert DateTime to String
        'fadhlah_type': fadhlahType,
        'fadhlah_current': fadhlahCurrent,
        'fadhlah_area': fadhlahArea,
        'baladyah_to_ministry_number': baladyahToMinistryNumber,
        'baladyah_to_ministry_date':
            baladyahToMinistryDate.toString(), // Convert DateTime to String
        'ministry_to_baladyah': ministryToBaladyah,
        'ministry_to_baladyah_date':
            ministryToBaladyahDate.toString(), // Convert DateTime to String
        'sarf_number': sarfNumber,
        'sarf_date': sarfDate.toString(), // Convert DateTime to String
        'sarf_amt': sarfAmt,
        'note': note,
        'attachment': attachment,
        'status': status,
        // 'creation_date': creationDate.toString(), // Convert DateTime to String
        'by_email': byEmail,
        'by_device': byDevice,
        // 'active': active,
        // 'is_deleted': isDeleted,
      };
}
