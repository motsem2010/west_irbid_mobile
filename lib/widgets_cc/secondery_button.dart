import 'package:flutter/material.dart';

class SeconderyButton extends StatelessWidget {
  final Function? onPressed;
  final String? text;
  final Color color;
  Icon? iconData;

  SeconderyButton(
      {Key? key,
      this.onPressed,
      this.text,
      this.iconData,
      this.color = const Color(0xffffffff)})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: ElevatedButton(
        style: Theme.of(context).elevatedButtonTheme.style,
        onPressed: onPressed as void Function()?,
        child: Row(
          children: [
            iconData != null ? iconData! : Container(),
            SizedBox(
              width: iconData != null ? 10 : 0,
            ),
            Text(
              text!,
              style: Theme.of(context).textTheme.displayMedium,
            ),
          ],
        ),
      ),
    );
  }
}
