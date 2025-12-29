// import 'package:ataa/eschool.dart';
// import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:west_irbid_mobile/services_utils/size_utils.dart';
import 'package:west_irbid_mobile/services_utils/translation_service.dart';

class CustomContainerHeaderFooter extends StatelessWidget {
  CustomContainerHeaderFooter({
    Key? key,
    required this.ctx,
    required this.cardHeaderHieght,
    this.withBoarder = false,
    this.expandedFooter = false,
    this.footerColor,
    this.headerBg,
    this.headerTextColor = Colors.white,
    this.borderColor = Colors.black26,
    required this.bodyContent,
    this.footerText,
    required this.headerText,
    required this.contentHieght,
    this.topPadding = true,
    this.extaHeadIcon,
    this.footerPress,
    this.footerIcon,
  }) : super(key: key);
  final Widget? footerIcon;
  final BuildContext ctx;
  final double cardHeaderHieght;
  final bool withBoarder;
  final Color headerTextColor;
  final Color? headerBg;
  final Color borderColor;
  final Color? footerColor;

  final bool expandedFooter;
  final String headerText;
  final String? footerText;
  final List<Widget> bodyContent;
  final VoidCallback? footerPress;
  final double contentHieght;
  final bool topPadding;
  final Widget? extaHeadIcon;
  @override
  Widget build(BuildContext context) {
    bool is_english = !TranslationService().isLocaleArabic();
    return Stack(
      alignment: Alignment.topCenter,
      // fit: StackFit.loose,
      children: [
        Container(
          margin: EdgeInsets.only(top: cardHeaderHieght / 2),
          // height: contentHieght,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(color: Colors.black12, spreadRadius: 2, blurRadius: 8),
            ],
            borderRadius: BorderRadius.circular(8),
            border: withBoarder
                ? Border.all(
                    width: 1,
                    color: withBoarder ? borderColor : Colors.transparent,
                  )
                : null,
          ),
          child: Padding(
            padding: EdgeInsets.only(
              top: topPadding == true ? cardHeaderHieght * 0.8 : 10.0.v,
            ),
            child: ListView(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              // mainAxisAlignment: MainAxisAlignment.start,
              // crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisSize: MainAxisSize.min,
              children: [
                ...bodyContent,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (!expandedFooter) Spacer(),
                    if (!expandedFooter) Spacer(),
                    if (footerText != null)
                      Expanded(
                        child: GestureDetector(
                          onTap: footerPress,
                          child: Container(
                            // constraints: BoxConstraints(maxWidth: 200),
                            // clipBehavior: Clip.antiAlias,
                            // width: !expandedFooter ? 150 : null,
                            height: cardHeaderHieght,
                            margin: EdgeInsets.only(top: 10.v),
                            padding: EdgeInsets.symmetric(horizontal: 20.h),
                            decoration: BoxDecoration(
                              color:
                                  footerColor ??
                                  Theme.of(context).colorScheme.secondary,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12,
                                  spreadRadius: 2,
                                  blurRadius: 1,
                                ),
                              ],
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(
                                  expandedFooter
                                      ? 0
                                      : (!expandedFooter && is_english)
                                      ? 0
                                      : 8,
                                ),
                                topLeft: Radius.circular(
                                  expandedFooter
                                      ? 0
                                      : (!expandedFooter && !is_english)
                                      ? 0
                                      : 15,
                                ),
                                bottomLeft: Radius.circular(
                                  expandedFooter
                                      ? 8
                                      : (!expandedFooter && !is_english)
                                      ? 8
                                      : 0,
                                ),
                                bottomRight: Radius.circular(
                                  expandedFooter
                                      ? 8
                                      : (!expandedFooter && is_english)
                                      ? 4
                                      : 0,
                                ),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                if (footerIcon != null) footerIcon!,
                                FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text(
                                    footerText!,
                                    textAlign: TextAlign.center,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(ctx).textTheme.bodyMedium
                                        ?.copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
        extaHeadIcon != null
            ? Positioned(
                top: 10,
                left: is_english ? null : 10,
                right: is_english ? 10 : null,
                child: extaHeadIcon!
                    .animate(autoPlay: true, delay: Duration(milliseconds: 700))
                    .scale(),
              )
            : Container(),
        Positioned(
          // duration: Duration(milliseconds: 500),
          // curve: Curves.easeInOutCubic,
          top: 0,
          left: is_english ? cardHeaderHieght / 2 : null,
          right: is_english ? null : cardHeaderHieght / 2,
          // right: cardHeaderHieght / 2,
          child: Container(
            height: cardHeaderHieght,
            constraints: BoxConstraints(maxWidth: 200.h),
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: headerBg ?? Theme.of(context).colorScheme.primary,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: Offset(2, 3),
                ),
              ],
              borderRadius: BorderRadius.circular(4),
            ),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                headerText,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(ctx).textTheme.bodyMedium?.copyWith(
                  color: headerTextColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
