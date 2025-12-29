import 'package:west_irbid_mobile/services_utils/translation_service.dart';

class UserRoleModel {
  int? id;
  String? createdAt;
  String? authId;
  String? userName;
  int? groupId;
  int? roleId;
  String? roleName;
  bool? active;

  UserRoleModel({
    this.id,
    this.createdAt,
    this.authId,
    this.userName,
    this.groupId,
    this.roleId,
    this.roleName,
    this.active,
  });

  UserRoleModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    authId = json['auth_id'];
    userName = json['user_name'];
    groupId = json['group_id'];
    roleId = json['role_id'];
    roleName = json['role_name'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    // data['id'] = this.id;
    // data['created_at'] = this.createdAt;
    // data['auth_id'] = this.authId;
    data['user_name'] = this.userName;
    data['group_id'] = this.groupId;
    data['role_id'] = this.roleId;
    data['role_name'] = this.roleName;
    data['active'] = this.active;
    return data;
  }

  @override
  String toString() {
    return roleName ?? 'No name';
  }
}
