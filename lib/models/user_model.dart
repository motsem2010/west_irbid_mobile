class UserModel {
  int? id;
  DateTime? createdAt;
  String? macId;
  String? machineNameId;
  bool? active;
  String? pcUsername;
  String? userEmail;
  int? roleId;
  String? roleNameAr;
  String? userName;
  int? departmentId;
  String? departmentName;
  String? manager_name;
  int? manager_id;

  UserModel(
      {this.id,
      this.createdAt,
      this.macId,
      this.machineNameId,
      this.active,
      this.pcUsername,
      this.userEmail,
      this.roleId,
      this.roleNameAr,
      this.userName,
      this.departmentId,
      this.departmentName,
      this.manager_id,
      this.manager_name});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      createdAt: DateTime.parse(json['created_at']),
      macId: json['mac_id'],
      machineNameId: json['machine_name_id'],
      active: json['active'],
      pcUsername: json['pc_username'],
      userEmail: json['user_email'],
      roleId: json['role_id'],
      roleNameAr: json['role_name_ar'],
      userName: json['user_name'],
      departmentId: json['department_id'],
      departmentName: json['department_name'],
      manager_id: json['manager_id'],
      manager_name: json['manager_name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      // 'id': id,
      // 'created_at': createdAt.toIso8601String(),
      'mac_id': macId,
      'machine_name_id': machineNameId,
      'active': active,
      'pc_username': pcUsername,
      'user_email': userEmail,
      'role_id': roleId,
      'role_name_ar': roleNameAr,
      'user_name': userName,
      'department_id': departmentId,
      'department_name': departmentName,
      'manager_name': manager_name,
      'manager_id': manager_id
    };
  }

  @override
  String toString() {
    return userName ?? (userEmail ?? ' ');
  }
}
