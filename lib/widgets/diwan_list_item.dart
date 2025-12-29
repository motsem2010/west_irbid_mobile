// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:west_irbid_mobile/models/diwan.dart';
// import 'package:west_irbid_mobile/models/result_object.dart';
// import 'package:west_irbid_mobile/modules/diwan_details/bindings/diwan_details_bindings.dart';
// import 'package:west_irbid_mobile/modules/diwan_details/controller/diwan_details_controller.dart';
// import 'package:west_irbid_mobile/modules/diwan_details/view/diwan_details_view.dart';
// import 'package:west_irbid_mobile/services_utils/helper_methods.dart';
// import 'package:west_irbid_mobile/services_utils/supa_api.dart';
// import 'package:west_irbid_mobile/services_utils/ui_helpers.dart';

// class DiwanCardItem extends StatelessWidget {
//   DiwanCardItem({super.key, required this.diwanObj, required this.ind});
//   Diwan diwanObj;
//   int ind;

//   @override
//   Widget build(BuildContext context) {
//     int x = diwanObj.diwan_priority ?? 0;
//     return Card(
//       color: diwanObj.isDeleted == true ? Colors.red[100] : Colors.white,
//       // elevation: ,
//       child: ListTile(
//         isThreeLine: true,
//         leading: Chip(
//           label: Text(
//             '${ind.toString()}- ${diwanObj.id} - ${diwanObj.city.toString()}',
//           ),
//         ),

//         title: Row(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Expanded(
//               flex: 3,
//               child: FittedBox(
//                 fit: BoxFit.scaleDown,
//                 child: Text(
//                   'subject'.tr + ': ' + diwanObj.subject.toString(),
//                   textAlign: TextAlign.start,
//                   style: Get.theme.textTheme.headlineMedium,
//                 ),
//               ),
//             ),
//             Expanded(
//               flex: 3,
//               child: FittedBox(
//                 fit: BoxFit.scaleDown,
//                 child: Text(
//                   // ' ',
//                   diwanObj.createdAt.toString(),
//                   textAlign: TextAlign.start,

//                   style: Get.theme.textTheme.bodyMedium!.copyWith(
//                     color: Colors.red,
//                   ),
//                 ),
//               ),
//             ),
//             Expanded(
//               flex: 1,
//               child: Text(
//                 'من: ${diwanObj.from.toString()}',
//                 overflow: TextOverflow.fade,
//                 style: Get.theme.textTheme.bodyMedium!.copyWith(
//                   color: Colors.blue,
//                 ),
//               ),
//             ),
//             Expanded(
//               flex: 1,
//               child: Text(
//                 'الى: ${diwanObj.to.toString()}',
//                 overflow: TextOverflow.fade,
//                 style: Get.theme.textTheme.bodyMedium!.copyWith(
//                   color: Colors.blue,
//                 ),
//               ),
//             ),
//           ],
//         ),

