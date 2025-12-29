class WPModel {
  int? id;
  String? uuid;
  String? WPNumber; //NEw
  String? WPserialNumber; //NEw
  String? WPSerialDate; //NEw
  double? WPFees; //NEW
  int? WPFeesRecipt; //NEW
  String? WPFeesDate; //NEW
  String? type; //NE

  String? qushanNumber;
  String? qushanDate;
  String? fileNumber;
  double? licenceDetailsArea;
  String? licenceDetailsBuildType;
  String? licenceDetailsTijari;
  String? file_wp_workFlow;
  String? file_wp_decision;
  String? file_wp_fees_recipt;

  // double? licenceFeesSketch;
  // double? licenceFeesLicence;
  // double? licenceFeesInsurance;
  // int? licenceFeesReceiptNumber;
  // String? licenceFeesReceiptDate;
  String? licenceOwnerName;
  String? licenceOwnerSSN;
  String? licencePlanEngname;
  String? licencePlanAreaSakan;
  String? licenceBuildDetailsArea;
  String? licenceBuildDetailsHoodh;
  String? licenceBuildDetailsHay;
  int? licenceBuildDetailsLandNumber;
  int? licenceBuildDetailsPlane;
  String? licenceBuildDetailsLandArea;
  String? licenceCity;
  String? licenceFinalNumber;
  String? licenceLandSurvey;
  String? licenceDecisionNumber;
  String? licenceDecisionDate;
  String? licenceIncomingNumber;
  List<int>? floors;
  String? fileQoshan;
  String? fileLandSketch;
  String? fileRegistration;
  String? fileGeneralLocation;
  String? fileLicence; // use for the build licence
  String? fileSurvivor;
  String? fileAnnotations2;
  String? fileClearance;
  String? fileLicencedSurveyor;
  String? fileLegalUndertaking;
  String? filePartnerApproval;
  String? fileContractingContract;
  String? landSurveyorNotes;
  String? generalNotes;
  String? transformTo;
  // ----
  String? insertUserName;
  String? updatetUserName;
  String? insertDate;
  String? updateDate;
  String? insertMacId;
  String? updateMacId;
  String? insertMachineNameId;
  String? updateMachineNameId;

  WPModel({
    this.id,
    this.uuid,
    // new fields
    this.WPFees, //NEW
    this.WPFeesDate, //NEW
    this.WPFeesRecipt, //NEW
    this.WPNumber, //NEW
    this.WPSerialDate, //NEW
    this.WPserialNumber, //NEW
    this.file_wp_fees_recipt,
    this.file_wp_decision,
    this.file_wp_workFlow,
    //end of new fields
    this.qushanNumber,
    this.qushanDate,
    this.fileNumber,
    this.licenceDetailsArea,
    this.licenceDetailsBuildType,
    this.licenceDetailsTijari,
    this.type,
    // this.licenceFeesSketch,
    // this.licenceFeesLicence,
    // this.licenceFeesInsurance,
    // this.licenceFeesReceiptNumber,
    // this.licenceFeesReceiptDate,
    this.licenceOwnerName,
    this.licenceOwnerSSN,
    this.licencePlanEngname,
    this.licencePlanAreaSakan,
    this.licenceBuildDetailsArea,
    this.licenceBuildDetailsHoodh,
    this.licenceBuildDetailsHay,
    this.licenceBuildDetailsLandNumber,
    this.licenceBuildDetailsPlane,
    this.licenceBuildDetailsLandArea,
    this.licenceCity,
    this.licenceFinalNumber,
    this.licenceLandSurvey,
    this.licenceDecisionNumber,
    this.licenceDecisionDate,
    this.licenceIncomingNumber,
    this.floors,
    this.fileQoshan,
    this.fileLandSketch,
    this.fileRegistration,
    this.fileGeneralLocation,
    this.fileLicence,
    this.fileSurvivor,
    this.fileAnnotations2,
    this.fileClearance,
    this.fileLicencedSurveyor,
    this.fileLegalUndertaking,
    this.filePartnerApproval,
    this.fileContractingContract,
    this.landSurveyorNotes,
    this.generalNotes,
    this.transformTo,
    this.insertUserName,
    this.updatetUserName,
    this.insertDate,
    this.updateDate,
    this.insertMacId,
    this.updateMacId,
    this.insertMachineNameId,
    this.updateMachineNameId,
  });

  WPModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uuid = json['uuid'];

    //new fields
    WPFees = json['wp_fees'];
    WPFeesDate = json['wp_fees_date'];
    WPFeesRecipt = json['wp_fees_recipt'] ?? '0';
    WPNumber = json['wp_number'];
    WPSerialDate = json['wp_serial_date'];
    WPserialNumber = json['wp_serial_number'];
    type = json['type'];
    file_wp_fees_recipt = json['file_wp_fees_recipt'];
    file_wp_decision = json['file_wp_decision'];
    file_wp_workFlow = json['file_wp_workFlow'];
    //end of new

    qushanNumber = json['qushan_number'];
    qushanDate = json['qushan_date'];
    fileNumber = json['file_number'];
    licenceDetailsArea = json['licence_details_area'];
    licenceDetailsBuildType = json['licence_details_build_type'];
    licenceDetailsTijari = json['licence_details_tijari'];
    // licenceFeesSketch = double.parse(json['licence_fees_sketch'].toString());
    // licenceFeesLicence = double.parse(json['licence_fees_licence'].toString());
    // licenceFeesInsurance =
    //     double.parse(json['licence_fees_insurance'].toString());
    // licenceFeesReceiptNumber = json['licence_fees_receipt_number'];
    // licenceFeesReceiptDate = json['licence_fees_receipt_date'];
    licenceOwnerName = json['licence_owner_name'];
    licenceOwnerSSN = json['licence_owner_ssn'];
    licencePlanEngname = json['licence_plan_engname'];
    licencePlanAreaSakan = json['licence_plan_area_sakan'];
    licenceBuildDetailsArea = json['licence_build_details_area'];
    licenceBuildDetailsHoodh = json['licence_build_details_hoodh'];
    licenceBuildDetailsHay = json['licence_build_details_hay'];
    licenceBuildDetailsLandNumber = json['licence_build_details_land_number'];
    licenceBuildDetailsPlane = json['licence_build_details_plane'];
    licenceBuildDetailsLandArea = json['licence_build_details_land_area'];
    licenceCity = json['licence_city'];
    licenceFinalNumber = json['licence_final_number'];
    licenceLandSurvey = json['licence_land_survey'];
    licenceDecisionNumber = json['licence_decision_number'];
    licenceDecisionDate = json['licence_decision_date'];
    licenceIncomingNumber = json['licence_incoming_number'];
    // if (json['floors'] != null) floors = json['floors'].cast<List>();
    fileQoshan = json['file_qoshan'];
    fileLandSketch = json['file_land_sketch'];
    fileRegistration = json['file_registration'];
    fileGeneralLocation = json['file_general_location'];
    fileLicence = json['file_licence'];
    fileSurvivor = json['file_survivor'];
    fileAnnotations2 = json['file_annotations2'];
    fileClearance = json['file_clearance'];
    fileLicencedSurveyor = json['file_licenced_surveyor'];
    fileLegalUndertaking = json['file_legal_undertaking'];
    filePartnerApproval = json['file_partner_approval'];
    fileContractingContract = json['file_contracting_contract'];
    landSurveyorNotes = json['land_surveyor_notes'];
    generalNotes = json['general_notes'];
    transformTo = json['transform_to'];

    this.insertUserName = json['insert_userName'];
    this.updatetUserName = json['updatet_userName'];
    this.insertDate = json['insert_date'];
    this.updateDate = json['update_date'];
    this.insertMacId = json['insert_mac_id'];
    this.updateMacId = json['update_mac_id'];
    this.insertMachineNameId = json['insert_machine_name_id'];
    this.updateMachineNameId = json['update_machine_name_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    // data['id'] = this.id;
    data['uuid'] = this.uuid;
//NEW
    data['wp_fees'] = WPFees;
    data['wp_fees_date'] = WPFeesDate;
    data['wp_fees_recipt'] = WPFeesRecipt;
    data['wp_number'] = WPNumber;
    data['wp_serial_date'] = WPSerialDate;
    data['wp_serial_number'] = WPserialNumber;
    data['type'] = type;
    data['file_wp_fees_recipt'] = file_wp_fees_recipt;
    data['file_wp_decision'] = file_wp_decision;
    data['file_wp_workFlow'] = file_wp_workFlow;
//NEW
    data['qushan_number'] = this.qushanNumber;
    data['qushan_date'] = this.qushanDate;
    data['file_number'] = this.fileNumber;

    data['licence_details_area'] = this.licenceDetailsArea;
    data['licence_details_build_type'] = this.licenceDetailsBuildType;
    data['licence_details_tijari'] = this.licenceDetailsTijari;
    // data['licence_fees_sketch'] = this.licenceFeesSketch;
    // data['licence_fees_licence'] = this.licenceFeesLicence;
    // data['licence_fees_insurance'] = this.licenceFeesInsurance;
    // data['licence_fees_receipt_number'] = this.licenceFeesReceiptNumber;
    // data['licence_fees_receipt_date'] = this.licenceFeesReceiptDate;
    data['licence_owner_name'] = this.licenceOwnerName;
    data['licence_owner_ssn'] = this.licenceOwnerSSN;
    data['licence_plan_engname'] = this.licencePlanEngname;
    data['licence_plan_area_sakan'] = this.licencePlanAreaSakan;
    data['licence_build_details_area'] = this.licenceBuildDetailsArea;
    data['licence_build_details_hoodh'] = this.licenceBuildDetailsHoodh;
    data['licence_build_details_hay'] = this.licenceBuildDetailsHay;
    data['licence_build_details_land_number'] =
        this.licenceBuildDetailsLandNumber;
    data['licence_build_details_plane'] = this.licenceBuildDetailsPlane;
    data['licence_build_details_land_area'] = this.licenceBuildDetailsLandArea;
    data['licence_city'] = this.licenceCity;
    data['licence_final_number'] = this.licenceFinalNumber;
    data['licence_land_survey'] = this.licenceLandSurvey;
    data['licence_decision_number'] = this.licenceDecisionNumber;
    data['licence_decision_date'] = this.licenceDecisionDate;
    data['licence_incoming_number'] = this.licenceIncomingNumber;
    // data['floors'] = this.floors;
    data['file_qoshan'] = this.fileQoshan;
    data['file_land_sketch'] = this.fileLandSketch;
    data['file_registration'] = this.fileRegistration;
    data['file_general_location'] = this.fileGeneralLocation;
    data['file_licence'] = this.fileLicence;
    data['file_survivor'] = this.fileSurvivor;
    data['file_annotations2'] = this.fileAnnotations2;
    data['file_clearance'] = this.fileClearance;
    data['file_licenced_surveyor'] = this.fileLicencedSurveyor;
    data['file_legal_undertaking'] = this.fileLegalUndertaking;
    data['file_partner_approval'] = this.filePartnerApproval;
    data['file_contracting_contract'] = this.fileContractingContract;
    data['land_surveyor_notes'] = this.landSurveyorNotes;
    data['general_notes'] = this.generalNotes;
    data['transform_to'] = this.transformTo;
    data['insert_username'] = this.insertUserName;
    data['updatet_username'] = this.updatetUserName;
    data['insert_date'] = this.insertDate;
    data['update_date'] = this.updateDate;
    data['insert_mac_id'] = this.insertMacId;
    data['update_mac_id'] = this.updateMacId;
    data['insert_machine_name_id'] = this.insertMachineNameId;
    data['update_machine_name_id'] = this.updateMachineNameId;
    return data;
  }
}
