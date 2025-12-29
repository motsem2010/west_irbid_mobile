import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HelloUserWidget extends StatelessWidget {
  String username;
  HelloUserWidget({required this.username});
  @override
  Widget build(BuildContext context) {
    return Text(
      '${'hiUsername'.tr} ${username.split(' ')[0]}',
      style: TextStyle(
          fontSize: 22,
          color: Theme.of(context).primaryColor,
          fontWeight: FontWeight.bold),
    );
  }
}
