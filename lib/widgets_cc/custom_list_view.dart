import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:west_irbid_mobile/widgets_cc/custom_container.dart';

class CustomListView extends StatelessWidget {
  final List<Widget>? children;
  final EdgeInsets? padding;
  final ScrollController? scrollController;

  const CustomListView({
    Key? key,
    this.children,
    this.padding,
    this.scrollController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomRoundedContainer(
      child: ListView(
        controller: scrollController,
        padding: padding,
        children: <Widget>[SizedBox(height: 10)] + children!,
      ),
    );
  }
}
