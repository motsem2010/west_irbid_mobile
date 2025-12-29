import 'package:flutter/material.dart';
import 'package:west_irbid_mobile/services_utils/translation_service.dart';

class CustomScaffold extends StatelessWidget {
  final Widget? appBar;
  final Widget? body;
  final Widget? drawer;
  final Color? backgroundColor;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  const CustomScaffold({
    Key? key,
    this.appBar,
    this.body,
    this.drawer,
    this.backgroundColor,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TranslationService().isLocaleArabic() == true
          ? TextDirection.rtl
          : TextDirection.ltr,
      child: Scaffold(
        floatingActionButton: floatingActionButton,
        floatingActionButtonLocation: floatingActionButtonLocation,
        appBar: appBar as PreferredSizeWidget?,
        body: body,
        drawer: drawer,
        backgroundColor:
            backgroundColor ?? Theme.of(context).scaffoldBackgroundColor,
      ),
    );
  }
}
