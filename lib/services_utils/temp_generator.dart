import 'package:get/get.dart';
import 'package:west_irbid_mobile/models/diwan.dart';
import 'package:west_irbid_mobile/models/estemlakat.dart';
import 'package:west_irbid_mobile/models/licensed_model.dart';
import 'package:west_irbid_mobile/models/notification_data_object_model.dart';
import 'package:west_irbid_mobile/models/tandeem_model.dart';
import 'package:west_irbid_mobile/modules/login/login_view.dart';
// import 'package:west_irbid_mobile/modules/diwan/binding/diwan_binding.dart';
// import 'package:west_irbid_mobile/modules/diwan_details/bindings/diwan_details_bindings.dart';
// import 'package:west_irbid_mobile/modules/login/views/login_screen.dart';
// import 'package:west_irbid_mobile/modules/tandheem_archive/views/tandheem_view.dart';
// import 'package:west_irbid_mobile/modules/tandheem_archive/views/tandeem_my.dart';
// import 'package:west_irbid_mobile/modules/tandheem_details/bindings/tandheem_details_bindings.dart';
// import 'package:west_irbid_mobile/modules/work _perm_license/views/work_perm_view.dart';
// import 'package:west_irbid_mobile/modules/work _perm_license/views/floors_list_work_per_view.dart';
// import 'package:west_irbid_mobile/modules/estemlakat/views/estemlakat_view.dart';
// import 'package:west_irbid_mobile/modules/main_home/views/main_home_screen.dart';
// import 'package:west_irbid_mobile/modules/diwan/views/diwan_view.dart';
// import 'package:west_irbid_mobile/modules/complaints_details/view/complaints_details_view.dart';
// import 'package:west_irbid_mobile/modules/tandheem_details/view/tandheem_details_view.dart';
// import 'package:west_irbid_mobile/modules/admin_module/views/grant_roles_view.dart';
// import 'package:west_irbid_mobile/modules/admin_module/views/diwan_wf_procedures_view.dart';
// import 'package:west_irbid_mobile/modules/diwan/views/workflow_add.dart';
// import 'package:west_irbid_mobile/modules/workflow/views/wf_view.dart';
// import 'package:west_irbid_mobile/modules/admin_module/views/region_views.dart';
// import 'package:west_irbid_mobile/modules/workflow/views/wf_my_tranactions.dart';
// import 'package:west_irbid_mobile/modules/admin_module/views/users_view.dart';
// import 'package:west_irbid_mobile/modules/admin_module/views/admin_view.dart';
// import 'package:west_irbid_mobile/modules/admin_module/views/departments_view.dart';
// import 'package:west_irbid_mobile/modules/admin_module/views/system_variables.dart';
// import 'package:west_irbid_mobile/modules/admin_module/views/diwan_classes_view.dart';
// import 'package:west_irbid_mobile/modules/admin_module/views/roles_view.dart';
// import 'package:west_irbid_mobile/modules/build_license_archive/views/build_licence_view.dart';
// import 'package:west_irbid_mobile/modules/build_license_archive/views/floors_archive_list_view.dart';
// import 'package:west_irbid_mobile/modules/relationship_news/views/relationship_news_view.dart';
// import 'package:west_irbid_mobile/modules/archiving/views/archive_view.dart';
// import 'package:west_irbid_mobile/modules/build_licenced_archive_details/view/build_licenced_archive_details_view.dart';
// import 'package:west_irbid_mobile/modules/searching_services/views/search_view.dart';
// import 'package:west_irbid_mobile/modules/diwan_details/view/diwan_details_view.dart';
// import 'package:west_irbid_mobile/modules/ashghal_archive/views/floors_archive_list_view.dart';
// import 'package:west_irbid_mobile/modules/ashghal_archive/views/ashghal_view.dart';
// import 'package:west_irbid_mobile/modules/estemlakat_details/view/estemlakat_details_view.dart';
// import 'package:west_irbid_mobile/modules/complaints/views/complaints_view.dart';
// import 'package:west_irbid_mobile/modules/ashghal_archive_details/view/ashghal_archive_details_view.dart';
// import 'package:west_irbid_mobile/modules/build_license/views/floors_list_view.dart';
// import 'package:west_irbid_mobile/modules/build_license/views/build_license_view.dart';
import 'package:west_irbid_mobile/services_utils/supa_fastAPI_api.dart';

