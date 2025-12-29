import 'package:flutter/material.dart';

class TabTextWidget extends StatelessWidget {
  final String? text;
  const TabTextWidget({Key? key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tabTextStyle = TextStyle(fontSize: 16, fontWeight: FontWeight.bold);
    return Tab(
      child: FittedBox(
        child: Text(
          text!,
          maxLines: 1,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ),
    );
  }
}
