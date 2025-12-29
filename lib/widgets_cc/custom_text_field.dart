import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class CustomTextField2 extends StatelessWidget {
  final String? hintText;
  final IconData? icon;
  final Function? onChange;
  final Function(String?)? onSubmit;

  final bool obscureText;
  final List<TextInputFormatter>? InputFormatter;
  final TextInputType inputType;
  final Function? validator;
  final bool enable;
  final int? maxline;
  final TextEditingController? controller;
  final String? title;
  final bool boldHint;
  final int maxLeng;
  final Widget? suffixWidget;

  const CustomTextField2(
      {Key? key,
      this.hintText,
      this.InputFormatter,
      this.validator,
      this.icon,
      this.onChange,
      this.onSubmit,
      this.obscureText = false,
      this.inputType = TextInputType.text,
      this.title,
      this.controller,
      this.maxline = 1,
      this.boldHint = false,
      this.suffixWidget,
      this.enable = true,
      this.maxLeng = 50})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          if (title != null) ...[
            Text(
              title ?? '',
              style: Get.textTheme.headlineSmall,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(
              height: 10.0,
            ),
          ],
          TextFormField(
              controller: controller,
              validator: validator as String? Function(String?)?,
              // as String? Function(String?)?,
              enabled: enable,
              keyboardType: inputType,
              textAlign: TextAlign.center,
              maxLines: maxline,
              inputFormatters: InputFormatter,
              maxLength: maxLeng,
              onFieldSubmitted: onSubmit,
              // decoration: InputDecoration(
              //   fillColor: Colors.white,
              //   filled: true,
              //   isDense: true,
              //   labelText: hintText,
              //   contentPadding:
              //       const EdgeInsets.symmetric(vertical: 10, horizontal: 7),
              //   prefixIcon: icon == null ? null : Icon(icon, size: 30),
              // ),
              style: TextStyle(color: boldHint ? Colors.blue : Colors.black87),
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.only(top: 0, left: 15, right: 15),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.grey, width: 0.4),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.grey, width: 0.8),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.red, width: 1.0),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                filled: true,
                fillColor: Colors.white,
                hintText: hintText,

                suffix: suffixWidget,
                hintStyle: Get.textTheme.headlineMedium!.copyWith(
                  color: Colors.grey.withOpacity(0.4),
                  fontWeight: FontWeight.w400,
                ),
                // prefixIcon: codeKey,
              ),
              obscureText: obscureText,
              onChanged: onChange as void Function(String)?),
        ],
      ),
    );
  }
}
