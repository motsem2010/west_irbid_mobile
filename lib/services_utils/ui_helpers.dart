import 'dart:io';

import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/utils.dart';
import 'package:west_irbid_mobile/services_utils/constants.dart';
import 'package:west_irbid_mobile/services_utils/custom_apis_methods.dart';

startLoading(BuildContext context, {bool willPop = false}) {
  showDialog(
    context: context,
    builder: (context) => WillPopScope(
      onWillPop: () async => willPop,
      child: const CustomProgressIndicator(),
    ),
  );
}

class CustomProgressIndicator extends StatelessWidget {
  const CustomProgressIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Platform.isIOS
          ? const CupertinoActivityIndicator()
          : SpinKitCircle(color: Theme.of(context).primaryColor),
    );
  }
}

void showToast(
  String message, {
  Color backgroundColor = Colors.black,
  Color textColor = Colors.white,
}) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.CENTER,
    timeInSecForIosWeb: 1,
    backgroundColor: backgroundColor,
    textColor: textColor,
    fontSize: 16.0,
  );
}

class NavigatorKey {
  static final instance = new GlobalKey<NavigatorState>();
  NavigatorKey._();
}

coolAlert({
  required context,
  lottie,
  String? text,
  required CoolAlertType type,
}) {
  CoolAlert.show(
    width: 200,
    context: context,
    title: 'error'.tr,
    type: type,
    lottieAsset: lottie,
    text: text,
  );
}

Future<bool> generalDialog({
  required BuildContext context,
  String? text,
  CoolAlertType? coolAlertType,
  Function()? onPressOk,
}) async {
  bool result = false;

  await CoolAlert.show(
    width: 200,
    context: context,
    type: coolAlertType ?? CoolAlertType.warning,
    text: text ?? 'areYouSureYouWantToExit'.tr,
    onConfirmBtnTap: onPressOk ?? () {},
    onCancelBtnTap: () {
      result = true;
      pop(context);
    },
    // showCancelBtn: true,
    confirmBtnText: 'Ok'.tr,
    // cancelBtnText: 'Cancel'.tr,
    // confirmBtnColor: null,
  );

  return result;
}

alert(
  BuildContext context,
  CoolAlertType coolAlertType,
  String? text, {
  String? lottieAsset,
  Function? onTap,
}) {
  showDialog(
    context: context,
    builder: (_) => Platform.isIOS
        ? CupertinoAlertDialog(
            content: Text(text ?? ""),
            actions: [
              CupertinoButton(
                child: Text('ok'.tr),
                onPressed:
                    onTap as void Function()? ??
                    () {
                      pop(context);
                    },
              ),
            ],
          )
        : AlertDialog(
            actions: [
              TextButton(
                onPressed:
                    onTap as void Function()? ??
                    () {
                      pop(context);
                    },
                child: Text('ok'.tr),
              ),
            ],
            content: SizedBox(
              height: 60,
              child: Center(child: Text(text ?? "")),
            ),
          ),
  );
}

Future<bool> exitAppDialog({required BuildContext context}) async {
  bool result = false;

  await CoolAlert.show(
    context: context,
    type: CoolAlertType.warning,
    text: 'areYouSureYouWantToExit'.tr,
    onConfirmBtnTap: () {
      // ConstantsData.lectureData = null;
      // ConstantsData.studentData = null;
      // ConstantsData.selectedLabId = -1;
      CustomApi.userToken = '';
      pop(context);
    },
    onCancelBtnTap: () {
      result = true;
      pop(context);
    },
    showCancelBtn: true,
    confirmBtnText: 'cancel',
    cancelBtnText: 'exit',
    // confirmBtnColor: null,
  );

  return result;
}

pop(BuildContext context) {
  Navigator.pop(context);
}

pushNamed(String routeName, {String? args}) {
  NavigatorKey.instance.currentState!.pushNamed(routeName, arguments: args);
}

push(Widget page) {
  NavigatorKey.instance.currentState!.push(
    MaterialPageRoute(builder: (_) => page),
  );
}

class AndroidDialog extends StatelessWidget {
  final Function onPress;
  final String text;

