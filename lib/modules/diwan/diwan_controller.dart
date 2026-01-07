import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:west_irbid_mobile/models/diwan.dart';
import 'package:west_irbid_mobile/models/diwan_classes.dart';
import 'package:west_irbid_mobile/services_utils/constants.dart';
import 'package:west_irbid_mobile/services_utils/supa_api.dart';
import 'package:west_irbid_mobile/services_utils/ui_helpers.dart';
import 'package:west_irbid_mobile/services_utils/helper_excel.dart';
import 'package:west_irbid_mobile/services_utils/helper_methods.dart';

class DiwanController extends GetxController {
  // Filter Controllers
  final TextEditingController diwanClassificationFilterController =
      TextEditingController();
  final TextEditingController serialNumberFilterController =
      TextEditingController();
  final TextEditingController idFilterController = TextEditingController();
  final TextEditingController trasolFilterController = TextEditingController();
  final TextEditingController filterDepartmentNameController =
      TextEditingController();
  final TextEditingController diwanSourceFromToFilterController =
      TextEditingController();
  final TextEditingController summaryFilterController = TextEditingController();
  final TextEditingController fileNameController = TextEditingController();

  // Selected Filter Variables
  DiwanClass? selectedDiwanClassFilter;

  // Pagination Variables
  int pageCurrent = 1;
  int pageSize = 50;
  bool loadMore = true;

  // Data Lists
  List<Diwan>? mainMyDiwanList = [];
  List<Diwan>? diwanList = [];

  // Form Keys
  final GlobalKey<FormState> formExportKey = GlobalKey<FormState>();

  // Export Variables
  String? selectionFileLocation;

