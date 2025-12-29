import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:west_irbid_mobile/models/attachment_model.dart';
import 'package:west_irbid_mobile/services_utils/constants.dart';
import 'package:west_irbid_mobile/services_utils/supa_api.dart';
import 'package:west_irbid_mobile/widgets_cc/attachment_widget.dart';
import 'package:west_irbid_mobile/widgets_cc/main_button.dart';

class CustomAttachment extends StatelessWidget {
  Attachment? attachment;
  String title;
  Function()? onPress;
  bool enable;
  CustomAttachment({
    super.key,
    required this.title,
    this.attachment,
    required this.onPress,
    this.enable = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        MainButton(
          text: title,
          onPressed: enable
              ? onPress
              : () async {
                  if (attachment?.supaSignedUrl == null &&
                      attachment?.uploadFileUri != null) {
                    attachment?.supaSignedUrl = await SupaApi.getPublicUrl(
                      attachment?.uploadFileUri ?? "",
                    );
                    debugPrint(attachment?.supaSignedUrl);
                  }
                },
          color: attachment == null ? Colors.black54 : ConstantsData.activeClr,
        ),
        SizedBox(height: 10),
        if (attachment != null)
          SizedBox(width: 120, child: AttachmentWidget(attachment: attachment)),
      ],
    );
  }
}
