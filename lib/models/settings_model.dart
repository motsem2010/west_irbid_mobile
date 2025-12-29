import 'dart:convert';

class SettingModel {
  int? id;
  String? createdAt;
  String? settingKey;
  String? settingValue;
  String? userName;
  String? description, used_in;
  bool? active;

  SettingModel({
    this.id,
    this.createdAt,
    this.settingKey,
    this.settingValue,
    this.userName,
    this.description,
    this.used_in,
    this.active,
  });

  // Factory constructor to create a Setting instance from a JSON map
  factory SettingModel.fromJson(Map<String, dynamic> json) {
    return SettingModel(
      id: json['id'] as int?,
      createdAt: json['created_at'] as String?,
      settingKey: json['setting_key'] as String?,
      settingValue: json['setting_value'] as String?,
      userName: json['user_name'] as String?,
      description: json['description'] as String?,
      used_in: json['used_in'] as String?,
      active: json['active'],
    );
  }

  // Method to convert a Setting instance to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'created_at': createdAt,
      'setting_key': settingKey,
      'setting_value': settingValue,
      'user_name': userName,
      'description': description,
      'used_in': used_in,
      'active': active,
    };
  }
}
