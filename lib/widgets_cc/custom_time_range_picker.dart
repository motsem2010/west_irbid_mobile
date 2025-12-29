import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomTimeRangePicker extends StatefulWidget {
  final bool fromOnly;
  final Function(String)? differenceHours;
  final Function(TimeOfDay)? onSubmitFrom;
  final Function(TimeOfDay)? onSubmitTo;
  final String? fromText;
  final String? toText;

  const CustomTimeRangePicker(
      {Key? key,
      this.onSubmitFrom,
      this.onSubmitTo,
      this.fromText,
      this.toText,
      this.fromOnly = false,
      this.differenceHours})
      : super(key: key);

  @override
  _CustomTimeRangePickerState createState() => _CustomTimeRangePickerState();
}

class _CustomTimeRangePickerState extends State<CustomTimeRangePicker> {
  TimeOfDay _fromTimeOfDay = TimeOfDay.now();
  TimeOfDay _toTimeOfDay = TimeOfDay.now();

  String getTime({required bool isFrom}) {
    TimeOfDay pickedTime = isFrom ? _fromTimeOfDay : _toTimeOfDay;
    int hour = pickedTime.hour > 12 ? pickedTime.hour - 12 : pickedTime.hour;
    String moment = pickedTime.hour > 12 ? 'PM' : "AM";
    return "${hour < 10 ? "0" + hour.toString() : hour}:${pickedTime.minute < 10 ? "0" + pickedTime.minute.toString() : pickedTime.minute} $moment";
  }

  InputDecoration inputDecoration(String hint) => InputDecoration(
      border: OutlineInputBorder(
        borderRadius: const BorderRadius.all(
          const Radius.circular(10.0),
        ),
      ),
      filled: true,
      label: Text(
        hint,
        style: TextStyle(color: Theme.of(context).primaryColor),
      ),

      //hintStyle: TextStyle(color: Colors.red),
      disabledBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            const Radius.circular(10.0),
          ),
          borderSide:
              BorderSide(width: 1.7, color: Theme.of(context).primaryColor)),
      enabledBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            const Radius.circular(10.0),
          ),
          borderSide:
              BorderSide(width: 1.7, color: Theme.of(context).primaryColor)),
      fillColor: Colors.white);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 25),
      child: Column(
        children: [
          GestureDetector(
            onTap: () async => _showTimePicker(true),
            child: TextFormField(
              style: TextStyle(color: Colors.black),
              enabled: false,
              controller: TextEditingController(text: getTime(isFrom: true)),
              readOnly: true,
              autofocus: true,
              decoration: inputDecoration(widget.fromText!),
            ),
          ),
          if (!widget.fromOnly)
            SizedBox(
              height: 20,
            ),
          if (!widget.fromOnly)
            GestureDetector(
              onTap: () async => _showTimePicker(false),
              child: TextFormField(
                style: TextStyle(color: Colors.black),
                enabled: false,
                autofocus: true,
                controller: TextEditingController(text: getTime(isFrom: false)),
                readOnly: true,
                decoration: inputDecoration(widget.toText!),
              ),
            ),
        ],
      ),
    );
  }

  String difference(TimeOfDay from, TimeOfDay to) {
    double _doubleYourTime = to.hour.toDouble() + to.minute.toDouble() / 60;
    double _doubleNowTime = from.hour.toDouble() + from.minute.toDouble() / 60;

    double _timeDiff = _doubleYourTime - _doubleNowTime;
    double _hr = _timeDiff.truncate().toDouble();
    double _minute = (_timeDiff - _timeDiff.truncate()) * 60;
    int hour = _hr.toInt();
    int min = _minute.round();
    if (min == 60) {
      hour++;
      min = 0;
    }
    return "${hour < 10 ? "0" + hour.toString() : hour}:${min < 10 ? "0" + min.toString() : min}";
  }

  void fromValidate(TimeOfDay timeOfDay) {
    if (_toTimeOfDay.hour < timeOfDay.hour)
      setState(() => _toTimeOfDay = timeOfDay);
    else if (_toTimeOfDay.hour == timeOfDay.hour &&
        _toTimeOfDay.minute <= timeOfDay.minute)
      setState(() => _toTimeOfDay = timeOfDay);
    if (widget.differenceHours != null)
      widget.differenceHours!(difference(timeOfDay, _toTimeOfDay));
  }

  void toValidate(TimeOfDay timeOfDay) {
    if (timeOfDay.hour < _fromTimeOfDay.hour)
      setState(() => _toTimeOfDay = _fromTimeOfDay);
    else if (timeOfDay.hour == _fromTimeOfDay.hour &&
        timeOfDay.minute <= _fromTimeOfDay.minute)
      setState(() => _toTimeOfDay = _fromTimeOfDay);
    if (widget.differenceHours != null)
      widget.differenceHours!(difference(_fromTimeOfDay, timeOfDay));
  }

  void _showTimePicker(bool isFrom) {
    showTimePicker(
      context: context,
      initialEntryMode: TimePickerEntryMode.dial,
      initialTime: isFrom ? _fromTimeOfDay : _toTimeOfDay,
    ).then((value) {
      setState(() {
        if (isFrom) {
          _fromTimeOfDay = value ?? _fromTimeOfDay ?? TimeOfDay.now();
          fromValidate(value!);
          widget.onSubmitFrom!(_fromTimeOfDay);
        } else {
          _toTimeOfDay =
              value ?? _toTimeOfDay ?? _fromTimeOfDay ?? TimeOfDay.now();
          toValidate(value!);
          widget.onSubmitTo!(_toTimeOfDay);
        }
      });
    });
  }
}
