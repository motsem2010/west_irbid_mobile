import 'package:flutter/material.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final List<Widget>? actions;

  const MainAppBar({Key? key, this.title, this.actions}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(50);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Text(
        title ?? "",
        style: Theme.of(context).appBarTheme.titleTextStyle,
      ),
      actions: actions,
    );
  }
}
