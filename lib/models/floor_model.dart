// class FloorModel {
//   int? id;
//   String? floor;
//   String? licenceType;
//   double? area;
//   int? reciptNumber;
//   String? reciptDate;
//   double? fees;
//   String? notes;
//   String? insertDate;
//   int? build_licence_id; // used for building licences
//   int? working_permission_id; //used for working permission licence
//   String? licence_number;
//   String? licence_date;
//   int? num_of_assets;

//   FloorModel(
//       {this.id,
//       this.floor,
//       this.licenceType,
//       this.area,
//       this.reciptNumber,
//       this.reciptDate,
//       this.fees,
//       this.insertDate,
//       this.notes,
//       this.build_licence_id});

//   FloorModel.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     floor = json['floor'];
//     licenceType = json['licence_type'];
//     area = json['area'];
//     reciptNumber = json['recipt_number'];
//     reciptDate = json['recipt_date'];
//     fees = json['fees'];
//     notes = json['notes'];
//     insertDate = json['insert_date'];
//     build_licence_id = json['build_licence_id'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['floor'] = this.floor;
//     data['licence_type'] = this.licenceType;
//     data['area'] = this.area;
//     data['recipt_number'] = this.reciptNumber;
//     data['recipt_date'] = this.reciptDate;
//     data['fees'] = this.fees;
//     data['notes'] = this.notes;
//     data['insert_date'] = this.insertDate;
//     data['build_licence_id'] = this.build_licence_id;
//     return data;
//   }
// }
class FloorModel {
  int? id;
  String? floor;
  String? licenceType;
  double? area;
  int? reciptNumber;
  String? reciptDate;
  double? fees;
  String? notes;
  String? insertDate;
  int? buildLicenceId; // used for building licences
  String? workingPermissionId; // used for working permission licence
  String? licenceNumber;
  String? licenceDate;
  int? numOfAssets;

  FloorModel({
    this.id,
    this.floor,
    this.licenceType,
    this.area,
    this.reciptNumber,
    this.reciptDate,
    this.fees,
    this.notes,
    this.insertDate,
    this.buildLicenceId,
    this.workingPermissionId,
    this.licenceNumber,
    this.licenceDate,
    this.numOfAssets,
  });

  factory FloorModel.fromJson(Map<String, dynamic> json) {
    return FloorModel(
      id: json['id'],
      floor: json['floor'],
      licenceType: json['licence_type'],
      area: json['area'] != null ? double.parse(json['area'].toString()) : 0.0,
      reciptNumber: json['recipt_number'],
      reciptDate: json['recipt_date'],
      fees: json['fees'] != null ? double.parse(json['fees'].toString()) : 0.0,
      notes: json['notes'],
      insertDate: json['insert_date'],
      buildLicenceId: json['build_licence_id'],
      workingPermissionId: json['working_permission_id'],
      licenceNumber: json['licence_number'],
      licenceDate: json['licence_date'],
      numOfAssets: json['num_of_assets'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      // 'id': id,
      'floor': floor,
      'licence_type': licenceType,
      'area': area,
      'recipt_number': reciptNumber,
      'recipt_date': reciptDate,
      'fees': fees,
      'notes': notes,
      'insert_date': insertDate,
      'build_licence_id': buildLicenceId,
      'working_permission_id': workingPermissionId,
      'licence_number': licenceNumber,
      'licence_date': licenceDate,
      'num_of_assets': numOfAssets,
    };
    return data;
  }
}
