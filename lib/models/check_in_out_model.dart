class CheckInOutModel {
  int? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? employeeID;
  String? fingerprintType;
  String? fingerprint_type_text;
  double? targetLat;
  double? targetLon;
  bool? success;
  String? message;
  bool? isWithinZone;

  CheckInOutModel({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.employeeID,
    this.fingerprintType,
    this.fingerprint_type_text,
    this.targetLat,
    this.targetLon,
    this.success,
    this.message,
    this.isWithinZone,
  });

  CheckInOutModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'] != null
        ? DateTime.parse(json['created_at'])
        : null;
    updatedAt = json['updated_at'] != null
        ? DateTime.parse(json['updated_at'])
        : null;
    employeeID = int.parse(json['employee_id'].toString());
    fingerprintType = json['fingerprint_type'];
    fingerprint_type_text = json['fingerprint_type_text'];
    targetLat = double.tryParse(json['target_lat'].toString());
    targetLon = double.tryParse(json['target_lon'].toString());
    success = json['success'] as bool?;
    message = json['message'] as String?;
    isWithinZone = json['is_within_zone'] as bool?;
  }

  // CheckInOutModel.fromJson2(Map<String, dynamic> json) {
  //   success = json['success'];
  //   message = json['message'];
  //   isWithinZone = json['isWithinZone'];
  // }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['employee_id'] = employeeID;
    data['fingerprint_type'] = fingerprintType;
    data['fingerprint_type_text'] = fingerprint_type_text;
    data['target_lat'] = targetLat;
    data['target_lon'] = targetLon;
    data['success'] = success;
    data['message'] = message;
    data['is_within_zone'] = isWithinZone;
    return data;
  }

  Map<String, dynamic> toJson2() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['p_employee_id'] = employeeID;
    data['p_fingerprint_type'] = fingerprintType;
    data['p_fingerprint_type_text'] = fingerprint_type_text;
    data['p_target_lat'] = targetLat;
    data['p_target_lon'] = targetLon;
    data['p_message'] = message;
    data['p_is_within_zone'] = isWithinZone;
    return data;
  }
}
