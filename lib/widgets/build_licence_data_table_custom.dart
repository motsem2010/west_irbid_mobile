// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:west_irbid_mobile/models/licensed_model.dart';
// import 'package:west_irbid_mobile/modules/build_license/binding/build_license_binding.dart';
// import 'package:west_irbid_mobile/modules/build_license/controller/build_license_controller.dart';
// import 'package:west_irbid_mobile/modules/build_license/views/build_license_view.dart';
// import 'package:west_irbid_mobile/services_utils/helper_methods.dart';

// class BuildLIcenceDataTableCustom extends StatelessWidget {
//   BuildLIcenceDataTableCustom({super.key, required this.searchLicence});
//   List<BuildLicenseModel> searchLicence;
//   List<BuildLicenseModel>? _searchLicenceInternal;

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
//                   child: headingText('رقم المعاملة'),
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
//                       DataCell(rowText('${e1.licenceNumber}')),
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
//                             Get.put(BuildLicenseController());
//                             Get.to(
//                               () =>
//                                   BuildLicenseView(isNew: false, buildItem: e1),
//                             );
//                           },
//                         ),
//                       ),
//                       DataCell(
//                         IconButton(
//                           icon: Icon(Icons.edit),
//                           onPressed: () {
//                             HelperMethods.showDetailsDialog(
//                               context,
//                               isBuildLicence: true,
//                               title: e1.licenceOwnerName.toString() ?? ' ',
//                               buildLicenceItem: e1,
//                             );
//                           },
//                         ),
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
