class RelationshipNews {
  int? id;
  DateTime? creation_date;
  String? newsTitle;
  String? jaredah;
  String? attachment;
  String? link;
  String? type;
  String? dateOfPublish;
  String? year;
  String? addByUser;
  bool? isPublished;
  bool? isDeleted;
  String? updatedByUser;
  String? note;
  String? by_device;
  String? supaSignedUrl;

  RelationshipNews(
      {this.id,
      this.creation_date,
      this.newsTitle,
      this.jaredah,
      this.attachment,
      this.link,
      this.type,
      this.dateOfPublish,
      this.year,
      this.addByUser,
      this.isPublished,
      this.isDeleted,
      this.updatedByUser,
      this.note,
      this.by_device,
      this.supaSignedUrl});

  // FromJson factory constructor
  factory RelationshipNews.fromJson(Map<String, dynamic> json) {
    return RelationshipNews(
      id: json['id'],
      creation_date: json['creation_date'] != null
          ? DateTime.parse(json['creation_date'])
          : null,
      newsTitle: json['news_title'],
      jaredah: json['jaredah'],
      attachment: json['attachment'],
      link: json['link'],
      type: json['type'],
      dateOfPublish: json['date_of_puplish'],
      year: json['year'],
      addByUser: json['add_by_user'],
      isPublished: json['is_puplished'],
      isDeleted: json['is_deleted'],
      updatedByUser: json['updated_by_user'],
      note: json['note'],
      by_device: json['by_device'],
    );
  }

  // ToJson method
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    if (id != null) data['id'] = id;
    // if (creation_date != null)
    //   data['creation_date'] = creation_date?.toIso8601String();
    if (newsTitle != null) data['news_title'] = newsTitle;
    if (jaredah != null) data['jaredah'] = jaredah;
    if (attachment != null) data['attachment'] = attachment;
    if (link != null) data['link'] = link;
    if (type != null) data['type'] = type;
    if (dateOfPublish != null) data['date_of_puplish'] = dateOfPublish;
    if (year != null) data['year'] = year;
    if (addByUser != null) data['add_by_user'] = addByUser;
    if (isPublished != null) data['is_puplished'] = isPublished;
    if (isDeleted != null) data['is_deleted'] = isDeleted;
    if (updatedByUser != null) data['updated_by_user'] = updatedByUser;
    if (note != null) data['note'] = note;
    if (by_device != null) data['by_device'] = by_device;

    return data;
  }

  // Optional: Method to parse a list of RelationshipNews
  static List<RelationshipNews> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => RelationshipNews.fromJson(json)).toList();
  }
}
