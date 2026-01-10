import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:west_irbid_mobile/services_utils/constants.dart';

class MainButton extends StatelessWidget {
  final Function()? onPressed;
  final String? text;
  final Color color;
  final Color? textColor;

  final double padding;
  final Widget? prefex;
  final bool enabled;
  final double? width;
  MainButton({
    Key? key,
    this.onPressed,
    this.text,
    this.color = Colors.blue,
    this.prefex,
    this.textColor,
    this.enabled = true,
    this.padding = 5,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padding),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          side: BorderSide(style: BorderStyle.none),
        ),
        // style: Theme.of(context).elevatedButtonTheme.style?.copyWith( ),
        onPressed: enabled ? onPressed : null,

        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: width,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  text ?? 'Search'.tr,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: Get.textTheme.bodyLarge?.copyWith(
                    color: textColor ?? Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ).marginSymmetric(horizontal: 10, vertical: 5),
              ),
            ),
            prefex ?? Container(),
          ],
        ),
      ),
    );
  }
}

class MainButtonOutline extends StatelessWidget {
  final Function()? onPressed;
  final String? text;
  final Color color;
  final Color? textColor;

  final double padding;
  final IconData? icon;
  final bool enabled;
  final int? widthSize;
  MainButtonOutline({
    Key? key,
    this.onPressed,
    this.text,
    this.color = Colors.blue,
    this.icon,
    this.textColor,
    this.enabled = true,
    this.padding = 5,
    this.widthSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padding),
      child: OutlinedButton.icon(
        style: OutlinedButton.styleFrom(
          // backgroundColor: color,
          side: BorderSide(style: BorderStyle.solid, color: color),
        ),
        // style: Theme.of(context).elevatedButtonTheme.style?.copyWith( ),
        onPressed: enabled ? onPressed : null,
        icon: icon != null ? Icon(icon, color: color ?? Colors.white) : null,
        label: AutoSizeText(text ?? 'Search'.tr),
        // child: Row(
        //   mainAxisAlignment: MainAxisAlignment.start,
        //   crossAxisAlignment: CrossAxisAlignment.start,
        //   mainAxisSize: MainAxisSize.min,
        //   children: [
        //     Flexible(
        //       child: Text(
        //         text ?? 'Search'.tr,
        //         overflow: TextOverflow.ellipsis,
        //         maxLines: 1,
        //         style: Get.textTheme.bodyLarge?.copyWith(
        //             color: textColor ?? Colors.white,
        //             fontWeight: FontWeight.bold),
        //       ).marginSymmetric(horizontal: 10, vertical: 5),
        //     ),
        //     prefex ?? Container()
        //   ],
        // ),
      ),
    );
  }
}
