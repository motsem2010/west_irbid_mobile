class Tandeem {
  int? id;
  DateTime? createdAt;
  String? tandeemType;
  String? assignTo;
  String? tandeemOwnerName;
  String? ssn;
  String? region;
  String? orgType;
  String? tijari;
  String? hoodh;
  String? hay;
  String? plane;
  String? landnumber;
  String? landnumber2;
  String? landnumber3;
  String? landArea;
  int? serialNumberInTandeem;
  String? dateOfWork;
  String? fileNumber;
  int? year;
  String? containingSubject;
  String? attachment;
  String? byDevice;
  String? user;
  String? userEmail;
  bool? isDelated;
  bool? isActive;
  String? status;
  String? note;
  int? assign_to_id;
  String? supaSignedUrl;
  String? phoneNumber;

  Tandeem(
      {this.id,
      this.createdAt,
      this.tandeemType,
      this.assignTo,
      this.tandeemOwnerName,
      this.ssn,
      this.region,
      this.orgType,
      this.tijari,
      this.hoodh,
      this.hay,
      this.plane,
      this.landnumber,
      this.landnumber2,
      this.landnumber3,
      this.landArea,
      this.serialNumberInTandeem,
      this.dateOfWork,
      this.fileNumber,
      this.supaSignedUrl,
      this.year,
      this.containingSubject,
      this.attachment,
      this.byDevice,
      this.user,
      this.userEmail,
      this.isDelated,
      this.isActive,
      this.status,
      this.note,
      this.assign_to_id,
      this.phoneNumber});

  factory Tandeem.fromJson(Map<String, dynamic> json) {
    return Tandeem(
      id: json['id'],
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      tandeemType: json['tandeem_type'],
      assignTo: json['assign_to'],
      tandeemOwnerName: json['tandeem_owner_name'],
      ssn: json['ssn'],
      region: json['region'],
      orgType: json['org_type'],
      tijari: json['tijari'],
      hoodh: json['hoodh'],
      hay: json['hay'],
      plane: json['plane'],
      landnumber: json['landnumber'],
      landnumber2: json['landnumber2'],
      landnumber3: json['landnumber3'],
      landArea: json['land_area'],
      serialNumberInTandeem: json['serial_number_in_tandeem'],
      dateOfWork: json['date_of_work'],
      fileNumber: json['file_number'],
      year: json['year'],
      containingSubject: json['containing_subject'],
      attachment: json['attachment'],
      byDevice: json['by_device'],
      user: json['user'],
      userEmail: json['user_email'],
      isDelated: json['is_delated'],
      isActive: json['is_active'],
      status: json['status'],
      note: json['note'],
      assign_to_id: json['assign_to_id'],
      phoneNumber: json['phone_number'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      // 'id': id,
      // 'created_at': createdAt?.toIso8601String(),
      'tandeem_type': tandeemType,
      'assign_to': assignTo,
      'tandeem_owner_name': tandeemOwnerName,
      'ssn': ssn,
      'region': region,
      'org_type': orgType,
      'tijari': tijari,
      'hoodh': hoodh,
      'hay': hay,
      'plane': plane,
      'landnumber': landnumber,
      'landnumber2': landnumber2,
      'landnumber3': landnumber3,
      'land_area': landArea,
      'serial_number_in_tandeem': serialNumberInTandeem,
      'date_of_work': dateOfWork,
      'file_number': fileNumber,
      'year': year,
      'containing_subject': containingSubject,
      'attachment': attachment,
      'by_device': byDevice,
      'user': user,
      'user_email': userEmail,
      // 'is_delated': isDelated,
      // 'is_active': isActive,
      'status': status,
      'note': note,
      'assign_to_id': assign_to_id,
      'phone_number': phoneNumber
    };
  }

  static List<Tandeem> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => Tandeem.fromJson(json)).toList();
  }

  Tandeem copyWith({
    int? id,
    DateTime? createdAt,
    String? tandeemType,
    String? assignTo,
    String? tandeemOwnerName,
    String? ssn,
    String? region,
    String? orgType,
    String? tijari,
    String? hoodh,
    String? hay,
    String? plane,
    String? landnumber,
    String? landnumber2,
    String? landnumber3,
    String? landArea,
    int? serialNumberInTandeem,
    String? dateOfWork,
    String? fileNumber,
    int? year,
    String? containingSubject,
    String? attachment,
    String? byDevice,
    String? user,
    String? userEmail,
    bool? isDelated,
    bool? isActive,
    String? status,
    String? note,
    String? phoneNumber,
  }) {
    return Tandeem(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        tandeemType: tandeemType ?? this.tandeemType,
        assignTo: assignTo ?? this.assignTo,
        tandeemOwnerName: tandeemOwnerName ?? this.tandeemOwnerName,
        ssn: ssn ?? this.ssn,
        region: region ?? this.region,
        orgType: orgType ?? this.orgType,
        tijari: tijari ?? this.tijari,
        hoodh: hoodh ?? this.hoodh,
        hay: hay ?? this.hay,
        plane: plane ?? this.plane,
        landnumber: landnumber ?? this.landnumber,
        landnumber2: landnumber2 ?? this.landnumber2,
        landnumber3: landnumber3 ?? this.landnumber3,
        landArea: landArea ?? this.landArea,
        serialNumberInTandeem:
            serialNumberInTandeem ?? this.serialNumberInTandeem,
        dateOfWork: dateOfWork ?? this.dateOfWork,
        fileNumber: fileNumber ?? this.fileNumber,
        year: year ?? this.year,
        containingSubject: containingSubject ?? this.containingSubject,
        attachment: attachment ?? this.attachment,
        byDevice: byDevice ?? this.byDevice,
        user: user ?? this.user,
        userEmail: userEmail ?? this.userEmail,
        isDelated: isDelated ?? this.isDelated,
        isActive: isActive ?? this.isActive,
        status: status ?? this.status,
        note: note ?? this.note,
        phoneNumber: phoneNumber ?? '');
  }
}
