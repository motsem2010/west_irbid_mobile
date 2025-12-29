import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:west_irbid_mobile/models/attachment_model.dart';
import 'package:west_irbid_mobile/services_utils/constants.dart';
import 'package:west_irbid_mobile/services_utils/ftp_helper.dart';
import 'package:west_irbid_mobile/services_utils/helper_methods.dart';
import 'package:west_irbid_mobile/services_utils/supa_api.dart';
import 'package:west_irbid_mobile/services_utils/ui_helpers.dart';
import 'package:west_irbid_mobile/widgets_cc/attachment_widget.dart';
import 'package:west_irbid_mobile/widgets_cc/main_button.dart';

class CustomFIleScanAttachment extends StatelessWidget {
  Attachment? attachment;
  String title;
  Function onPress;
  Color? textColor;
  bool enable;
  Color? bgColor;
  bool downloadIconButton;

  CustomFIleScanAttachment({
    super.key,
    required this.title,
    this.attachment,
    required this.onPress,
    this.enable = true,
    this.bgColor,
    this.textColor,
    this.downloadIconButton = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        (!enable)
            ? (downloadIconButton == false
                  ? MainButton(
                      text: title,
                      onPressed: () async {
                        await getAttachment(context);
                      },
                      color: attachment == null
                          ? Colors.black54
                          : (bgColor ?? ConstantsData.activeClr),
                    )
                  : Container())
            : PopupMenuButton(
                // icon: Icon(Icons.attachment),
                color: Colors.white,
                child: MainButton(
                  textColor: attachment == null
                      ? textColor
                      : ConstantsData.activeClr,
                  text: title,
                  // onPressed: onPress,
                  color: attachment == null
                      ? Colors.black54
                      : ConstantsData.activeClr,
                  prefex: Icon(
                    Icons.attachment,
                    color: attachment == null
                        ? Colors.black54
                        : ConstantsData.activeClr.withRed(200),
                  ),
                ),
                itemBuilder: (ctx) {
                  return <PopupMenuEntry<int>>[
                    PopupMenuItem(
                      value: 1,
                      child: ListTile(
                        titleAlignment: ListTileTitleAlignment.center,
                        dense: true,
                        leading: Icon(Icons.file_copy, color: Colors.blue),
                        onTap: () {
                          debugPrint('Attachment from file');
                          Get.back();
                          onPress.call();
                        },
                        title: Text(
                          'File'.tr,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                    ),
                    PopupMenuItem(
                      value: 1,
                      child: ListTile(
                        titleAlignment: ListTileTitleAlignment.center,
                        dense: true,
                        leading: Icon(Icons.scanner, color: Colors.orange),
                        onTap: () async {
                          debugPrint('Attachment from Scan');
                          Get.back();
                          await HelperMethods.runCommand();
                          //  onPress.call();
                        },
                        title: Text(
                          'Scanner'.tr,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                    ),
                  ];
                },
              ),
        SizedBox(height: 10),
        if (attachment != null && attachment?.uploadFileUri != 'error')
          Row(
            children: [
              if (downloadIconButton == true)
                IconButton(
                  onPressed: () async {
                    await getAttachment(context);
                  },
                  icon: Icon(Icons.download),
                ),
              SizedBox(
                width: 120,
                child: AttachmentWidget(attachment: attachment),
              ),
            ],
          )
        else
          Text('error', style: TextStyle(color: Colors.red, fontSize: 14)),
      ],
    );
  }

  getAttachment(context) async {
    if (attachment?.isFTP == true &&
        attachment?.ftpFile == null &&
        attachment?.uploadFileUri != null) {
      try {
        if ((attachment?.ftpFile != null || attachment?.supaSignedUrl != null))
          return;
        startLoading(context, willPop: true);
        // attachment?.ftpFile = await FtpHelper.downloadFiles(
        //     attachment?.uploadFileUri ?? '',
        //     'diwan' +
        //         Random(5000).nextInt(1000000000).toString() +
        //         (attachment?.uploadFileUri?.substring(
        //                 attachment?.uploadFileUri?.lastIndexOf('.') ?? 0) ??
        //             ''));
        pop(context);
      } catch (u) {
        debugPrint(u.toString());
        pop(context);
      }
    } else if (attachment?.supaSignedUrl == null &&
        attachment?.uploadFileUri != null &&
        attachment?.isFTP == false) {
      startLoading(context, willPop: true);

      attachment?.supaSignedUrl = await SupaApi.getPublicUrl(
        attachment?.uploadFileUri ?? "",
      );
      debugPrint(attachment?.supaSignedUrl);
      pop(context);
    }
  }
}
