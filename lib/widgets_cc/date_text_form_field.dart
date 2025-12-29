import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DateTextFormField extends StatelessWidget {
  final FocusNode? focusNode;
  final FocusNode? newFocusNode;
  final int? num;
  final String? hintText;
  final TextEditingController? controller;

  const DateTextFormField(
      {Key? key,
      this.focusNode,
      this.num,
      this.newFocusNode,
      this.hintText,
      this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 4,
      child: TextField(
        keyboardType: TextInputType.phone,
        controller: controller,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
        ],
        focusNode: focusNode,
        onChanged: (String val) {
          if (val.length >= num!)
            FocusScope.of(context).requestFocus(newFocusNode);
        },
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 15.0, horizontal: 7),
          hintText: hintText,
        ),
        maxLines: 1,
      ),
    );
  }
}
