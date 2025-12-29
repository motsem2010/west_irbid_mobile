import 'dart:io';

import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:open_app_file/open_app_file.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:west_irbid_mobile/models/attachment_model.dart';
import 'package:west_irbid_mobile/services_utils/constants.dart';
import 'package:west_irbid_mobile/services_utils/helper_methods.dart';
import 'package:west_irbid_mobile/services_utils/ui_helpers.dart';
import 'package:west_irbid_mobile/widgets_cc/newwork_image_view.dart';
import 'package:west_irbid_mobile/widgets_cc/pdf_viewer_page.dart';

// import '../res/page/pdf_viewer_page.dart';

class AttachmentWidget extends StatelessWidget {
  final Attachment? attachment;

  const AttachmentWidget({Key? key, this.attachment}) : super(key: key);

  void openPDF(BuildContext context, File? file, String url) {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (context) => PDFViewerPage(url: url)));
  }

  static Future<File> loadNetwork(String url, String? fileName) async {
    final response = await http.get(Uri.parse(url));
    final bytes = response.bodyBytes;

    return (await _storeFile(fileName ?? url, bytes));
  }

  static Future<File> _storeFile(String url, List<int> bytes) async {
    final filename = basename(url);
    final dir = await getApplicationDocumentsDirectory();

    final file = File('${dir.path}/$filename');
    await file.writeAsBytes(bytes, flush: true);
    return file;
  }

  @override
  Widget build(BuildContext context) {
    var schema = '';
    var prefix = Uri.parse(attachment!.url ?? '');
    if (prefix.scheme.isEmpty) schema = 'http://';
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Icon(Icons.attach_file, color: ConstantsData.buttonClr),
        // Container(
        //   height: 5,
        //   width: 5,
        //   decoration:
        //       BoxDecoration(shape: BoxShape.circle, color: Colors.black),
        // ),
        Text('${attachment?.size?.toStringAsFixed(2) ?? 'Online '}KB'),
        TextButton(
          onPressed: () async {
            if (attachment?.isFTP == true && attachment?.ftpFile != null) {
              launchUrl(
                Uri.parse(attachment?.ftpFile?.path ?? ''),
                mode: LaunchMode.externalApplication,
              );
              return;
            }
            if (attachment?.supaSignedUrl != null &&
                !(attachment?.uploadFileUri!.endsWith('pdf') ?? false)) {
              launchUrl(
                Uri.parse(attachment!.supaSignedUrl ?? ''),
                mode: LaunchMode.externalApplication,
              );
              // HelperMethods.showMediasDialog(context,
              //     medisUrl: attachment?.supaSignedUrl ?? '',
              //     title: 'Media'.tr);
              return;
            } else if (attachment!.supaSignedUrl != null &&
                attachment!.uploadFileUri!.endsWith('pdf')) {
              launchUrl(
                Uri.parse(attachment!.supaSignedUrl ?? ''),
                mode: LaunchMode.externalApplication,
              );
              // File file = await loadNetwork(
              //     // url.toString()
              //     attachment!.supaSignedUrl!.toString(),
              //     attachment!.uploadFileUri!.toString()
              //     //  .replaceAll("http://", 'https://'),
              //     );
              // openPDF(context, file, file.path);
            } else if (attachment!.url != null && attachment!.url!.isNotEmpty) {
              /// encode the url
              final url = attachment?.supaSignedUrl != null
                  ? Uri.parse(attachment?.supaSignedUrl ?? '')
                  : Uri.parse((schema + attachment!.url!.toLowerCase()));
              if (url.toString().endsWith('.pdf')) {
                startLoading(context, willPop: false);
                File? file;
                try {
                  if (attachment?.url != null) {
                    // file = File(attachment?.url ?? '');
                    launchUrl(
                      Uri.parse(attachment?.url ?? ''),
                      mode: (Platform.isAndroid)
                          ? LaunchMode.externalApplication
                          : LaunchMode.platformDefault,
                    );
                    pop(context);
                    return;
                  }
                  // await loadNetwork(url.toString());
                } catch (e) {
                  debugPrint(e.toString());
                  file = await loadNetwork(
                    // url.toString()
                    attachment!.url!.replaceAll("http://", 'https://'),
                    null,
                  );
                }
                pop(context);
                if (file != null) openPDF(context, file, url.toString());
                return;
              } else if (!(attachment!.url!.contains('http:') ||
                  attachment!.url!.contains('https:'))) {
                // launchUrl(Uri.parse(attachment!.url!));
                debugPrint(attachment!.url.toString());
                // ProcessResult result = await Process.run(
                //     'start ${attachment!.url?.replaceAll('\\', '\/')}', [],
                //     runInShell: true);
                // // String filePath = '${attachment!.url}';
                // ProcessResult result = await Process.run(
                //     "start ", ['${attachment!.url!}'],
                //     runInShell: false);
                OpenAppFile.open('${attachment!.url}');

                // push(NetworkImageView(
                //   imageURL: attachment!.url!,
                // ));
                return;
              } else if (url.toString().endsWith('.jpg') ||
                  url.toString().endsWith('.jpeg') ||
                  url.toString().endsWith('.webp') ||
                  url.toString().endsWith('.png')) {
                push(NetworkImageView(imageURL: url.toString()));
                return;
              } else {
                try {
                  launchUrl(
                    url,
                    mode: (Platform.isAndroid)
                        ? LaunchMode.externalApplication
                        : LaunchMode.platformDefault,
                  );
                  return;
                } on PlatformException catch (e) {
                  return;
                } catch (e) {
                  debugPrint(e.toString());
                  alert(context, CoolAlertType.error, 'cantOpenFile'.tr);
                  return;
                }
              }
            }
            alert(context, CoolAlertType.error, 'cantOpenFile'.tr);
          },
          child: Text(
            (attachment?.fileName ??
                    attachment?.uploadFileUri?.substring(
                      attachment?.uploadFileUri?.lastIndexOf('/') ?? 0,
                    )) ??
                '',
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            style: TextStyle(fontSize: 14),
          ),
        ),
      ],
    );
  }
}
