import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:west_irbid_mobile/services_utils/ui_helpers.dart';

class CustomDatePicker extends StatefulWidget {
  final TextEditingController? year;
  final TextEditingController? month;
  final TextEditingController? day;
  final Function? onSubmit;
  final String title;

  const CustomDatePicker({
    Key? key,
    this.year,
    this.month,
    this.day,
    this.onSubmit,
    required this.title,
  }) : super(key: key);

  @override
  _CustomDatePickerState createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  DateTime? pickedDate = DateTime.now();

  String getDate() {
    if (pickedDate == null) {
      widget.day?.text = DateTime.now().day.toString();
      widget.month?.text = DateTime.now().month.toString();
      widget.year?.text = DateTime.now().year.toString();
    } else {
      widget.day?.text = pickedDate!.day.toString();
      widget.month?.text = pickedDate!.month.toString();
      widget.year?.text = pickedDate!.year.toString();
    }
    if (widget.month!.text.length <= 1)
      widget.month?.text = '0' + widget.month!.text;
    if (widget.day!.text.length <= 1) widget.day!.text = '0' + widget.day!.text;
    String date =
        widget.day!.text + '/' + widget.month!.text + '/' + widget.year!.text;
    return date;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (Platform.isIOS) {
          await cupertinoDatePicker(context);
        } else {
          await materialDateTimePicker(context);
          setState(() {});
        }
        if (widget.onSubmit != null) {
          startLoading(context);
          await widget.onSubmit!(getDate());
          pop(context);
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FittedBox(
            child: Text(
              widget.title,
              style: Get.textTheme.headlineSmall,
              maxLines: 1,
            ),
          ),
          const SizedBox(height: 10.0),
          Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: Colors.grey[600]!),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                AutoSizeText(getDate(), style: TextStyle(fontSize: 16)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  materialDateTimePicker(BuildContext context) async {
    pickedDate = await showDatePicker(
      initialDate: pickedDate!,
      context: context,
      firstDate: DateTime(2018),
      lastDate: DateTime(2025),
      initialDatePickerMode: DatePickerMode.day,
    );
    if (pickedDate == null) pickedDate = DateTime.now();
  }

  cupertinoDatePicker(BuildContext context) async {
    final height = MediaQuery.of(context).size.height;
    await showCupertinoModalPopup(
      context: context,
      builder: (_) => Container(
        height: height * .4,
        color: Color.fromARGB(255, 255, 255, 255),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: height * .3,
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.date,
                initialDateTime: pickedDate,
                onDateTimeChanged: (val) {
                  setState(() {
                    pickedDate = val;
                  });
                },
              ),
            ),
            CupertinoButton(
              child: Text('Ok'.tr),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      ),
    );
  }
}
