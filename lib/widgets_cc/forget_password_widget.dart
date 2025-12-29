// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

// import '../../../eschool.dart';

// class ForgetPasswordWidget extends StatefulWidget {
//   const ForgetPasswordWidget({Key? key}) : super(key: key);

//   @override
//   State<ForgetPasswordWidget> createState() => _ForgetPasswordWidgetState();
// }

// class _ForgetPasswordWidgetState extends State<ForgetPasswordWidget> {
//   final TextEditingController _mobileController =
//       TextEditingController(text: '');
//   final _formForgetKey = GlobalKey<FormState>();

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: TextButton(
//         onPressed: () => forgetPasswordDialog(context),
//         child: Text(Settings.language.forgetPassword),
//       ),
//     );
//   }

//   AccountType selectedType = AccountType(Settings.language.employee, '1');

//   void forgetPasswordDialog(BuildContext context) {
//     Settings.currentUser;
//     showDialog(
//         context: context,
//         builder: (context) => Directionality(
//               textDirection: Settings.language.textDirection,
//               child: Form(
//                   key: _formForgetKey,
//                   child: AlertDialog(
//                     actions: [
//                       Builder(builder: (context) {
//                         return SizedBox(
//                           width: 400,
//                           child: Column(
//                             children: [
//                               CustomTextField(
//                                 controller: _mobileController,
//                                 validator: (val) {
//                                   if (val.toString().length > 14 &&
//                                       !val.startsWith('0')) {
//                                     return Settings.language.numberCorrect;
//                                   }
//                                 },
//                                 InputFormatter: [
//                                   FilteringTextInputFormatter.allow(
//                                       RegExp('[0-9]')),
//                                 ],
//                                 inputType: TextInputType.phone,
//                                 hintText: Settings.language.phoneNumber,
//                                 icon: Icons.phone_android_rounded,
//                               ),
//                               SizedBox(
//                                 height: 15,
//                               ),
//                               CustomDropDownList(
//                                 hint: Settings.language.accountType,
//                                 list: [
//                                   AccountType(Settings.language.employee, '1'),
//                                   AccountType(Settings.language.teacher, '1'),
//                                   AccountType(Settings.language.parent, '3'),
//                                   AccountType(Settings.language.student, '4'),
//                                 ],
//                                 onChange: (val) =>
//                                     setState(() => selectedType = val),
//                               ),
//                               Center(
//                                 child: ElevatedButton(
//                                     style: ElevatedButton.styleFrom(
//                                         padding: EdgeInsets.symmetric(
//                                             horizontal: 30, vertical: 10)),
//                                     onPressed: () async {
//                                       //0796092427
//                                       if (!_formForgetKey.currentState!
//                                           .validate()) return;
//                                       startLoading(context);
//                                       var response =
//                                           await AuthController.forgotPassword(
//                                               mobile: _mobileController.text,
//                                               typeID: selectedType.typeID);
//                                       Navigator.pop(context);
//                                       String message = (response == 'true')
//                                           ? Settings.language.messageSent
//                                           : Settings.language.numberCorrect;
//                                       showDialog(
//                                           context: context,
//                                           builder: (con) => dialogByPlatform(
//                                                   context, message, [
//                                                 DialogAction(
//                                                     onPressed: () {
//                                                       if (response == 'true')
//                                                         Navigator.pop(context);
//                                                       Navigator.pop(context);
//                                                       _mobileController.clear();
//                                                     },
//                                                     actionName:
//                                                         Settings.language.ok)
//                                               ]));
//                                     },
//                                     child: Text(Settings.language.verify)),
//                               )
//                             ],
//                           ),
//                         );
//                       }),
//                     ],
//                   )),
//             ));
//   }
// }

// class AccountType {
//   final String type;
//   final String typeID;

//   AccountType(this.type, this.typeID);
//   @override
//   String toString() => type;
// }
