import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:west_irbid_mobile/services_utils/constants.dart';

class StudentItem extends StatelessWidget {
  StudentItem({
    Key? key,
    required this.status, //0 waiting , 1 attending , 2 absents
    required this.studentName,
    required this.isHeader,
    required this.widthData,
  }) : super(key: key);
  String studentName;
  int status;
  bool isHeader;
  double widthData;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widthData,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      // height: 50,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                studentName,
                style: Get.textTheme.headlineMedium?.copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ).paddingSymmetric(horizontal: 10),
              Text(
                status == -1
                    ? 'Status'.tr
                    : status == 0
                    ? 'Waiting'.tr
                    : status == 1
                    ? 'Attending'.tr
                    : 'Absents'.tr,
                style: Get.textTheme.headlineMedium?.copyWith(
                  color: status == 0 || status == -1
                      ? ConstantsData.inActiveClr
                      : status == 1
                      ? ConstantsData.activeClr
                      : ConstantsData.absentClr,
                  fontWeight: FontWeight.bold,
                ),
              ).paddingSymmetric(horizontal: 10),
            ],
          ),
          Divider(
            indent: 10,
            thickness: isHeader ? 2 : 1,
            color: ConstantsData.inActiveClr.withOpacity(isHeader ? 1 : 0.4),
          ),
        ],
      ),
    );
  }
}
