import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField(
      {Key? key,
      required this.textFieldController,
      required this.title,
      required this.hint,
      required this.textInputType,
      // this.subtitle,
      this.validator,
      this.codeKey,
      this.maxLength,
      this.leading,
      this.maxLine,
      this.isSecured = false,
      this.InputFormatter,
      this.onChange,
      this.enabled = true})
      : super(key: key);
  TextEditingController textFieldController = TextEditingController();
  String title;
  String hint;
  // String? subtitle;
  TextInputType textInputType;
  Widget? codeKey;
  int? maxLength;
  Widget? leading;
  bool? isSecured;
  int? maxLine;
  bool enabled;
  List<TextInputFormatter>? InputFormatter;

  final Function(String?)? onChange;

  final FormFieldValidator<String?>? validator;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(width: 10, height: 10, child: leading ?? const SizedBox()),
            // leading == null
            //     ? const SizedBox(
            //         width: 1,
            //       )
            //     : const SizedBox(
            //         width: 5.0,
            //       ),
            Expanded(
              // fit: BoxFit.scaleDown,
              child: Text(
                title.tr,
                style: Get.textTheme.headlineSmall,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),

            // Text(
            //   (subtitle != null) ? subtitle!.tr : '',
            //   style: Get.textTheme.bodySmall,
            // )
          ],
        ),
        const SizedBox(
          height: 10.0,
        ),
        TextFormField(
          enabled: this.enabled,
          obscureText: isSecured!,
          enableSuggestions: !isSecured!,
          autocorrect: !isSecured!,
          inputFormatters: InputFormatter != null
              ? [
                  ...InputFormatter!,
                  LengthLimitingTextInputFormatter(maxLength ?? 100),
                ]
              : [
                  LengthLimitingTextInputFormatter(maxLength ?? 100),
                ],
          controller: textFieldController,
          validator: validator,
          keyboardType: textInputType,
          maxLines: maxLine ?? 1,
          onChanged: onChange,
          textAlign: TextAlign.start,
          style: Get.textTheme.headlineMedium!.copyWith(
            color: Colors.grey.withOpacity(0.8),
            fontWeight: FontWeight.w600,
          ),
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.only(top: 5, left: 15, right: 15),
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
            hintText: hint.tr,
            hintStyle: Get.textTheme.bodySmall!.copyWith(
              color: Colors.grey.withOpacity(0.4),
              // fontWeight: FontWeight.ws400,
            ),
            prefixIcon: codeKey,
          ),
        ),
      ],
    );
  }
}
