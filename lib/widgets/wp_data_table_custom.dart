// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:west_irbid_mobile/models/wp_model.dart';
// import 'package:west_irbid_mobile/modules/work%20_perm_license/controller/work_perm_controller.dart';
// import 'package:west_irbid_mobile/modules/work%20_perm_license/views/work_perm_view.dart';

// class WPDataTableCustom extends StatelessWidget {
//   WPDataTableCustom({super.key, required this.searchLicence});
//   List<WPModel> searchLicence;
//   List<WPModel>? _searchLicenceInternal;

//   @override
//   Widget build(BuildContext context) {
//     _searchLicenceInternal = searchLicence;
//     return SingleChildScrollView(
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Row(),
//           DataTable(
//             showBottomBorder: true,
//             border: TableBorder.all(width: 1),
//             columns: [
//               DataColumn(
//                 label: SizedBox(
//                   width: Get.width * 0.04,
//                   child: headingText('رقم'),
//                 ),
//               ),
//               DataColumn(
//                 label: SizedBox(
//                   width: Get.width * 0.1,
//                   child: headingText('رقم/رقم تسلسلي'),
//                 ),
//               ),
//               DataColumn(
//                 label: SizedBox(
//                   width: Get.width * 0.1,
//                   child: headingText('إسم المشترك'),
//                 ),
//               ),
//               DataColumn(
//                 label: SizedBox(
//                   width: Get.width * 0.1,
//                   child: headingText('منطقة/حوض'),
//                 ),
//               ),
//               DataColumn(
//                 label: SizedBox(
//                   width: Get.width * 0.1,
//                   child: headingText('رقم القطعة'),
//                 ),
//               ),
//               DataColumn(
//                 label: SizedBox(
//                   width: Get.width * 0.1,
//                   child: headingText('رقم القرار/رقم الوارد'),
//                 ),
//               ),
//               DataColumn(
//                 label: Icon(Icons.remove_red_eye_sharp, color: Colors.amber),
//               ),
//               DataColumn(label: Icon(Icons.edit, color: Colors.green)),
//               DataColumn(label: Icon(Icons.delete, color: Colors.red)),
//             ],
//             rows: (_searchLicenceInternal ?? [])
//                 .map(
//                   (e1) => DataRow(
//                     cells: [
//                       DataCell(rowText('${e1.id}')),
//                       DataCell(rowText('${e1.WPNumber}/${e1.WPserialNumber}')),
//                       DataCell(rowText('${e1.licenceOwnerName}')),
//                       DataCell(
//                         rowText(
//                           '${e1.licenceCity}/${e1.licenceBuildDetailsHoodh}',
//                         ),
//                       ),
//                       DataCell(rowText('${e1.licenceBuildDetailsLandNumber}')),
//                       DataCell(
//                         rowText(
//                           '${e1.licenceDecisionNumber}/${e1.licenceIncomingNumber}',
//                         ),
//                       ),
//                       DataCell(
//                         IconButton(
//                           icon: Icon(Icons.remove_red_eye),
//                           onPressed: () {
//                             Get.put(WorkPermController());
//                             Get.to(
//                               () => WorkPermView(isNew: false, wpItem: e1),
//                             );
//                           },
//                         ),
//                       ),
//                       DataCell(
//                         IconButton(icon: Icon(Icons.edit), onPressed: () {}),
//                       ),
//                       DataCell(
//                         IconButton(icon: Icon(Icons.delete), onPressed: () {}),
//                       ),
//                     ],
//                   ),
//                 )
//                 .toList(),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget headingText(String text) {
//     return FittedBox(
//       fit: BoxFit.scaleDown,
//       child: Text(
//         text,
//         style: Get.textTheme.bodyLarge?.copyWith(
//           color: Colors.deepPurple,
//           fontWeight: FontWeight.w800,
//         ),
//       ),
//     );
//   }

//   Widget rowText(String text) {
//     return FittedBox(
//       fit: BoxFit.scaleDown,
//       child: Text(
//         text,
//         style: Get.textTheme.bodyLarge?.copyWith(
//           color: Colors.black,
//           fontWeight: FontWeight.w400,
//         ),
//       ),
//     );
//   }
// }
