import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'custom_progress_indicator.dart';
import 'no_items_widget.dart';

class LoadingHandle extends StatelessWidget {
  final bool? popLoading;
  final Widget? loadingWidget;
  final Widget? widget;
  const LoadingHandle(
      {Key? key,
      @required this.widget,
      this.popLoading = true,
      this.loadingWidget})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (popLoading!) {
      return widget!;
    } else if (loadingWidget != null)
      return loadingWidget!;
    else
      return CustomProgressIndicator();
  }
}

class EmptyHandle extends StatelessWidget {
  final bool? popEmpty;
  final Widget? emptyWidget;
  final Widget? widget;
  const EmptyHandle(
      {Key? key, @required this.widget, this.popEmpty = true, this.emptyWidget})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (popEmpty ?? false) {
      return widget ?? Text('DD');
    } else if (emptyWidget != null) {
      return emptyWidget ?? Text('empty widget');
    } else
      return NoItemsWidget(
        text: 'noDataAvailable'.tr,
      );
  }
}
