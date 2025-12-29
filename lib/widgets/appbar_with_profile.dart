import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:west_irbid_mobile/services_utils/size_utils.dart';
import 'package:west_irbid_mobile/services_utils/ui_helpers.dart';

class AppBarAtaa extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final List<Widget>? actions;
  final String? userImage;
  final Color? textColor;
  final bool withBack;

  const AppBarAtaa({
    Key? key,
    this.title,
    this.actions,
    this.userImage,
    this.textColor,
    this.withBack = true,
  }) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(50);

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    return AppBar(
      toolbarHeight: 50,
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      title: Padding(
        padding: EdgeInsets.only(bottom: 5),
        child: Text(
          title ?? 'Hi, 🤝',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: textColor ?? Theme.of(context).primaryColor,
          ),
          maxLines: 1,
          overflow: TextOverflow
              .ellipsis, // TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        // leadingWidth: size.width / 1.5,
        // leadingWidth: size.width / 2,
      ),
      leading: withBack
          ? IconButton(
              icon: Icon(
                CupertinoIcons.back,
                color: textColor ?? Theme.of(context).primaryColor,
              ),
              onPressed: () {
                pop(context);
              },
            ).animate(delay: Duration(seconds: 1)).scale()
          : null,
      actions: actions,
    );
  }
}
