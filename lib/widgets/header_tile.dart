import 'package:flutter/material.dart';
import 'package:west_irbid_mobile/services_utils/constants.dart';
import 'package:get/get.dart';

class HeaderTile extends StatelessWidget {
  String title;
  String titleValue;
  bool isArabic;
  double widthData;
  TextStyle? styleText;

  HeaderTile({
    Key? key,
    required this.title,
    required this.titleValue,
    required this.widthData,
    this.isArabic = true,
    this.styleText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          width: widthData * 0.3,
          decoration: BoxDecoration(
            color: ConstantsData.primaryClr,
            boxShadow: ConstantsData.headerShadowVal,
            borderRadius: isArabic
                ? BorderRadius.only(
                    topRight: Radius.circular(ConstantsData.radiusVal),
                    bottomRight: Radius.circular(ConstantsData.radiusVal),
                  )
                : const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                  ),
          ),
          child: Text(
            "$title",
            style: Get.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.w400,
              color: Colors.white,
            ),
            // TextStyle(fontSize: 16, color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          width: widthData * 0.7,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: ConstantsData.headerShadowVal,
            borderRadius: isArabic != true
                ? BorderRadius.only(
                    topRight: Radius.circular(ConstantsData.radiusVal),
                    bottomRight: Radius.circular(ConstantsData.radiusVal),
                  )
                : const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                  ),
          ),
          child: Text(
            "$titleValue",
            textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
            style: styleText != null
                ? styleText
                : Get.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    ).paddingSymmetric(horizontal: 10);
  }
}