void notificationNavigationHandler(NotificationDataModel notification) async {
  final route = notification.view_route;
  // if (route != null && route.isNotEmpty) {
  //   if (route == LoginView.id) {
  //     Get.to(() => LoginView());
  //     return;
  //   }
  //   if (route == TandeemArchiveView.id) {
  //     Get.to(() => TandeemArchiveView());
  //     return;
  //   }
  //   if (route == MyTandeem.id) {
  //     Get.to(() => MyTandeem());
  //     return;
  //   }
  //   if (route == WorkPermView.id) {
  //     Get.to(() => WorkPermView(isNew: true));
  //     return;
  //   }
  //   if (route == WorkPermFloorsView.id) {
  //     Get.to(() => WorkPermFloorsView());
  //     return;
  //   }
  //   if (route == ESTView.id) {
  //     Get.to(() => ESTView());
  //     return;
  //   }
  //   if (route == MainHomeView.id) {
  //     Get.to(() => MainHomeView());
  //     return;
  //   }
  //   if (route == DiwanView.id) {
  //     Get.to(() => DiwanView());
  //     return;
  //   }
  //   // if (route == ComplaintsDetailsView.id) {
  //   //   Get.to(() => ComplaintsDetailsView());
  //   //   return;
  //   // }
  //   if (route == TandheemDetailsView.id) {
  //     List<Tandeem>? _myList = await FastAPI_Api.get_Table<Tandeem>(
  //       context: Get.context!,
  //       pageNumber: 1,
  //       pageSize: 200,
  //       table_name: 'tandeem',
  //       query: {'id': notification.action_id.toString()},
  //       // coloumList: diwan_id_copy_to_list.toSet(),
  //       // query_string: 'diwan_id in ${_idsStr}',
  //       fromJson: Tandeem.fromJson,
  //     );
  //     if ((_myList ?? []).isNotEmpty)
  //       Get.to(
  //         () => TandheemDetailsView(tandeemObj: _myList![0]),
  //         binding: TandheemDetailsaBinding(),
  //       );
  //     return;
  //   }
  //   if (route == GrantRolesView.id) {
  //     Get.to(() => GrantRolesView());
  //     return;
  //   }
  //   if (route == DiwanWFProceduresView.id) {
  //     Get.to(() => DiwanWFProceduresView());
  //     return;
  //   }
  //   if (route == WorkflowAdd.id) {
  //     List<Diwan>? _myList = await FastAPI_Api.get_Table<Diwan>(
  //       context: Get.context!,
  //       pageNumber: 1,
  //       pageSize: 200,
  //       table_name: 'workflow',
  //       query: {'id': notification.action_id.toString()},
  //       // coloumList: diwan_id_copy_to_list.toSet(),
  //       // query_string: 'diwan_id in ${_idsStr}',
  //       fromJson: Diwan.fromJson,
  //     );
  //     if ((_myList ?? []).isNotEmpty) {
  //       if (_myList![0].diwan_id == null)
  //         Get.to(
  //           () => WorkflowAdd(workflowObj: _myList![0]),
  //           binding: WFBinding(),
  //         );
  //       else {
  //         List<Diwan>? _myList2 = await FastAPI_Api.get_Table<Diwan>(
  //           context: Get.context!,
  //           pageNumber: 1,
  //           pageSize: 200,
  //           table_name: 'diwan',
  //           query: {'id': _myList![0].diwan_id.toString()},
  //           // coloumList: diwan_id_copy_to_list.toSet(),
  //           // query_string: 'diwan_id in ${_idsStr}',
  //           fromJson: Diwan.fromJson,
  //         );
  //         if ((_myList2 ?? []).isNotEmpty)
  //           Get.to(
  //             () => DiwanDetailsView(diwanObj: _myList2![0]),
  //             binding: DiwanDetailsaBinding(),
  //           );
  //       }
  //     }
  //     return;
  //   }
  //   if (route == WorkflowView.id) {
  //     Get.to(() => WorkflowView());
  //     return;
  //   }
  //   if (route == RegionsView.id) {
  //     Get.to(() => RegionsView());
  //     return;
  //   }
  //   if (route == MyWF.id) {
  //     Get.to(() => MyWF());
  //     return;
  //   }
  //   if (route == UsersView.id) {
  //     Get.to(() => UsersView());
  //     return;
  //   }
  //   if (route == AdminModuleView.id) {
  //     Get.to(() => AdminModuleView());
  //     return;
  //   }
  //   if (route == DepartmentsView.id) {
  //     Get.to(() => DepartmentsView());
  //     return;
  //   }
  //   if (route == SystemVariablesView.id) {
  //     Get.to(() => SystemVariablesView());
  //     return;
  //   }
  //   if (route == DiwanClassificationView.id) {
  //     Get.to(() => DiwanClassificationView());
  //     return;
  //   }
  //   if (route == RolesView.id) {
  //     Get.to(() => RolesView());
  //     return;
  //   }
  //   if (route == BuildArchiveView.id) {
  //     Get.to(() => BuildArchiveView());
  //     return;
  //   }
  //   // if (route == BuildLicenceFloorsArchiveView.id) {
  //   //   Get.to(() => BuildLicenceFloorsArchiveView());
  //   //   return;
  //   // }
  //   if (route == RSNewsView.id) {
  //     Get.to(() => RSNewsView());
  //     return;
  //   }
  //   if (route == ArchiveView.id) {
  //     Get.to(() => ArchiveView());
  //     return;
  //   }
  //   if (route == BuildLicenceArchiveDetailsView.id) {
  //     List<BuildLicenseModel>? _myList =
  //         await FastAPI_Api.get_Table<BuildLicenseModel>(
  //           context: Get.context!,
  //           pageNumber: 1,
  //           pageSize: 200,
  //           table_name: 'build_licencse_table',
  //           query: {'id': notification.action_id.toString()},
  //           // coloumList: diwan_id_copy_to_list.toSet(),
  //           // query_string: 'diwan_id in ${_idsStr}',
  //           fromJson: BuildLicenseModel.fromJson,
  //         );
  //     if ((_myList ?? []).isNotEmpty)
  //       Get.to(() => BuildLicenceArchiveDetailsView(BLObj: _myList![0]));
  //     return;
  //   }
  //   if (route == SearchServicesView.id) {
  //     Get.to(() => SearchServicesView());
  //     return;
  //   }
  //   if (route == DiwanDetailsView.id) {
  //     List<Diwan>? _myList = await FastAPI_Api.get_Table<Diwan>(
  //       context: Get.context!,
  //       pageNumber: 1,
  //       pageSize: 2,
  //       table_name: 'diwan',
  //       query: {'id': notification.action_id.toString()},
  //       // coloumList: diwan_id_copy_to_list.toSet(),
  //       // query_string: 'diwan_id in ${_idsStr}',
  //       fromJson: Diwan.fromJson,
  //     );
  //     if ((_myList ?? []).isNotEmpty)
  //       Get.to(
  //         () => DiwanDetailsView(diwanObj: _myList![0]),
  //         binding: DiwanDetailsaBinding(),
  //       );
  //     return;
  //   }
  //   if (route == AshghalFloorsArchiveView.id) {
  //     Get.to(() => AshghalFloorsArchiveView());
  //     return;
  //   }
  //   if (route == AshghalArchiveView.id) {
  //     Get.to(() => AshghalArchiveView());
  //     return;
  //   }
  //   if (route == ESTDetailsView.id) {
  //     List<Estemlakat>? _myList = await FastAPI_Api.get_Table<Estemlakat>(
  //       context: Get.context!,
  //       pageNumber: 1,
  //       pageSize: 200,
  //       table_name: 'estemlakat2',
  //       query: {'id': notification.action_id.toString()},
  //       // coloumList: diwan_id_copy_to_list.toSet(),
  //       // query_string: 'diwan_id in ${_idsStr}',
  //       fromJson: Estemlakat.fromJson,
  //     );
  //     if ((_myList ?? []).isNotEmpty)
  //       Get.to(() => ESTDetailsView(estObj: _myList![0]));
  //     return;
  //   }
  //   if (route == ComplaintsView.id) {
  //     Get.to(() => ComplaintsView());
  //     return;
  //   }
  //   // if (route == AshghalArchiveDetailsView.id) {
  //   //   Get.to(() => AshghalArchiveDetailsView());
  //   //   return;
  //   // }
  //   if (route == BuildLicenceFloosView.id) {
  //     Get.to(() => BuildLicenceFloosView());
  //     return;
  //   }
  //   if (route == BuildLicenseView.id) {
  //     Get.to(() => BuildLicenseView(isNew: true));
  //     return;
  //   }
  // }
}
