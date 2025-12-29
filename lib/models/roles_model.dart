import 'package:west_irbid_mobile/services_utils/translation_service.dart';

class RoleModel {
  int? id;
  String? createdAt;
  String? authId;
  String? name;
  int? groupId;
  String? nameAr;

  RoleModel({
    this.id,
    this.createdAt,
    this.authId,
    this.name,
    this.groupId,
    this.nameAr,
  });

  RoleModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    authId = json['auth_id'];
    name = json['name'];
    groupId = json['group_id'];
    nameAr = json['name_ar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['created_at'] = this.createdAt;
    data['auth_id'] = this.authId;
    data['name'] = this.name;
    data['group_id'] = this.groupId;
    data['name_ar'] = this.nameAr;
    return data;
  }

  @override
  String toString() {
    return (TranslationService().isLocaleArabic() ? nameAr : name) ?? ' ';
  }
}
