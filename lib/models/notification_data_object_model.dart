import 'dart:convert';

class NoficationWebSocketModel {
  String? type;
  NotificationDataModel? message;

  NoficationWebSocketModel({
    this.type,
    this.message,
  });

  NoficationWebSocketModel fromJson(Map<String, dynamic> json) {
    NotificationDataModel? parsedMessage;
    if (json['message'] != null) {
      if (json['message'].runtimeType == String) {
        parsedMessage =
            NotificationDataModel().fromJson(jsonDecode(json['message']));
      } else {
        parsedMessage = NotificationDataModel().fromJson(json['message']);
      }
      // if (json['message'] is String) {
      //   parsedMessage =
      //       NotificationDataModel().fromJson(jsonDecode(json['message']));
      // } else if (json['message'] is Map<String, dynamic>) {
      //   parsedMessage = NotificationDataModel().fromJson(json['message']);
      // }
    }

    return NoficationWebSocketModel(
      type: json['type']?.toString(),
      message: parsedMessage,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'message': message != null ? jsonEncode(message!.toJson()) : null,
    };
  }
}

class NotificationDataModel {
  String? view, view_route;
  String? action_id;
  String? message;
  String? parameters;
  String? dateOfCreate;
  bool? isRead;
  String? user_id;
  String? from_user_id;

  NotificationDataModel({
    this.view,
    this.view_route,
    this.action_id,
    this.message,
    this.parameters,
    this.dateOfCreate,
    this.isRead,
    this.user_id,
    this.from_user_id,
  });

  NotificationDataModel fromJson(Map<String, dynamic> json) {
    return NotificationDataModel(
      view: json['view']?.toString(),
      view_route: json['view_route']?.toString(),
      action_id: json['action_id']?.toString(),
      message: json['message']?.toString(),
      parameters: json['parameters']?.toString(),
      dateOfCreate: json['dateOfCreate']?.toString(),
      isRead: json['isRead'],
      user_id: json['user_id']?.toString(),
      from_user_id: json['from_user_id']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'view': view,
      'view_route': view_route,
      'action_id': action_id,
      'message': message,
      'parameters': parameters,
      'dateOfCreate': dateOfCreate,
      'isRead': isRead,
      'user_id': user_id,
      'from_user_id': from_user_id,
    };
  }
}