//         // Icon(
//         //   Icons.policy_outlined,
//         //   color: Colors.green,
//         // ).paddingSymmetric(horizontal: 50),
//         subtitle: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   '',
//                   // style: Get.theme.textTheme.headlineMedium,
//                 ),
//                 if (diwanObj.overallNumber != null)
//                   Text(
//                     diwanObj.overallNumber.toString(),
//                     // p0.complaintsList![ind].active == true
//                     //     ? 'Active'
//                     //     : 'Hold',
//                     style: Get.textTheme.bodySmall,
//                   ),
//                 Text(
//                   // '',
//                   'الاولويه:' +
//                       (x == 0
//                           ? 'متدنيه'
//                           : x == 1
//                           ? 'عاديه'
//                           : 'مرتفعه'),
//                   // p0.complaintsList![ind].comp_procedure.toString(),
//                   // p0.complaintsList![ind].active == true
//                   //     ? 'Active'
//                   //     : 'Hold',
//                   style: TextStyle(
//                     color:
//                         //  p0.userRoles![ind].active == true
//                         //     ? Colors.green
//                         //     :
//                         x == 0
//                         ? Colors.grey
//                         : x == 1
//                         ? Colors.green
//                         : Colors.red,
//                   ),
//                 ),
//                 Text(
//                   'بحاجه إجراء:  ' +
//                       '${diwanObj.diwan_action == true ? 'نعم' : 'لا'}',
//                   // p0.complaintsList![ind].active == true
//                   //     ? 'Active'
//                   //     : 'Hold',
//                   style: Get.textTheme.bodySmall,
//                 ),
//                 Text(
//                   "مدخل: ${diwanObj.from_name_user.toString()}",
//                   // p0.complaintsList![ind].active == true
//                   //     ? 'Active'
//                   //     : 'Hold',
//                   style: Get.textTheme.bodySmall,
//                 ),
//                 Container(
//                   color: diwanObj.processed_by_diwan != true
//                       ? Colors.red
//                       : Colors.transparent,
//                   padding: EdgeInsets.all(5),
//                   child: diwanObj.processed_by_diwan != true
//                       ? Text(
//                           'لم يتم عمل الديوان عليها',
//                           // p0.complaintsList![ind].active == true
//                           //     ? 'Active'
//                           //     : 'Hold',
//                           style: Get.textTheme.bodySmall?.copyWith(
//                             color: Colors.white,
//                           ),
//                         )
//                       : Text(
//                           'تحويل: ${diwanObj.copy_to_names ?? '[]'.toString()}',
//                           // p0.complaintsList![ind].active == true
//                           //     ? 'Active'
//                           //     : 'Hold',
//                           style: Get.textTheme.bodySmall,
//                         ),
//                 ),
//                 Text(
//                   diwanObj.byEmail.toString(),
//                   // p0.complaintsList![ind].active == true
//                   //     ? 'Active'
//                   //     : 'Hold',
//                   style: Get.textTheme.bodySmall,
//                 ),
//               ],
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 // Expanded(
//                 //     flex: 2,
//                 //     child: Text(
//                 //       p0.diwanList![ind].diwanFromTo.toString(),
//                 //       overflow: TextOverflow.ellipsis,
//                 //       // p0.complaintsList![ind].active == true
//                 //       //     ? 'Active'
//                 //       //     : 'Hold',
//                 //       style: Get.textTheme.bodySmall
//                 //           ?.copyWith(color: Colors.blue),
//                 //     )),
//                 Expanded(
//                   flex: 2,
//                   child: Text(
//                     diwanObj.summary.toString(),
//                     overflow: TextOverflow.ellipsis,
//                     // p0.complaintsList![ind].active == true
//                     //     ? 'Active'
//                     //     : 'Hold',
//                     style: Get.textTheme.bodySmall?.copyWith(
//                       color: Color.fromARGB(255, 6, 6, 254),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//         trailing: Row(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             if (diwanObj.is_updated == true)
//               Tooltip(
//                 message: 'Updted by ${diwanObj.updated_by}',
//                 child: Icon(
//                   Icons.edit,
//                   color: Color.fromARGB(255, 65, 104, 244),
//                 ),
//               ),
//             IconButton(
//               icon: Icon(
//                 Icons.attach_file_outlined,
//                 color:
//                     ((diwanObj.attachment ?? '').isNotEmpty &&
//                         diwanObj.attachment != 'error')
//                     ? Colors.amber
//                     : diwanObj.attachment == 'error'
//                     ? Colors.red
//                     : Colors.grey,
//               ),
//               onPressed: () async {
//                 if (diwanObj.supaSignedUrl != null) {
//                   HelperMethods.lanch_attachment(diwanObj.supaSignedUrl ?? '');
//                   return;
//                 }
//                 if (diwanObj.supaSignedUrl == null &&
//                     diwanObj.attachment != null &&
//                     diwanObj.attachment != 'error') {
//                   startLoading(context, willPop: true);

//                   diwanObj.supaSignedUrl = await SupaApi.getPublicUrl(
//                     diwanObj.attachment ?? "",
//                   );
//                   debugPrint(diwanObj.supaSignedUrl);
//                   pop(context);
//                   if (diwanObj.supaSignedUrl != null)
//                     HelperMethods.lanch_attachment(
//                       diwanObj.supaSignedUrl ?? '',
//                     );
//                 }
//               },
//             ),
//             SizedBox(width: 20),
//             if (diwanObj.isDeleted == true)
//               Icon(Icons.delete, color: Colors.red),
//             IconButton(
//               icon: Icon(Icons.remove_red_eye, color: Colors.grey),
//               onPressed: () async {
//                 // p0.selectedIndex = 1;
//                 // p0.update();
//                 if (diwanObj.diwan_id == null) {
//                   HelperMethods.dialogView(
//                     context: context,
//                     type: 2,
//                     message: 'youContViewWithoutDiwanProcessing'.tr,
//                   );

//                   return;
//                 }

//                 await Get.put(DiwanDetailsController());
//                 ResultObject? _result = await Get.to(
//                   DiwanDetailsView(
//                     diwanObj: null,
//                     diwan_id: diwanObj.diwan_id,
//                     diwan_action: diwanObj.diwan_action ?? false,
//                   ),
//                   // binding: DiwanDetailsaBinding()
//                 );
//                 //  if (_result == null) return;
//                 //                         if (_result.actionName == 'delete' &&
//                 //                             _result.actionId != null &&
//                 //                             _result.isDone == true) {
//                 //                           p0.diwanList?.removeWhere((element) =>
//                 //                               element.id == _result.actionId);
//                 //                           p0.update();
//                 //                         }
//                 //                         if (_result.actionName == 'update' &&
//                 //                             _result.actionId != null &&
//                 //                             _result.isDone == true) {
//                 //                           p0.diwanList?[index] =
//                 //                               _result.returnObject;
//                 //                           p0.update();
//                 //                         }
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
