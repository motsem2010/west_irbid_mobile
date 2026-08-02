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

  factory Event.fromJson(Map<String, dynamic> json) {
    try {
      // Iterable itr = json['Attachments'];
      return Event(
        imageUrl: json['image_url'],
        category: json['category'].toString(),
        creatingDate: json['creating_date'].toString(),
        id: json['id'].toString(),
        roleID: json['role_id'].toString(),
        url: json['url'].toString(),
        publishingDate: json['publishing_date'].toString(),
        // attachments: List<Attachment>.from(
        //     itr.map((model) => Attachment().fromJson(model))),
        description: json['description'].toString(),
        title: json['title'].toString(),
        attachmentsUrlString: json['attachments_url_string'].toString(),
        imageList: (json['image_list'] as List<dynamic>?)?.cast<String>() ?? [],
      );
    } catch (e) {
      debugPrint('Event class fromJson error:$e');
      return Event();
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'image_url': imageUrl,
      'category': category,
      'creating_date': creatingDate,
      'role_id': roleID,
      'url': url,
      'publishing_date': publishingDate,
      'description': description,
      'title': title,
      'attachments_url_string': attachmentsUrlString,
      'image_list': imageList,
    };
  }

  String _imageUrl(String tmpImageUrl) {
    // if (Main.redirectToHttps)
    return tmpImageUrl.replaceAll('http://', 'https://');
    // else
    // return tmpImageUrl;
  }
}
