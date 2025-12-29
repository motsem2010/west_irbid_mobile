import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AttendenceTotalAbsentItem extends StatelessWidget {
  AttendenceTotalAbsentItem(
      {Key? key,
      required this.title,
      required this.totalNum,
      required this.textClr})
      : super(key: key);
  String title;
  int totalNum;
  Color textClr;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              title,
              style: Get.textTheme.headlineMedium
                  ?.copyWith(color: textClr, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            width: Get.width * 0.02,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
                color: Colors.black87,
                borderRadius: BorderRadius.all(Radius.circular(8))),
            child: Text(
              totalNum.toString(),
              style: Get.textTheme.headlineMedium
                  ?.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    ).marginOnly(bottom: 5);
  }
}