  // Scroll Controller for Pagination
  final ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    super.onInit();
    // initailData();
    _initScrollListener();
  }

  @override
  void onReady() async {
    super.onReady();
  }

  @override
  void onClose() {
    // Dispose controllers
    diwanClassificationFilterController.dispose();
    serialNumberFilterController.dispose();
    idFilterController.dispose();
    trasolFilterController.dispose();
    filterDepartmentNameController.dispose();
    diwanSourceFromToFilterController.dispose();
    summaryFilterController.dispose();
    fileNameController.dispose();
    scrollController.dispose();
    super.onClose();
  }

  /// Initialize scroll listener for pagination
  void _initScrollListener() {
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent * 0.9) {
        if (loadMore) {
          loadDiwanData(Get.context!);
        }
      }
    });
  }

  /// Clear pagination data
  void clearPagingData() {
    pageCurrent = 1;
    loadMore = true;
    mainMyDiwanList = [];
    diwanList = [];
    update();
  }

  /// Load Diwan data with filters
  Future<void> loadDiwanData(BuildContext context) async {
    if (!loadMore) return;

    startLoading(context, willPop: true);

    Map<String, Object> query = {};

    // Build query from filters
    if (diwanClassificationFilterController.text.isNotEmpty) {
      query.addAll({
        'diwan_clasification_id': selectedDiwanClassFilter?.id as Object,
      });
    }

    if (trasolFilterController.text.isNotEmpty) {
      query.addAll({'trasol': trasolFilterController.text});
    }

    if (serialNumberFilterController.text.isNotEmpty) {
      query.addAll({'serial_number': serialNumberFilterController.text});
    }

    if (filterDepartmentNameController.text.isNotEmpty) {
      query.addAll({'department_name': filterDepartmentNameController.text});
    }

    if (idFilterController.text.isNotEmpty) {
      query.addAll({'id': idFilterController.text});
    }

    // Fetch data from Supabase
    List<Diwan>? fetchedDiwanList = await SupaApi.get_search_diwan(
      context: context,
      query: query,
      pageNumber: pageCurrent,
      pageSize: pageSize,
    );

    if (fetchedDiwanList != null && fetchedDiwanList.isNotEmpty) {
      mainMyDiwanList?.addAll(fetchedDiwanList.toList());
      diwanList = mainMyDiwanList;

      if (fetchedDiwanList.length >= pageSize) {
        loadMore = true;
        pageCurrent += 1;
      } else {
        loadMore = false;
      }
    } else {
      loadMore = false;
    }

    pop(context);
    update();
  }

  /// Load Diwan data with text search filter (for source from/to)
  Future<void> loadDiwanWithSourceFilter(BuildContext context) async {
    clearPagingData();
    startLoading(context);

    if (loadMore && diwanSourceFromToFilterController.text.isNotEmpty) {
      List<Diwan>? fetchedDiwanList =
          await SupaApi.get_search_diwan_with_filter(
            context: context,
            filterCol: 'diwan_source_from_to',
            filterValue: diwanSourceFromToFilterController.text.replaceAll(
              ' ',
              ' & ',
            ),
            pageNumber: pageCurrent,
            pageSize: pageSize,
          );

      if (fetchedDiwanList != null && fetchedDiwanList.isNotEmpty) {
        mainMyDiwanList?.addAll(fetchedDiwanList.toList());
        diwanList = mainMyDiwanList;

        if (fetchedDiwanList.length >= pageSize) {
          loadMore = true;
          pageCurrent += 1;
        } else {
          loadMore = false;
        }
      }
    }

    pop(context);
    update();
  }

  /// Load Diwan data with text search filter (for summary)
  Future<void> loadDiwanWithSummaryFilter(BuildContext context) async {
    clearPagingData();
    startLoading(context);

    if (loadMore && summaryFilterController.text.isNotEmpty) {
      List<Diwan>? fetchedDiwanList =
          await SupaApi.get_search_diwan_with_filter(
            context: context,
            filterCol: 'summary',
            filterValue: summaryFilterController.text.trim().replaceAll(
              ' ',
              ' & ',
            ),
            pageNumber: pageCurrent,
            pageSize: pageSize,
          );

      if (fetchedDiwanList != null && fetchedDiwanList.isNotEmpty) {
        mainMyDiwanList?.addAll(fetchedDiwanList.toList());
        diwanList = mainMyDiwanList;

        if (fetchedDiwanList.length >= pageSize) {
          loadMore = true;
          pageCurrent += 1;
        } else {
          loadMore = false;
        }
      }
    }

    pop(context);
    update();
  }

  /// Load Diwan records with null classification
  Future<void> loadNullClassificationDiwan(BuildContext context) async {
    clearPagingData();
    startLoading(context);

    List<Diwan>? fetchedDiwanList = await SupaApi.get_diwan_nulls(
      context: context,
      function_name: 'get_diwan_null_records',
    );

    if (fetchedDiwanList != null && fetchedDiwanList.isNotEmpty) {
      mainMyDiwanList?.addAll(fetchedDiwanList.toList());
      diwanList = mainMyDiwanList;

      if (fetchedDiwanList.length >= pageSize) {
        loadMore = true;
        pageCurrent += 1;
      } else {
        loadMore = false;
      }
    }

    pop(context);
    update();
  }

  /// Clear all filters
  void clearAllFilters() {
    diwanClassificationFilterController.text = '';
    serialNumberFilterController.text = '';
    diwanSourceFromToFilterController.text = '';
    summaryFilterController.text = '';
    idFilterController.text = '';
    trasolFilterController.text = '';
    filterDepartmentNameController.text = '';
    selectedDiwanClassFilter = null;
    clearPagingData();
    update();
  }

  /// Export diwan list to Excel
  Future<void> exportToExcel(BuildContext context) async {
    if (formExportKey.currentState!.validate()) {
      selectionFileLocation = await HelperMethods.selectFolderLocation();
      debugPrint(selectionFileLocation.toString());

      if (selectionFileLocation != null) {
        selectionFileLocation = selectionFileLocation!.replaceAll('\\', '/');
        exportDiwanToExcel(
          diwanList ?? [],
          selectionFileLocation ?? '',
          fileNameController.text,
        );
        pop(context);
      }
    }
  }

  /// Open Diwan attachment
  Future<void> openAttachment(BuildContext context, Diwan diwan) async {
    if (diwan.attachment == null ||
        diwan.attachment!.isEmpty ||
        diwan.attachment == 'error') {
      HelperMethods.dialogView(
        context: context,
        type: 3,
        message: 'noAttachmentAvailable'.tr,
      );
      return;
    }

    if (diwan.supaSignedUrl != null) {
      HelperMethods.lanch_attachment(diwan.supaSignedUrl!);
      return;
    }

    startLoading(context, willPop: true);
    try {
      String? signedUrl = await SupaApi.getPublicUrl(diwan.attachment!);
      pop(context);

      if (signedUrl != null) {
        diwan.supaSignedUrl = signedUrl;
        HelperMethods.lanch_attachment(signedUrl);
      } else {
        HelperMethods.dialogView(
          context: context,
          type: 1,
          message: 'errorOpeningAttachment'.tr,
        );
      }
    } catch (e) {
      pop(context);
      Get.log('Error opening attachment: $e');
      HelperMethods.dialogView(
        context: context,
        type: 1,
        message: 'errorOpeningAttachment'.tr,
      );
    }
  }
}
