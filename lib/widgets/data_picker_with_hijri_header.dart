import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:west_irbid_mobile/services_utils/size_utils.dart';

class DatePickerWithHeaderWidget extends StatefulWidget {
  final String? content;
  final String? hint;
  final Function? onChange;
  final Function? validator;
  TextEditingController? controller;

  DatePickerWithHeaderWidget({
    Key? key,
    this.content,
    this.hint,
    this.onChange,
    this.validator,
    this.controller,
  }) : super(key: key);

  @override
  State<DatePickerWithHeaderWidget> createState() => _DatePickerWidgetState();
}

class _DatePickerWidgetState extends State<DatePickerWithHeaderWidget> {
  DateTime from = DateTime.now();

  Future selectedPicker(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: from,
      firstDate: DateTime(1956),
      lastDate: DateTime(2030),
    );
    if (picked !=
        null //&& (picked != from)
        ) {
      setState(() {
        from = picked;
        widget.controller!.text = getStringDate(from);
      });
    }
  }

  String getStringDate(DateTime dateTime) {
    String year = dateTime.year.toString();
    String month = dateTime.month.toString().padLeft(2, '0');
    String day = dateTime.day.toString().padLeft(2, '0');
    String result = month + '/' + day + '/' + year;

    return result;
  }

  @override
  void initState() {
    // widget.controller!.text = getStringDate(from);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          FittedBox(
            child: Text(
              widget.hint ?? ' ',
              style: Get.textTheme.headlineSmall,
              maxLines: 1,
            ),
          ),
          const SizedBox(height: 10.0),
          // Text(
          //   widget.hint ?? ' ',
          //   style: Theme.of(context).textTheme.bodyLarge,
          //   maxLines: 1,
          //   overflow: TextOverflow.ellipsis,
          // ),
          TextFormField(
            onTap: () async {
              await selectedPicker(context);
            },
            controller: widget.controller,
            readOnly: true,
            validator: widget.validator as String? Function(String?)?,
            decoration: InputDecoration(
              isDense: true,
              border: OutlineInputBorder(
                borderRadius: const BorderRadius.all(
                  const Radius.circular(10.0),
                ),
              ),
              filled: true,
              // labelText: widget.hint,
              hintStyle: TextStyle(color: Colors.grey[800]),
              fillColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
