import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/src/intl/date_format.dart';
import 'package:west_irbid_mobile/services_utils/ui_helpers.dart';

// ignore: must_be_immutable
class CustomDateRangePicker extends StatefulWidget {
  final bool fromOnly;
  final Function(String)? differenceDays;
  final Function(String)? onSubmitFrom;
  final Function(String)? onSubmitTo;
  final String dateFormatDisplay;
  final String? dateFormatResponse;
  final String? fromText;
  final String? toText;

  const CustomDateRangePicker({
    Key? key,
    this.onSubmitFrom,
    this.onSubmitTo,
    this.dateFormatDisplay = 'dd/MM/yyyy',
    this.fromText,
    this.toText,
    this.dateFormatResponse,
    this.fromOnly = false,
    this.differenceDays,
  }) : super(key: key);

  @override
  _CustomDateRangePickerState createState() => _CustomDateRangePickerState();
}

class _CustomDateRangePickerState extends State<CustomDateRangePicker> {
  DateTime? pickedDateFrom = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );
  DateTime? pickedDateTo = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );

  String getDate({required bool isFrom}) {
    DateTime pickedDate = isFrom ? pickedDateFrom! : pickedDateTo!;
    return DateFormat(widget.dateFormatResponse).format(pickedDate);
  }

  @override
  void initState() {
    dateFromController.text = DateFormat(
      widget.dateFormatDisplay,
    ).format(pickedDateFrom!);
    dateToController.text = DateFormat(
      widget.dateFormatDisplay,
    ).format(pickedDateTo!);
    super.initState();
  }

  TextEditingController dateFromController = TextEditingController();
  TextEditingController dateToController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
      child: Column(
        children: [
          GestureDetector(
            onTap: () async {
              if (Platform.isIOS) {
                await cupertinoDatePicker(context, true);
              } else {
                await materialDateTimePicker(context, true);
                setState(() {});
              }
              if (widget.onSubmitFrom != null) {
                if (pickedDateTo!.isBefore(pickedDateFrom!)) {
                  setState(() {
                    pickedDateTo = pickedDateFrom;
                  });
                }
                dateFromController.text = DateFormat(
                  widget.dateFormatDisplay,
                ).format(pickedDateFrom!);
                await widget.onSubmitFrom!(getDate(isFrom: true));
              }
            },
            child: TextFormField(
              enabled: false,
              style: TextStyle(color: Colors.black),
              controller: dateFromController,
              readOnly: true,
              autofocus: true,
              decoration: inputDecoration(widget.fromText!),
            ),
          ),
          if (!widget.fromOnly) SizedBox(height: 20),
          if (!widget.fromOnly)
            GestureDetector(
              onTap: () async {
                if (Platform.isIOS) {
                  await cupertinoDatePicker(context, false);
                } else {
                  await materialDateTimePicker(context, false);
                  setState(() {});
                }
                if (widget.onSubmitTo != null) {
                  await widget.onSubmitTo!(getDate(isFrom: false));
                  dateToController.text = DateFormat(
                    widget.dateFormatDisplay,
                  ).format(pickedDateTo!);
                }
              },
              child: TextFormField(
                style: TextStyle(color: Colors.black),
                enabled: false,
                controller: dateToController,
                readOnly: true,
                decoration: inputDecoration(widget.toText!),
              ),
            ),
        ],
      ),
    );
  }

  materialDateTimePicker(BuildContext context, isFrom) async {
    var pickedDate = await showDatePicker(
      initialDate: isFrom ? pickedDateFrom! : pickedDateTo!,
      context: context,
      firstDate: !isFrom ? pickedDateFrom! : DateTime(2000),
      lastDate: DateTime(2100),
      initialDatePickerMode: DatePickerMode.day,
    );
    setState(() {
      if (isFrom) {
        pickedDateFrom = pickedDate;
        if (pickedDateFrom == null) pickedDateFrom = DateTime.now();
      } else {
        pickedDateTo = pickedDate;
        if (pickedDateTo == null) pickedDateTo = DateTime.now();
      }
    });
    if (!widget.fromOnly && widget.differenceDays != null)
      if (pickedDateTo!.isBefore(pickedDateFrom!)) {
        pickedDateTo = pickedDateFrom;
        dateToController.text = DateFormat(
          widget.dateFormatDisplay,
        ).format(pickedDateTo!);
      }
    if (!widget.fromOnly && widget.differenceDays != null)
      widget.differenceDays!(
        daysBetweenExcludingFriday(pickedDateFrom!, pickedDateTo!).toString(),
      );
  }

  cupertinoDatePicker(BuildContext context, bool isFrom) async {
    final height = MediaQuery.of(context).size.height;
    var tmpDate = (isFrom ? pickedDateFrom : pickedDateTo) ?? DateTime.now();
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
                minimumDate: !isFrom ? pickedDateFrom : DateTime(2000),
                initialDateTime:
                    (isFrom ? pickedDateFrom : pickedDateTo) ?? DateTime.now(),
                onDateTimeChanged: (val) => tmpDate = val,
              ),
            ),
            CupertinoButton(
              child: Text('Ok'.tr),
              onPressed: () {
                setState(() {
                  if (isFrom)
                    pickedDateFrom = tmpDate;
                  else
                    pickedDateTo = tmpDate;
                });
                if (pickedDateTo!.isBefore(pickedDateFrom!)) {
                  pickedDateTo = pickedDateFrom;
                  dateToController.text = DateFormat(
                    widget.dateFormatDisplay,
                  ).format(pickedDateTo!);
                }
                if (!widget.fromOnly && widget.differenceDays != null)
                  widget.differenceDays!(
                    daysBetweenExcludingFriday(
                      pickedDateFrom!,
                      pickedDateTo!,
                    ).toString(),
                  );
                pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  int daysBetweenExcludingFriday(DateTime startDate, DateTime endDate) {
    print(startDate);
    print(endDate);
    int totalDays = (endDate.difference(startDate).inHours / 24).floor() + 1;
    int fridayCount = 0;
    print(totalDays);

    for (int i = 0; i <= totalDays; i++) {
      DateTime currentDate = startDate.add(Duration(days: i));

      if (currentDate.weekday == DateTime.friday ||
          currentDate.weekday == DateTime.saturday) {
        fridayCount++;
      }
    }

    return totalDays - fridayCount;
  }
}
