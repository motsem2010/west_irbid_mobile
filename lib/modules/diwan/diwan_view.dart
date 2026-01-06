import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:west_irbid_mobile/models/diwan.dart';
import 'package:west_irbid_mobile/models/diwan_classes.dart';
import 'package:west_irbid_mobile/modules/diwan/diwan_controller.dart';
import 'package:west_irbid_mobile/services_utils/constants.dart';
import 'package:west_irbid_mobile/services_utils/helper_methods.dart';
import 'package:west_irbid_mobile/widgets/custom_text_field.dart';
import 'package:west_irbid_mobile/widgets_cc/custom_drop_down_list.dart';
import 'package:west_irbid_mobile/widgets_cc/main_button.dart';

class DiwanView extends StatelessWidget {
  const DiwanView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DiwanController>(
      init: DiwanController(),
      builder: (p0) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            backgroundColor: const Color(0xFFF5F5F5),
            appBar: AppBar(
              backgroundColor: ConstantsData.primaryClr,
              elevation: 0,
              title: const Text(
                'إدارة الديوان',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontFamily: 'janna',
                ),
              ),
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              controller: p0.scrollController,
              child: Column(
                children: [
                  // Filters Section
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        // Row 1: Classification & Serial Number
                        Row(
                          children: [
                            Expanded(
                              child: CustomDropDownList(
                                title: 'diwanClassification'.tr,
                                textController:
                                    p0.diwanClassificationFilterController,
                                list: ConstantsData.diwanCLassesList,
                                disableSubmit: false,
                                prefixIcon: Icons.hotel_class_sharp,
                                disableSearch: false,
                                onChange: (DiwanClass? val) {
                                  if (val == null) {
                                    p0.selectedDiwanClassFilter = null;
                                    p0
                                            .diwanClassificationFilterController
                                            .text =
                                        '';
                                    return;
                                  }
                                  Get.log('diwanClassification=\$val');
                                  p0.selectedDiwanClassFilter = val;
                                },
                              ).paddingSymmetric(horizontal: 5, vertical: 8),
                            ),
                            Expanded(
                              child: CustomTextField(
                                textFieldController:
                                    p0.serialNumberFilterController,
                                onChange: (val) {},
                                textInputType: TextInputType.number,
                                title: 'serialNumber'.tr,
                                hint: 'Enter'.tr + ' ' + 'serialNumber'.tr,
                                InputFormatter:
                                    ConstantsData.numberInputFormatter,
                                maxLength: 4,
                              ).paddingSymmetric(horizontal: 5, vertical: 8),
                            ),
                          ],
                        ),

                        // Row 2: ID & Trasol
                        Row(
                          children: [
                            Expanded(
                              child: CustomTextField(
                                textFieldController: p0.idFilterController,
                                onChange: (val) {},
                                textInputType: TextInputType.number,
                                title: 'Id'.tr,
                                hint: 'Enter'.tr + ' ' + 'ID'.tr,
                                InputFormatter:
                                    ConstantsData.numberInputFormatter,
                                maxLength: 5,
                              ).paddingSymmetric(horizontal: 5, vertical: 8),
                            ),
                            Expanded(
                              child: CustomTextField(
                                textFieldController: p0.trasolFilterController,
                                title: 'trasol'.tr,
                                hint: 'Enter'.tr + ' ' + 'trasol'.tr,
                                maxLength: 15,
                                textInputType: TextInputType.text,
                                leading: const Icon(
                                  Icons.nine_mp_outlined,
                                  color: Colors.blue,
                                ),
                              ).paddingSymmetric(horizontal: 5, vertical: 8),
                            ),
                          ],
                        ),

                        // Row 3: Department & Source From/To
                        Row(
                          children: [
                            Expanded(
                              child: CustomDropDownList(
                                title: 'department'.tr,
                                textController:
                                    p0.filterDepartmentNameController,
                                list: ConstantsData.departments,
                                prefixIcon: Icons.twenty_one_mp,
                                disableSearch: true,
                                onChange: (val) {},
                              ).paddingSymmetric(horizontal: 5, vertical: 8),
                            ),
                            Expanded(
                              child: CustomTextField(
                                textFieldController:
                                    p0.diwanSourceFromToFilterController,
                                textInputType: TextInputType.name,
                                title: 'sourceFromTo'.tr,
                                hint: 'Enter'.tr + ' ' + 'name'.tr,
                                maxLength: 70,
                                codeKey: GestureDetector(
                                  onTap: () async {
                                    await p0.loadDiwanWithSourceFilter(context);
                                  },
                                  child: const Icon(Icons.search),
                                ),
                                leading: const Icon(
                                  Icons.business_outlined,
                                  color: Colors.green,
                                ),
                              ).paddingSymmetric(horizontal: 5, vertical: 8),
                            ),
                          ],
                        ),

                        // Row 4: Summary (full width)
                        CustomTextField(
                          textFieldController: p0.summaryFilterController,
                          title: 'summary'.tr,
                          hint: 'Enter'.tr + ' ' + 'summary'.tr,
                          maxLength: 300,
                          maxLine: 1,
                          textInputType: TextInputType.multiline,
                          codeKey: GestureDetector(
                            onTap: () async {
                              await p0.loadDiwanWithSummaryFilter(context);
                            },
                            child: const Icon(Icons.search),
                          ),
                          leading: const Icon(
                            Icons.summarize,
                            color: Colors.greenAccent,
                          ),
                        ).paddingSymmetric(horizontal: 10, vertical: 8),
                      ],
                    ),
                  ),