  const AndroidDialog({Key? key, required this.onPress, required this.text})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: Text(text),
      onPressed: onPress as void Function()?,
    );
  }
}

class IosDialog extends StatelessWidget {
  final Function onPress;
  final String text;

  const IosDialog({Key? key, required this.onPress, required this.text})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      child: Text(text),
      onPressed: onPress as void Function()?,
    );
  }
}

InputDecoration inputDecoration(String hint) => InputDecoration(
  border: OutlineInputBorder(
    borderRadius: const BorderRadius.all(const Radius.circular(10.0)),
  ),
  filled: true,
  label: Text(
    hint,
    style: TextStyle(
      color: Theme.of(NavigatorKey.instance.currentContext!).primaryColor,
    ),
  ),

  //hintStyle: TextStyle(color: Colors.red),
  disabledBorder: OutlineInputBorder(
    borderRadius: const BorderRadius.all(const Radius.circular(10.0)),
    borderSide: BorderSide(
      width: 1.7,
      color: Theme.of(NavigatorKey.instance.currentContext!).primaryColor,
    ),
  ),
  fillColor: Colors.white,
);

InputDecoration inputDecorationCompose(String hint) => InputDecoration(
  border: OutlineInputBorder(
    borderRadius: const BorderRadius.all(const Radius.circular(10.0)),
  ),
  filled: true,
  label: Text(
    hint,
    style: TextStyle(
      color: Theme.of(NavigatorKey.instance.currentContext!).hintColor,
    ),
  ),
  //hintStyle: TextStyle(color: Colors.red),
  disabledBorder: OutlineInputBorder(
    borderRadius: const BorderRadius.all(const Radius.circular(10.0)),
    borderSide: BorderSide(
      width: 1.4,
      color: Theme.of(NavigatorKey.instance.currentContext!).primaryColor,
    ),
  ),
  errorBorder: OutlineInputBorder(
    borderRadius: const BorderRadius.all(const Radius.circular(10.0)),
    borderSide: BorderSide(
      width: 1.4,
      color: Theme.of(NavigatorKey.instance.currentContext!).colorScheme.error,
    ),
  ),
  errorStyle: TextStyle(
    color: Theme.of(NavigatorKey.instance.currentContext!).colorScheme.error,
  ),
  fillColor: Colors.white,
);

// Widget dialogByPlatform(
//     BuildContext context, String? content, List<DialogAction> actions,
//     {String? title}) {
//   return Platform.isIOS
//       ? CupertinoAlertDialog(
//           title: Text(title ?? ''),
//           content: SelectableText(content ?? ""),
//           actions: [
//             for (var action in actions)
//               IosDialog(onPress: action.onPressed, text: action.actionName)
//           ],
//         )
//       : AlertDialog(
//           title: Text(title ?? ''),
//           actions: [
//             for (var action in actions)
//               AndroidDialog(onPress: action.onPressed, text: action.actionName),
//           ],
//           content: SingleChildScrollView(
//             child: Column(
//               children: [
//                 Center(child: Text(content ?? "")),
//               ],
//             ),
//           ),
//         );
// }

// import 'package:eschool/eschool.dart';
// import 'package:flutter/material.dart';

show_snackBar(BuildContext context, Color bgColor, String textContent) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(backgroundColor: bgColor, content: Text(textContent)),
  );
}

Future<String?> customInputDialog({
  required BuildContext context,
  required String title,
  required String hintTitle,
  TextInputType? inputType = TextInputType.text,
  required TextDirection textDirection,
}) async {
  final TextEditingController _IDController = TextEditingController();
  String? x = await showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        content: Directionality(
          textDirection: textDirection,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Column(
                children: [
                  Text(
                    title,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  TextField(
                    cursorColor: Theme.of(context).primaryColor,
                    maxLines: null,
                    controller: _IDController,
                    decoration: InputDecoration(
                      // hintText: hintTitle,
                      labelText: hintTitle,
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 20,
                      ),
                    ),
                    keyboardType: inputType,
                  ),
                ],
              ),
            ],
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    child: Text('submit.tr'),
                    onPressed: () {
                      Navigator.pop(context, _IDController.text);
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    },
  );
  return x;
}
