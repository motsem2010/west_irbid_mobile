import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:west_irbid_mobile/services_utils/constants.dart';

class CustomContainerMain extends StatelessWidget {
  Widget child;
  String? title;
  bool isEnabled;
  Color? titleColor;
  Color? textColor;
  Color? cardColor;
  Widget? extraHeaderWidget;
  Widget? headerActionWidget;

  bool isCenter;
  CustomContainerMain({
    super.key,
    required this.child,
    this.title,
    this.isEnabled = true,
    this.isCenter = true,
    this.textColor,
    this.cardColor,
    this.titleColor,
    this.extraHeaderWidget,
    this.headerActionWidget,
  });

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: !isEnabled,
      child:
          Container(
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                decoration: BoxDecoration(
                  color: cardColor ?? Colors.grey[100],
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: isCenter
                      ? CrossAxisAlignment.center
                      : CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8),
                              topRight: Radius.circular(8),
                            ),
                            color: titleColor ?? Colors.grey.shade100,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              AutoSizeText(
                                title ?? '',
                                maxLines: 1,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: textColor,
                                ),
                              ),
                              if (extraHeaderWidget != null)
                                extraHeaderWidget ?? Container(),
                            ],
                          ),
                        ),
                        headerActionWidget ?? Container(),
                      ],
                    ),
                    Divider(
                      height: 1,
                      color: Colors.grey,
                      indent: 50,
                    ).paddingOnly(bottom: 5),
                    child,
                  ],
                ),
              )
              .marginSymmetric(horizontal: 10, vertical: 5)
              .animate()
              .scale(delay: Duration(seconds: 1)),
    );
  }
}