                  // Action Buttons Section
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.grey.shade300,
                          width: 1,
                        ),
                      ),
                    ),
                    child: Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: [
                        MainButton(
                          width: Get.width * 0.22,
                          color: Colors.green,
                          prefex: const Icon(
                            Icons.download,
                            color: Colors.white,
                          ),
                          onPressed: () async {
                            p0.clearPagingData();
                            await p0.loadDiwanData(context);
                          },
                          text: 'getAllDiwan'.tr,
                        ),
                        MainButton(
                          prefex: const Icon(Icons.clear_all_outlined),
                          textColor: Colors.red,
                          color: Colors.green.shade400,
                          onPressed: () {
                            p0.clearAllFilters();
                          },
                          text: 'clearAllFIlters'.tr,
                          width: Get.width * 0.22,
                        ),
                        MainButton(
                          width: Get.width * 0.22,
                          color: Colors.green.shade300,
                          prefex: const Icon(
                            Icons.table_chart_outlined,
                            color: Colors.white,
                          ),
                          textColor: Colors.yellowAccent,
                          onPressed: () async {
                            HelperMethods.dialogView(
                              context: context,
                              type: 2,
                              content: StatefulBuilder(
                                builder: (context, dialogState) {
                                  return Form(
                                    key: p0.formExportKey,
                                    child: Material(
                                      child: ListView(
                                        shrinkWrap: true,
                                        children: [
                                          CustomTextField(
                                            textFieldController:
                                                p0.fileNameController,
                                            textInputType: TextInputType.text,
                                            title: 'fileName'.tr,
                                            hint:
                                                'Enter'.tr +
                                                ' ' +
                                                'fileName'.tr,
                                            maxLength: 30,
                                            validator: (val0) {
                                              if (val0 == null || val0 == '') {
                                                return 'This Field is required'
                                                    .tr;
                                              }
                                              if (val0.endsWith('.xlsx') ||
                                                  val0.endsWith('.xls') ||
                                                  val0.endsWith('.')) {
                                                return 'remove .xlsx extension'
                                                    .tr;
                                              }
                                              return null;
                                            },
                                          ).paddingSymmetric(
                                            horizontal: 10,
                                            vertical: 10,
                                          ),
                                          ElevatedButton(
                                            onPressed: () async {
                                              await p0.exportToExcel(context);
                                            },
                                            child: const Text('Export'),
                                          ).paddingSymmetric(horizontal: 50),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                          text: 'exportToExcel'.tr,
                        ),
                        MainButton(
                          width: Get.width * 0.22,
                          text: 'معاملات تصنيف null',
                          color: Colors.green.shade100,
                          textColor: Colors.green,
                          prefex: const Icon(
                            Icons.no_accounts,
                            color: Colors.green,
                          ),
                          onPressed: () async {
                            await p0.loadNullClassificationDiwan(context);
                          },
                        ),
                      ],
                    ),
                  ),

                  // Data List Section
                  p0.diwanList == null || p0.diwanList!.isEmpty
                      ? Container(
                          height: 300,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.folder_open,
                                  size: 64,
                                  color: Colors.grey.shade400,
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  'noDataAvailable'.tr,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey.shade600,
                                    fontFamily: 'janna',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: const EdgeInsets.all(16),
                          itemCount: p0.diwanList!.length,
                          itemBuilder: (context, index) {
                            Diwan diwan = p0.diwanList![index];
                            return _buildDiwanCard(diwan, index);
                          },
                        ),

                  // Load More Indicator
                  if (p0.loadMore &&
                      p0.diwanList != null &&
                      p0.diwanList!.isNotEmpty)
                    Container(
                      padding: const EdgeInsets.all(16),
                      child: const CircularProgressIndicator(),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildDiwanCard(Diwan diwan, int index) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 3,
      shadowColor: Colors.black.withOpacity(0.1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: diwan.isDeleted == true
              ? LinearGradient(
                  colors: [Colors.red[50]!, Colors.red[100]!],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : null,
          color: diwan.isDeleted != true ? Colors.white : null,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with gradient background
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    ConstantsData.primaryClr,
                    ConstantsData.primaryClr.withOpacity(0.8),
                  ],
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                ),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      // ID Badge
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.3),
                            width: 1,
                          ),
                        ),
                        child: Text(
                          '#${diwan.id}',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontFamily: 'janna',
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      // Classification Name
                      Expanded(
                        child: Text(
                          diwan.diwanClasificationName ?? 'غير محدد',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontFamily: 'janna',
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                    ],
                  ),
                  if (diwan.serialNumber != null) ...[
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.numbers,
                            size: 14,
                            color: ConstantsData.primaryClr,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'رقم متسلسل: ${diwan.serialNumber}',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: ConstantsData.primaryClr,
                              fontFamily: 'janna',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),

            // Body Content
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Details Grid
                  if (diwan.departmentName != null ||
                      diwan.diwanSourceFromTo != null)
                    Column(
                      children: [
                        if (diwan.departmentName != null)
                          _buildDetailRow(
                            icon: Icons.business_rounded,
                            label: 'القسم',
                            value: diwan.departmentName!,
                            color: const Color(0xFFF59E0B),
                          ),
                        if (diwan.diwanSourceFromTo != null)
                          _buildDetailRow(
                            icon: Icons.swap_horiz_rounded,
                            label: 'من/إلى',
                            value: diwan.diwanSourceFromTo!,
                            color: const Color(0xFF10B981),
                          ),
                      ],
                    ),

                  // Summary Section (if exists)
                  if (diwan.summary != null) ...[
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: Colors.blue.shade100,
                          width: 1,
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.description_rounded,
                            size: 18,
                            color: Colors.blue.shade700,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'الملخص',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue.shade700,
                                    fontFamily: 'janna',
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  diwan.summary!,
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.grey.shade700,
                                    height: 1.4,
                                  ),
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],

                  // Trasol Badge
                  if (diwan.trasol != null) ...[
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.purple.shade50,
                            Colors.purple.shade100,
                          ],
                        ),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: Colors.purple.shade200,
                          width: 1,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.tag_rounded,
                            size: 16,
                            color: Colors.purple.shade700,
                          ),
                          const SizedBox(width: 6),
                          Flexible(
                            child: Text(
                              'تراسل: ${diwan.trasol}',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: Colors.purple.shade700,
                                fontFamily: 'janna',
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],

                  // Footer Info
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade50,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (diwan.createdAt != null)
                          Flexible(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.calendar_today,
                                  size: 12,
                                  color: Colors.grey.shade600,
                                ),
                                const SizedBox(width: 4),
                                Flexible(
                                  child: Text(
                                    diwan.createdAt.toString().split(' ')[0],
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: Colors.grey.shade600,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        if (diwan.overallNumber != null)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              'رقم كلي: ${diwan.overallNumber}',
                              style: TextStyle(
                                fontSize: 11,
                                color: Colors.grey.shade700,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Icon(icon, size: 16, color: color),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: color,
                    fontFamily: 'janna',
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey.shade700,
                    height: 1.3,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
