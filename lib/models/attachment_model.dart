import 'dart:io';

class Attachment {
  int? id;
  String? url;
  String? fileName;
  String? title;
  double? size;
  String? uploadFileUri;
  String? supaSignedUrl;
  bool isFTP;
  File? ftpFile;
  @override
  Attachment(
      {this.url,
      this.fileName,
      this.id,
      this.title,
      this.size,
      this.supaSignedUrl,
      this.isFTP = false,
      this.ftpFile,
      this.uploadFileUri});
}
