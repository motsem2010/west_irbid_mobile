import 'package:flutter/material.dart';
import 'package:west_irbid_mobile/services_utils/translation_service.dart';
import 'package:west_irbid_mobile/widgets/appbar_with_profile.dart';
import 'package:west_irbid_mobile/widgets_cc/custom_scaffold.dart';
import 'package:west_irbid_mobile/widgets_cc/loading_handle.dart';

class CustomViewN<T> extends StatelessWidget {
  final List<Widget>? body;
  final String? title;
  final Color? titleColor;
  final GlobalKey<FormState>? formKey;
  final EdgeInsets? padding;
  final ScrollController? scrollController;
  final bool? popLoading;
  final bool? removeAppbar;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final Widget Function(BuildContext, T, Widget?)? builder;
  final bool? popEmpty;
  final List<Widget>? actions;
  final bool onlyAppearsActions;
  final bool withBack;
  final bool validateInInteraction;

  CustomViewN({
    Key? key,
    this.body,
    this.floatingActionButton,
    this.title,
    this.titleColor,
    this.popLoading = true,
    this.popEmpty = true,
    this.onlyAppearsActions = false,
    this.scrollController,
    this.padding,
    this.formKey,
    this.builder,
    this.withBack = true,
    this.floatingActionButtonLocation,
    this.removeAppbar = false,
    this.actions,
    this.validateInInteraction = false,
  }) : super(key: key);

  Widget getFormChild(Widget child) {
    if (formKey != null)
      return Form(
        autovalidateMode: validateInInteraction
            ? AutovalidateMode.onUserInteraction
            : AutovalidateMode.disabled,
        key: formKey,
        child: child,
      );
    return child;
  }

  // Widget getConsumerChild(Widget child) {
  //   if (builder != null) return Consumer<T>(builder: builder!);
  //   return child;
  // }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TranslationService().isLocaleArabic()
          ? TextDirection.rtl
          : TextDirection.ltr,
      child: CustomScaffold(
        appBar: !(removeAppbar ?? false)
            ? AppBarAtaa(
                title: onlyAppearsActions ? '' : title,
                textColor: titleColor,
                actions: actions,
                withBack: onlyAppearsActions ? false : withBack,
                // actions: [
                //   StatefulBuilder(
                //       builder: (BuildContext context, StateSetter setState) {
                //     return IconButton(
                //         onPressed: () {
                //           if (Settings.isEnglish()) {
                //             Settings.language = ArLanguage();
                //           } else {
                //             Settings.language = EnLanguage();
                //           }
                //           setState(() {});
                //         },
                //         icon: Icon(
                //           Icons.language,
                //           color: Colors.black26,
                //         ));
                //   })
                // ],
              )
            : null,
        body: Stack(
          children: [
            // Container(
            //   width: MediaQuery.of(context).size.width,
            //   height: MediaQuery.of(context).size.height,
            //   child: SvgPicture.asset(
            //     'assets/images/bg.svg',
            //     fit: BoxFit.fitWidth,
            //   ),
            // ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              child: LoadingHandle(
                popLoading: popLoading,
                widget: EmptyHandle(
                  popEmpty: popEmpty,
                  widget: getFormChild(
                    ListView(
                      padding: padding,
                      children: body ?? [],
                      controller: scrollController,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        floatingActionButton: floatingActionButton,
        floatingActionButtonLocation: floatingActionButtonLocation,
      ),
    );
  }
}
