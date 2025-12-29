import 'package:flutter/material.dart';
import 'package:west_irbid_mobile/services_utils/constants.dart';
import 'package:get/get.dart';

class TodaysLecturesTile extends StatelessWidget {
  String courseTime;
  String courseTitle;
  bool isArabic;
  double widthData;
  int status; //0 expires , 1 active , 2 upcoming
  TextStyle? styleText;

  TodaysLecturesTile({
    Key? key,
    required this.courseTime,
    required this.courseTitle,
    required this.widthData,
    required this.status,
    this.isArabic = true,
    this.styleText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          width: widthData * 0.8,
          height: 100,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: ConstantsData.headerShadowVal,
            borderRadius: isArabic == true
                ? BorderRadius.only(
                    topRight: Radius.circular(ConstantsData.radiusVal),
                    bottomRight: Radius.circular(ConstantsData.radiusVal),
                  )
                : const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                  ),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    status == 3
                        ? 'Expired'.tr
                        : status == 1
                        ? 'Active'.tr
                        : 'Comming'.tr,
                    style: Get.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.ellipsis,
                      color: status == 1
                          ? ConstantsData.activeClr
                          : Colors.black,
                    ),
                    // TextStyle(fontSize: 16, color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    courseTime,
                    textDirection: isArabic
                        ? TextDirection.rtl
                        : TextDirection.ltr,
                    style:
                        styleText ??
                        Get.textTheme.headlineMedium?.copyWith(
                          overflow: TextOverflow.ellipsis,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ).marginSymmetric(vertical: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Course'.tr + ':' + courseTitle,
                    textDirection: isArabic
                        ? TextDirection.rtl
                        : TextDirection.ltr,
                    style:
                        styleText ??
                        Get.textTheme.headlineMedium?.copyWith(
                          overflow: TextOverflow.ellipsis,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          width: widthData * 0.05,
          height: 100,
          decoration: BoxDecoration(
            color: status == 1
                ? ConstantsData.activeClr
                : ConstantsData.inActiveClr,
            boxShadow: ConstantsData.headerShadowVal,
            borderRadius: !isArabic
                ? BorderRadius.only(
                    topRight: Radius.circular(ConstantsData.radiusVal),
                    bottomRight: Radius.circular(ConstantsData.radiusVal),
                  )
                : const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                  ),
          ),
        ),
      ],
    ).paddingSymmetric(horizontal: 10, vertical: 5);
  }
}
