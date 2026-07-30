import 'package:flutter/cupertino.dart';
import 'package:west_irbid_mobile/models/attachment_model.dart';

class Event {
  final String? id;
  final String? imageUrl;
  final String? publishingDate;
  final String? title;
  final String? description;
  final String? attachmentsUrlString;
  final List<Attachment>? attachments;
  final String? creatingDate;
  final String? category;
  final String? url;
  final String? roleID;
  final List<String>? imageList;

  Event({
    this.imageUrl,
    this.id,
    this.publishingDate,
    this.creatingDate,
    this.category,
    this.url,
    this.roleID,
    this.title,
    this.description,
    this.attachments,
    this.imageList,
    this.attachmentsUrlString,
  });

  fromJson(Map<String, dynamic> json) {
    try {
      Iterable itr = json['Attachments'];
      return Event(
        imageUrl: _imageUrl(json['Image']),
        category: json['Category'].toString(),
        creatingDate: json['CreatingDate'].toString(),
        id: json['Id'].toString(),
        roleID: json['RoleID'].toString(),
        url: json['Url'].toString(),
        publishingDate: json['PublishingDate'].toString(),
        // attachments: List<Attachment>.from(
        //     itr.map((model) => Attachment().fromJson(model))),
        description: json['Description'].toString(),
        title: json['Title'].toString(),
        attachmentsUrlString: json['AttachmentsUrlString'].toString(),
        imageList: (json['ImageList'] as List<dynamic>?)?.cast<String>() ?? [],
      );
    } catch (e) {
      debugPrint('Event class fromJson error:$e');
      return null;
    }
  }

  String _imageUrl(String tmpImageUrl) {
    // if (Main.redirectToHttps)
    return tmpImageUrl.replaceAll('http://', 'https://');
    // else
    // return tmpImageUrl;
  }
}
