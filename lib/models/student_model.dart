// // class Student {
// //   String? studentName;
// //   int? status;
// //   String? studentNameAr;

// //   Student({this.studentName, this.status, this.studentNameAr});

// //   Student.fromJson(Map<String, dynamic> json) {
// //     studentName = json['student_name'];
// //     status = json['status'];
// //     studentNameAr = json['student_name_ar'];
// //   }

// //   Map<String, dynamic> toJson() {
// //     final Map<String, dynamic> data = new Map<String, dynamic>();
// //     data['student_name'] = this.studentName;
// //     data['status'] = this.status;
// //     data['student_name_ar'] = this.studentNameAr;
// //     return data;
// //   }
// // }
// class StudentsWithStatus {
//   List<Students>? students;
//   List<AbsentStatus>? absentStatus;

//   StudentsWithStatus({this.students, this.absentStatus});

//   StudentsWithStatus.fromJson(Map<String, dynamic> json) {
//     if (json['Students'] != null) {
//       students = <Students>[];
//       json['Students'].forEach((v) {
//         students!.add(new Students.fromJson(v));
//       });
//     }
//     if (json['AbsentStatus'] != null) {
//       absentStatus = <AbsentStatus>[];
//       json['AbsentStatus'].forEach((v) {
//         absentStatus!.add(new AbsentStatus.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.students != null) {
//       data['Students'] = this.students?.map((v) => v.toJson()).toList();
//     }
//     if (this.absentStatus != null) {
//       data['AbsentStatus'] = this.absentStatus?.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

// class Students {
//   String? studentNumber;
//   String? studentName;
//   int? status;
//   int? studentSectionID;

//   Students(
//       {this.studentNumber,
//       this.studentName,
//       this.status,
//       this.studentSectionID});

//   Students.fromJson(Map<String, dynamic> json) {
//     studentNumber = json['StudentNumber'];
//     studentName = json['StudentName'];
//     status = json['Status'];
//     studentSectionID = json['StudentSectionID'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['StudentNumber'] = this.studentNumber;
//     data['StudentName'] = this.studentName;
//     data['Status'] = this.status;
//     data['StudentSectionID'] = this.studentSectionID;
//     return data;
//   }
// }

// class AbsentStatus {
//   int? value;
//   String? name;

//   AbsentStatus({this.value, this.name});

//   AbsentStatus.fromJson(Map<String, dynamic> json) {
//     value = json['Value'];
//     name = json['Name'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['Value'] = this.value;
//     data['Name'] = this.name;
//     return data;
//   }
// }
