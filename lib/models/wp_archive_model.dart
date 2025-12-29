class WPArchive {
  final int? id;
  final String? uuid;
  final String? wpNumber;
  final String? wpDate;
  final String? qushanNumber;
  final String? qushanDate;
  final String? fileNumber;
  final String? area;
  final String? buildType;
  final String? tijari;
  final String? feesSketch;
  final String? feesReceiptNumber;
  final String? receiptDate;
  final String? ownerName;
  final String? licenceOwnerSsn;
  final String? planEngname;
  final String? city;
  final String? hoodh;
  final String? hay;
  final String? landNumber;
  final String? plane;
  final String? landArea;
  final String? decisionNumber;
  final String? decisionDate;
  final String? generalNotes;
  final String? workingEmp;
  final String? insertUsername;
  final String? updatedUsername;
  final String? insertDate;
  final String? updateDate;
  final String? insertMacId;
  final String? updateMacId;
  final String? insertMachineNameId;
  final String? updateMachineNameId;
  final String? serverAddTime;
  final String? authUuid;
  final String? attachment;
  final bool? isDeleted;
  final bool? isUpdated;
  final String? createdAt;
  final String? fileAttachAll;
  String? supaSignedUrlAttachment;
  String? supaSignedUrlAttachmentAllPapers;

  WPArchive(
      {this.id,
      this.uuid,
      this.wpNumber,
      this.wpDate,
      this.qushanNumber,
      this.qushanDate,
      this.fileNumber,
      this.area,
      this.buildType,
      this.tijari,
      this.feesSketch,
      this.feesReceiptNumber,
      this.receiptDate,
      this.ownerName,
      this.licenceOwnerSsn,
      this.planEngname,
      this.city,
      this.hoodh,
      this.hay,
      this.landNumber,
      this.plane,
      this.landArea,
      this.decisionNumber,
      this.decisionDate,
      this.generalNotes,
      this.workingEmp,
      this.insertUsername,
      this.updatedUsername,
      this.insertDate,
      this.updateDate,
      this.insertMacId,
      this.updateMacId,
      this.insertMachineNameId,
      this.updateMachineNameId,
      this.serverAddTime,
      this.authUuid,
      this.attachment,
      this.isDeleted,
      this.isUpdated,
      this.createdAt,
      this.fileAttachAll,
      this.supaSignedUrlAttachment,
      this.supaSignedUrlAttachmentAllPapers});

  // Factory constructor to create WPArchive from JSON
  factory WPArchive.fromJson(Map<String, dynamic> json) {
    return WPArchive(
      id: json['id'] as int?,
      uuid: json['uuid'] as String?,
      wpNumber: json['wp_number'] as String?,
      wpDate: json['wp_date'] as String?,
      qushanNumber: json['qushan_number'] as String?,
      qushanDate: json['qushan_date'] as String?,
      fileNumber: json['file_number'] as String?,
      area: json['area'] as String?,
      buildType: json['build_type'] as String?,
      tijari: json['tijari'] as String?,
      feesSketch: json['fees_sketch'] as String?,
      feesReceiptNumber: json['fees_receipt_number'] as String?,
      receiptDate: json['receipt_date'] as String?,
      ownerName: json['owner_name'] as String?,
      licenceOwnerSsn: json['licence_owner_ssn'] as String?,
      planEngname: json['plan_engname'] as String?,
      city: json['city'] as String?,
      hoodh: json['hoodh'] as String?,
      hay: json['hay'] as String?,
      landNumber: json['land_number'] as String?,
      plane: json['plane'] as String?,
      landArea: json['land_area'] as String?,
      decisionNumber: json['decision_number'] as String?,
      decisionDate: json['decision_date'] as String?,
      generalNotes: json['general_notes'] as String?,
      workingEmp: json['working_emp'] as String?,
      insertUsername: json['insert_username'] as String?,
      updatedUsername: json['updatet_username'] as String?,
      insertDate: json['insert_date'] as String?,
      updateDate: json['update_date'] as String?,
      insertMacId: json['insert_mac_id'] as String?,
      updateMacId: json['update_mac_id'] as String?,
      insertMachineNameId: json['insert_machine_name_id'] as String?,
      updateMachineNameId: json['update_machine_name_id'] as String?,
      serverAddTime: json['server_add_timw'] as String?,
      authUuid: json['auth_uuid'] as String?,
      attachment: json['attachment'] as String?,
      isDeleted: json['is_deleted'] as bool?,
      isUpdated: json['is_updated'] as bool?,
      createdAt: json['created_at'] as String?,
      fileAttachAll: json['file_attach_all'] as String?,
    );
  }

  // Method to convert WPArchive to JSON
  Map<String, dynamic> toJson() {
    return {
      // 'id': id,
      'uuid': uuid,
      'wp_number': wpNumber,
      'wp_date': wpDate,
      'qushan_number': qushanNumber,
      'qushan_date': qushanDate,
      'file_number': fileNumber,
      'area': area,
      'build_type': buildType,
      'tijari': tijari,
      'fees_sketch': feesSketch,
      'fees_receipt_number': feesReceiptNumber,
      'receipt_date': receiptDate,
      'owner_name': ownerName,
      'licence_owner_ssn': licenceOwnerSsn,
      'plan_engname': planEngname,
      'city': city,
      'hoodh': hoodh,
      'hay': hay,
      'land_number': landNumber,
      'plane': plane,
      'land_area': landArea,
      'decision_number': decisionNumber,
      'decision_date': decisionDate,
      'general_notes': generalNotes,
      'working_emp': workingEmp,
      'insert_username': insertUsername,
      'updatet_username': updatedUsername,
      'insert_date': insertDate,
      'update_date': updateDate,
      'insert_mac_id': insertMacId,
      'update_mac_id': updateMacId,
      'insert_machine_name_id': insertMachineNameId,
      'update_machine_name_id': updateMachineNameId,
      'server_add_timw': serverAddTime,
      'auth_uuid': authUuid,
      'attachment': attachment,
      'is_deleted': isDeleted,
      'is_updated': isUpdated,
      'created_at': createdAt,
      'file_attach_all': fileAttachAll,
    };
  }

  // CopyWith method for creating modified copies
  WPArchive copyWith({
    int? id,
    String? uuid,
    String? wpNumber,
    String? wpDate,
    String? qushanNumber,
    String? qushanDate,
    String? fileNumber,
    String? area,
    String? buildType,
    String? tijari,
    String? feesSketch,
    String? feesReceiptNumber,
    String? receiptDate,
    String? ownerName,
    String? licenceOwnerSsn,
    String? planEngname,
    String? city,
    String? hoodh,
    String? hay,
    String? landNumber,
    String? plane,
    String? landArea,
    String? decisionNumber,
    String? decisionDate,
    String? generalNotes,
    String? workingEmp,
    String? insertUsername,
    String? updatedUsername,
    String? insertDate,
    String? updateDate,
    String? insertMacId,
    String? updateMacId,
    String? insertMachineNameId,
    String? updateMachineNameId,
    String? serverAddTime,
    String? authUuid,
    String? attachment,
    bool? isDeleted,
    bool? isUpdated,
    String? createdAt,
    String? fileAttachAll,
  }) {
    return WPArchive(
      id: id ?? this.id,
      uuid: uuid ?? this.uuid,
      wpNumber: wpNumber ?? this.wpNumber,
      wpDate: wpDate ?? this.wpDate,
      qushanNumber: qushanNumber ?? this.qushanNumber,
      qushanDate: qushanDate ?? this.qushanDate,
      fileNumber: fileNumber ?? this.fileNumber,
      area: area ?? this.area,
      buildType: buildType ?? this.buildType,
      tijari: tijari ?? this.tijari,
      feesSketch: feesSketch ?? this.feesSketch,
      feesReceiptNumber: feesReceiptNumber ?? this.feesReceiptNumber,
      receiptDate: receiptDate ?? this.receiptDate,
      ownerName: ownerName ?? this.ownerName,
      licenceOwnerSsn: licenceOwnerSsn ?? this.licenceOwnerSsn,
      planEngname: planEngname ?? this.planEngname,
      city: city ?? this.city,
      hoodh: hoodh ?? this.hoodh,
      hay: hay ?? this.hay,
      landNumber: landNumber ?? this.landNumber,
      plane: plane ?? this.plane,
      landArea: landArea ?? this.landArea,
      decisionNumber: decisionNumber ?? this.decisionNumber,
      decisionDate: decisionDate ?? this.decisionDate,
      generalNotes: generalNotes ?? this.generalNotes,
      workingEmp: workingEmp ?? this.workingEmp,
      insertUsername: insertUsername ?? this.insertUsername,
      updatedUsername: updatedUsername ?? this.updatedUsername,
      insertDate: insertDate ?? this.insertDate,
      updateDate: updateDate ?? this.updateDate,
      insertMacId: insertMacId ?? this.insertMacId,
      updateMacId: updateMacId ?? this.updateMacId,
      insertMachineNameId: insertMachineNameId ?? this.insertMachineNameId,
      updateMachineNameId: updateMachineNameId ?? this.updateMachineNameId,
      serverAddTime: serverAddTime ?? this.serverAddTime,
      authUuid: authUuid ?? this.authUuid,
      attachment: attachment ?? this.attachment,
      isDeleted: isDeleted ?? this.isDeleted,
      isUpdated: isUpdated ?? this.isUpdated,
      createdAt: createdAt ?? this.createdAt,
      fileAttachAll: fileAttachAll ?? this.fileAttachAll,
    );
  }

  // Null-aware operator override for equality
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is WPArchive &&
        other.id == id &&
        other.uuid == uuid &&
        other.wpNumber == wpNumber &&
        other.wpDate == wpDate &&
        other.qushanNumber == qushanNumber &&
        other.qushanDate == qushanDate &&
        other.fileNumber == fileNumber &&
        other.area == area &&
        other.buildType == buildType &&
        other.tijari == tijari &&
        other.feesSketch == feesSketch &&
        other.feesReceiptNumber == feesReceiptNumber &&
        other.receiptDate == receiptDate &&
        other.ownerName == ownerName &&
        other.licenceOwnerSsn == licenceOwnerSsn &&
        other.planEngname == planEngname &&
        other.city == city &&
        other.hoodh == hoodh &&
        other.hay == hay &&
        other.landNumber == landNumber &&
        other.plane == plane &&
        other.landArea == landArea &&
        other.decisionNumber == decisionNumber &&
        other.decisionDate == decisionDate &&
        other.generalNotes == generalNotes &&
        other.workingEmp == workingEmp &&
        other.insertUsername == insertUsername &&
        other.updatedUsername == updatedUsername &&
        other.insertDate == insertDate &&
        other.updateDate == updateDate &&
        other.insertMacId == insertMacId &&
        other.updateMacId == updateMacId &&
        other.insertMachineNameId == insertMachineNameId &&
        other.updateMachineNameId == updateMachineNameId &&
        other.serverAddTime == serverAddTime &&
        other.authUuid == authUuid &&
        other.attachment == attachment &&
        other.isDeleted == isDeleted &&
        other.isUpdated == isUpdated &&
        other.createdAt == createdAt &&
        other.fileAttachAll == fileAttachAll;
  }

  @override
  int get hashCode {
    return Object.hashAll([
      id,
      uuid,
      wpNumber,
      wpDate,
      qushanNumber,
      qushanDate,
      fileNumber,
      area,
      buildType,
      tijari,
      feesSketch,
      feesReceiptNumber,
      receiptDate,
      ownerName,
      licenceOwnerSsn,
      planEngname,
      city,
      hoodh,
      hay,
      landNumber,
      plane,
      landArea,
      decisionNumber,
      decisionDate,
      generalNotes,
      workingEmp,
      insertUsername,
      updatedUsername,
      insertDate,
      updateDate,
      insertMacId,
      updateMacId,
      insertMachineNameId,
      updateMachineNameId,
      serverAddTime,
      authUuid,
      attachment,
      isDeleted,
      isUpdated,
      createdAt,
      fileAttachAll,
    ]);
  }

  @override
  String toString() {
    return 'WPArchive(id: $id, uuid: $uuid, wpNumber: $wpNumber, wpDate: $wpDate, qushanNumber: $qushanNumber, qushanDate: $qushanDate, fileNumber: $fileNumber, area: $area, buildType: $buildType, tijari: $tijari, feesSketch: $feesSketch, feesReceiptNumber: $feesReceiptNumber, receiptDate: $receiptDate, ownerName: $ownerName, licenceOwnerSsn: $licenceOwnerSsn, planEngname: $planEngname, city: $city, hoodh: $hoodh, hay: $hay, landNumber: $landNumber, plane: $plane, landArea: $landArea, decisionNumber: $decisionNumber, decisionDate: $decisionDate, generalNotes: $generalNotes, workingEmp: $workingEmp, insertUsername: $insertUsername, updatedUsername: $updatedUsername, insertDate: $insertDate, updateDate: $updateDate, insertMacId: $insertMacId, updateMacId: $updateMacId, insertMachineNameId: $insertMachineNameId, updateMachineNameId: $updateMachineNameId, serverAddTime: $serverAddTime, authUuid: $authUuid, attachment: $attachment, isDeleted: $isDeleted, isUpdated: $isUpdated, createdAt: $createdAt, fileAttachAll: $fileAttachAll)';
  }
}
