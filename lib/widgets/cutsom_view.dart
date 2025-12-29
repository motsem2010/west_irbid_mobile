import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:west_irbid_mobile/services_utils/translation_service.dart';
import 'package:west_irbid_mobile/widgets/appbar_with_profile.dart';
import 'package:west_irbid_mobile/widgets_cc/custom_scaffold.dart';
import 'package:west_irbid_mobile/widgets_cc/loading_handle.dart';

class CustomView<T extends GetxController> extends StatelessWidget {
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
  final Widget Function(T)? builder;
  final bool? popEmpty;
  final List<Widget>? actions;
  final bool withBack;
  CustomView({
    Key? key,
    this.body,
    this.floatingActionButton,
    this.title,
    this.titleColor,
    this.popLoading = true,
    this.popEmpty = true,
    this.scrollController,
    this.padding,
    this.formKey,
    this.builder,
    this.withBack = true,
    this.floatingActionButtonLocation,
    this.removeAppbar = false,
    this.actions,
  }) : super(key: key);

  Widget getFormChild(Widget child) {
    if (formKey != null) return Form(key: formKey, child: child);
    return child;
  }

  Widget getConsumerChild(Widget child) {
    if (builder != null) return GetBuilder<T>(builder: builder!);
    return child;
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TranslationService().isLocaleArabic()
          ? TextDirection.rtl
          : TextDirection.ltr,
      child: CustomScaffold(
        appBar: !(removeAppbar ?? false)
            ? AppBarAtaa(
                title: title,
                textColor: titleColor,
                actions:
                    actions ??
                    [
                      GestureDetector(
                        child: SizedBox(
                          height: 30,
                          // Get.statusBarHeight * 0.5,
                          child: Image.asset(
                            !TranslationService().isLocaleArabic()
                                ? 'assets/images/en.png'
                                : 'assets/images/ar.png',
                          ),
                        ),
                        onTap: () async {
                          Get.log(TranslationService.locale.toString());
                          if (!TranslationService().isLocaleArabic()) {
                            TranslationService().changeLocale('ar_SA');
                          } else {
                            TranslationService().changeLocale('en_US');
                          }
                        },
                      ).paddingSymmetric(horizontal: 10),
                      // IconButton(
                      //     onPressed: () {
                      //       Get.log(TranslationService.locale.toString());
                      //       if (!TranslationService().isLocaleArabic()) {
                      //         TranslationService().changeLocale('ar_SA');
                      //       } else {
                      //         TranslationService().changeLocale('en_US');
                      //       }
                      //     },
                      //     icon: const Icon(Icons.language)),
                    ],
                withBack: withBack,
              )
            : null,
        body: Stack(
          children: [
            // Container(
            //     width: MediaQuery.of(context).size.width,
            //     height: MediaQuery.of(context).size.height,
            //     child: Image.asset('assets/images/bg.jpg', fit: BoxFit.fill)
            //     //     SvgPicture.asset(
            //     //   'assets/svg/sabl.svg',
            //     //   fit: BoxFit.fitWidth,
            //     // ),
            //     ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              color: Colors.transparent,
              child: LoadingHandle(
                popLoading: popLoading,
                widget: EmptyHandle(
                  popEmpty: popEmpty,
                  widget: getFormChild(
                    getConsumerChild(
                      ListView(
                        padding: padding,
                        children: body ?? [],
                        controller: scrollController,
                      ),
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
