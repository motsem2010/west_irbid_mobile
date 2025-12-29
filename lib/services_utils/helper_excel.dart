import 'dart:io';
import 'package:excel/excel.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:west_irbid_mobile/models/complaints.dart';
import 'package:west_irbid_mobile/models/diwan.dart';
import 'package:west_irbid_mobile/models/licensed_model.dart';
import 'package:west_irbid_mobile/models/relationship_news.dart';
import 'package:west_irbid_mobile/models/statistic_model.dart';
import 'package:west_irbid_mobile/models/tandeem_model.dart';
import 'package:west_irbid_mobile/models/wp_archive_model.dart';
import 'package:west_irbid_mobile/services_utils/helper_methods.dart';
import 'package:west_irbid_mobile/services_utils/ui_helpers.dart';
import 'package:west_irbid_mobile/widgets/custom_text_field.dart';

Future<void> exportToRSnewsExcel(
  List<RelationshipNews> data,
  String path,
  String fileName,
) async {
  // Create a new Excel workbook
  final excel = Excel.createExcel();

  // Get the first sheet
  final sheet = excel['Sheet1'];

  // Add the column headers
  sheet.cell(CellIndex.indexByString('A1')).value = TextCellValue('النوع');
  sheet.cell(CellIndex.indexByString('B1')).value = TextCellValue('الجريدة');
  sheet.cell(CellIndex.indexByString('C1')).value = TextCellValue('الخبر');
  sheet.cell(CellIndex.indexByString('D1')).value = TextCellValue('الرابط');
  sheet.cell(CellIndex.indexByString('E1')).value = TextCellValue('المستخدم');
  //  sheet.cell(CellIndex.indexByString('F1')).value =
  // TextCellValue('الخبر');

  // Add the data rows
  int row = 1;
  for (RelationshipNews item in data) {
    sheet.appendRow([
      TextCellValue(item.type ?? ''),
      TextCellValue(item.jaredah ?? ''),
      TextCellValue(item.newsTitle.toString()),
      TextCellValue(item.link ?? ''),
      TextCellValue(item.addByUser ?? ''),
    ]);

    row++;
  }

  if (kIsWeb) {
    //save file to download as in web
    var fileBytes = excel.save(fileName: 'My_Excel_File_Name.xlsx');
  } else
  // Save the Excel file
  {
    final dir = Directory.current.path;
    // final filePath = 'C:/Users/LENOVO/Desktop/RMP/$fileName.xlsx';
    // final filePath = 'C:/Users/LENOVO/Desktop/RMP/r1.xlsx';
    final filePath = '$path/$fileName.xlsx';

    final fileBytes = excel.encode();
    await File(filePath).writeAsBytes(fileBytes!);

    print('Excel file saved to $filePath');
  }
}

Future<void> exportComplaintsToExcel(
  List<Complaints> data,
  String path,
  String fileName,
) async {
  // Create a new Excel workbook
  final excel = Excel.createExcel();

  // Get the first sheet
  final sheet = excel['Sheet1'];

  // Add the column headers
  sheet.cell(CellIndex.indexByString('A1')).value = TextCellValue('المستدعي');
  sheet.cell(CellIndex.indexByString('B1')).value = TextCellValue('المنطقه');
  sheet.cell(CellIndex.indexByString('C1')).value = TextCellValue('رقم القطعه');
  sheet.cell(CellIndex.indexByString('D1')).value = TextCellValue('الحوض');
  sheet.cell(CellIndex.indexByString('E1')).value = TextCellValue('نوع الشكوى');
  sheet.cell(CellIndex.indexByString('F1')).value = TextCellValue(
    'القسم المعني',
  );
  sheet.cell(CellIndex.indexByString('G1')).value = TextCellValue(
    'الاجراء المتخذ',
  );
  sheet.cell(CellIndex.indexByString('H1')).value = TextCellValue('ملاحظات');
  sheet.cell(CellIndex.indexByString('I1')).value = TextCellValue('تصنيف');
  sheet.cell(CellIndex.indexByString('J1')).value = TextCellValue('سنه');

  // Add the data rows
  int row = 1;
  for (Complaints item in data) {
    int col = 0;

    sheet.appendRow([
      TextCellValue(item.comp_person_name ?? ''),
      TextCellValue(item.comp_area ?? ''),
      TextCellValue(item.comp_land_number ?? ''),
      TextCellValue(item.comp_land_hood ?? ''),
      TextCellValue(item.comp_type ?? ''),
      TextCellValue(item.comp_section_department ?? ''),
      TextCellValue(item.comp_procedure ?? ''),
      TextCellValue(item.comp_notes ?? ''),
      TextCellValue(item.comp_classification_type ?? ''),
      TextCellValue(item.comp_year ?? ''),
    ]);

    row++;
  }

  if (kIsWeb) {
    //save file to download as in web
    var fileBytes = excel.save(fileName: 'My_Excel_File_Name.xlsx');
  } else
  // Save the Excel file
  {
    final dir = Directory.current.path;
    // final filePath = 'C:/Users/LENOVO/Desktop/RMP/$fileName.xlsx';
    // final filePath = 'C:/Users/LENOVO/Desktop/RMP/r1.xlsx';
    final filePath = '$path/$fileName.xlsx';

    final fileBytes = excel.encode();
    await File(filePath).writeAsBytes(fileBytes!);

    print('Excel file saved to $filePath');
  }
}

Future<void> exportDiwanToExcel(
  List<Diwan> data,
  String path,
  String fileName,
) async {
  // Create a new Excel workbook
  final excel = Excel.createExcel();

  // Get the first sheet
  final sheet = excel['Sheet1'];

  // Add the column headers
  sheet.cell(CellIndex.indexByString('A1')).value = TextCellValue('صادر-وارد');
  sheet.cell(CellIndex.indexByString('B1')).value = TextCellValue(
    'رقم المعاملة',
  );
  sheet.cell(CellIndex.indexByString('C1')).value = TextCellValue(
    'تاريخ المعاملة',
  );
  sheet.cell(CellIndex.indexByString('D1')).value = TextCellValue('المصدر');
  sheet.cell(CellIndex.indexByString('E1')).value = TextCellValue('اسم الجهه');
  sheet.cell(CellIndex.indexByString('F1')).value = TextCellValue(
    'القسم المعني',
  );
  sheet.cell(CellIndex.indexByString('G1')).value = TextCellValue(
    'تاريخ الورود',
  );
  sheet.cell(CellIndex.indexByString('H1')).value = TextCellValue(
    'تصنيف المنطقة',
  );
  sheet.cell(CellIndex.indexByString('I1')).value = TextCellValue('الخلاصة');
  sheet.cell(CellIndex.indexByString('J1')).value = TextCellValue('تراسل');

  // Add the data rows
  int row = 1;
  for (Diwan item in data) {
    int col = 0;

    sheet.appendRow([
      TextCellValue(item.diwanType ?? ''),
      TextCellValue(item.overallNumber ?? ''),
      TextCellValue(item.dateOfIssue ?? ''),
      TextCellValue(item.diwanFromTo ?? ''),
      TextCellValue(item.diwanSourceFromTo ?? ''),
      TextCellValue(item.departmentName ?? ''),
      TextCellValue(item.dateOfRecived ?? ''),
      TextCellValue(item.regionClassification ?? ''),
      TextCellValue(item.summary ?? ''),
      TextCellValue(item.trasol ?? ''),
    ]);

    row++;
  }

  if (kIsWeb) {
    //save file to download as in web
    var fileBytes = excel.save(fileName: 'My_Excel_File_Name.xlsx');
  } else
  // Save the Excel file
  {
    final dir = Directory.current.path;
    // final filePath = 'C:/Users/LENOVO/Desktop/RMP/$fileName.xlsx';
    // final filePath = 'C:/Users/LENOVO/Desktop/RMP/r1.xlsx';
    final filePath = '$path/$fileName.xlsx';

    final fileBytes = excel.encode();
    await File(filePath).writeAsBytes(fileBytes!);

    print('Excel file saved to $filePath');
  }
}

Future<void> exportBuildsLicenceArchivesToExcel(
  List<BuildLicenseModel> data,
  String path,
  String fileName,
) async {
  // Create a new Excel workbook
  final excel = Excel.createExcel();

  // Get the first sheet
  final sheet = excel['Sheet1'];

  // Add the column headers
  sheet.cell(CellIndex.indexByString('A1')).value = TextCellValue('رقم الرخصه');
  sheet.cell(CellIndex.indexByString('B1')).value = TextCellValue(
    'تاريخ الرخصه',
  );
  sheet.cell(CellIndex.indexByString('C1')).value = TextCellValue('المنطقه');
  sheet.cell(CellIndex.indexByString('D1')).value = TextCellValue('اسم المالك');
  sheet.cell(CellIndex.indexByString('E1')).value = TextCellValue('رقم القطعه');
  sheet.cell(CellIndex.indexByString('F1')).value = TextCellValue(
    'رقم سند التسجيل',
  );
  sheet.cell(CellIndex.indexByString('G1')).value = TextCellValue('الحوض');
  // sheet.cell(CellIndex.indexByString('H1')).value =
  //     TextCellValue('تصنيف المنطقة');
  // sheet.cell(CellIndex.indexByString('I1')).value = TextCellValue('الخلاصة');
  // sheet.cell(CellIndex.indexByString('J1')).value = TextCellValue('تراسل');

  // Add the data rows
  int row = 1;
  for (BuildLicenseModel item in data) {
    int col = 0;

    sheet.appendRow([
      TextCellValue(item.licenceNumber ?? ''),
      TextCellValue(item.licenceDate ?? ''),
      TextCellValue(item.licenceCity ?? ''),
      TextCellValue(item.licenceOwnerName ?? ''),
      TextCellValue(item.licenceBuildDetailsLandNumber ?? ''),
      TextCellValue(item.qushanNumber ?? ''),
      TextCellValue(item.licenceBuildDetailsHoodh ?? ''),
      // TextCellValue(item.regionClassification ?? ''),
      // TextCellValue(item.summary ?? ''),
      // TextCellValue(item.trasol ?? ''),
    ]);

    row++;
  }

  if (kIsWeb) {
    //save file to download as in web
    var fileBytes = excel.save(fileName: 'My_Excel_File_Name.xlsx');
  } else
  // Save the Excel file
  {
    final dir = Directory.current.path;
    // final filePath = 'C:/Users/LENOVO/Desktop/RMP/$fileName.xlsx';
    // final filePath = 'C:/Users/LENOVO/Desktop/RMP/r1.xlsx';
    final filePath = '$path/$fileName.xlsx';

    final fileBytes = excel.encode();
    await File(filePath).writeAsBytes(fileBytes!);

    print('Excel file saved to $filePath');
  }
}

Future<void> exportTandeemArchivesToExcel(
  List<Tandeem> data,
  String path,
  String fileName,
) async {
  // Create a new Excel workbook
  final excel = Excel.createExcel();

  // Get the first sheet
  final sheet = excel['Sheet1'];

  // Add the column headers
  sheet.cell(CellIndex.indexByString('A1')).value = TextCellValue(
    'نوع معاملة التنظيم',
  );
  sheet.cell(CellIndex.indexByString('B1')).value = TextCellValue(
    'تاريخ معاملة التنظيم',
  );
  sheet.cell(CellIndex.indexByString('C1')).value = TextCellValue('المنطقه');
  sheet.cell(CellIndex.indexByString('D1')).value = TextCellValue(
    'اسم صاحب المعاملة',
  );
  sheet.cell(CellIndex.indexByString('E1')).value = TextCellValue('رقم القطعه');
  sheet.cell(CellIndex.indexByString('F1')).value = TextCellValue(
    'الرقم التسلسلي لملف التنظيم',
  );
  sheet.cell(CellIndex.indexByString('G1')).value = TextCellValue('الحوض');
  sheet.cell(CellIndex.indexByString('H1')).value = TextCellValue('مسند الى');
  sheet.cell(CellIndex.indexByString('I1')).value = TextCellValue('سنه');
  sheet.cell(CellIndex.indexByString('J1')).value = TextCellValue('المضمون');

  // Add the data rows
  int row = 1;
  for (Tandeem item in data) {
    int col = 0;

    sheet.appendRow([
      TextCellValue(item.tandeemType ?? ''),
      TextCellValue(item.dateOfWork ?? ''),
      TextCellValue(item.region ?? ''),
      TextCellValue(item.tandeemOwnerName ?? ''),
      TextCellValue(
        (item.landnumber.toString() +
            ',' +
            item.landnumber2.toString() +
            ',' +
            item.landnumber3.toString()),
      ),
      TextCellValue(item.serialNumberInTandeem.toString()),
      TextCellValue(item.hoodh ?? ''),
      TextCellValue(item.assignTo ?? ''),
      TextCellValue(item.year.toString()),
      TextCellValue(item.containingSubject ?? ''),
    ]);

    row++;
  }

  if (kIsWeb) {
    //save file to download as in web
    var fileBytes = excel.save(fileName: 'My_Excel_File_Name.xlsx');
  } else
  // Save the Excel file
  {
    final dir = Directory.current.path;
    // final filePath = 'C:/Users/LENOVO/Desktop/RMP/$fileName.xlsx';
    // final filePath = 'C:/Users/LENOVO/Desktop/RMP/r1.xlsx';
    final filePath = '$path/$fileName.xlsx';

    final fileBytes = excel.encode();
    await File(filePath).writeAsBytes(fileBytes!);

    print('Excel file saved to $filePath');
  }
}

Future<void> exportDiwanDailyWorkToExcel(
  List<WorkPerDay> data,
  String path,
  String fileName,
) async {
  // Create a new Excel workbook
  final excel = Excel.createExcel();

  // Get the first sheet
  final sheet = excel['Sheet1'];

  // Add the column headers
  sheet.cell(CellIndex.indexByString('A1')).value = TextCellValue('اليوم');
  sheet.cell(CellIndex.indexByString('B1')).value = TextCellValue('الموظف');
  sheet.cell(CellIndex.indexByString('C1')).value = TextCellValue(
    'عدد المعاملة',
  );
  // Add the data rows
  int row = 1;
  for (WorkPerDay item in data) {
    int col = 0;

    sheet.appendRow([
      TextCellValue(item.dateDay ?? ''),
      TextCellValue(item.email ?? ''),
      TextCellValue(item.count.toString()),
    ]);

    row++;
  }

  if (kIsWeb) {
    //save file to download as in web
    var fileBytes = excel.save(fileName: 'My_Excel_File_Name.xlsx');
  } else
  // Save the Excel file
  {
    final dir = Directory.current.path;
    // final filePath = 'C:/Users/LENOVO/Desktop/RMP/$fileName.xlsx';
    // final filePath = 'C:/Users/LENOVO/Desktop/RMP/r1.xlsx';
    final filePath = '$path/$fileName.xlsx';

    final fileBytes = excel.encode();
    await File(filePath).writeAsBytes(fileBytes!);

    print('Excel file saved to $filePath');
  }
}

final formExportKey = GlobalKey<FormState>();
final TextEditingController fileNameController = TextEditingController();
String? selectionDailyWorkFileLocation;

// ignore: unused_element
Future<void> exportDailyWorkToExcel({
  required context,
  required List<WorkPerDay> worksPerDayData,
}) async {
  HelperMethods.dialogView(
    context: context,
    type: 2,
    content: StatefulBuilder(
      builder: (context, dialogState) {
        return Form(
          key: formExportKey,
          child: Material(
            child: ListView(
              shrinkWrap: true,
              // mainAxisSize: MainAxisSize.min,
              children: [
                CustomTextField(
                  textFieldController: fileNameController,
                  textInputType: TextInputType.number,
                  title: 'fileName'.tr,
                  hint: 'Enter'.tr + ' ' + 'fileName'.tr,
                  maxLength: 30,
                  validator: (val0) {
                    if (val0 == null || val0 == '')
                      return 'This Field is required'.tr;
                    if (val0.endsWith('.xlsx') ||
                        val0.endsWith('.xls') ||
                        val0.endsWith('.'))
                      return 'remove .xlsx extension'.tr;
                  },
                ).paddingSymmetric(horizontal: 10, vertical: 10),
                ElevatedButton(
                  onPressed: () async {
                    if (formExportKey.currentState!.validate()) {
                      if ((worksPerDayData ?? []).isEmpty) {
                        pop(context);
                        HelperMethods.dialogView(
                          context: context,
                          type: 1,
                          message: 'قم باستدعاء الاعمال اليوميه اولا',
                        );
                        return;
                      }
                      selectionDailyWorkFileLocation =
                          await HelperMethods.selectFolderLocation();
                      debugPrint(selectionDailyWorkFileLocation.toString());
                      if (selectionDailyWorkFileLocation != null) {
                        selectionDailyWorkFileLocation =
                            selectionDailyWorkFileLocation!.replaceAll(
                              '\\',
                              '/',
                            );
                        exportDiwanDailyWorkToExcel(
                          worksPerDayData ?? [],
                          selectionDailyWorkFileLocation ?? '',
                          fileNameController.text,
                        );
                        pop(context);
                      }
                    }
                  },
                  child: Text('Export'),
                ).paddingSymmetric(horizontal: 50),
              ],
            ),
          ),
        );
      },
    ),
  );
}

Future<void> exportWPArchivesToExcel(
  List<WPArchive> data,
  String path,
  String fileName,
) async {
  // Create a new Excel workbook
  final excel = Excel.createExcel();

  // Get the first sheet
  final sheet = excel['Sheet1'];

  // Add the column headers
  sheet.cell(CellIndex.indexByString('A1')).value = TextCellValue(
    'رقم إذن الأشغال',
  );
  sheet.cell(CellIndex.indexByString('B1')).value = TextCellValue(
    'تاريخ إذن الأشغال',
  );
  sheet.cell(CellIndex.indexByString('C1')).value = TextCellValue('إسم المالك');
  sheet.cell(CellIndex.indexByString('D1')).value = TextCellValue('المنطقه');
  sheet.cell(CellIndex.indexByString('E1')).value = TextCellValue(
    'نوع التنظيم',
  );
  sheet.cell(CellIndex.indexByString('F1')).value = TextCellValue('رقم الفطعه');
  sheet.cell(CellIndex.indexByString('G1')).value = TextCellValue('الحوض');
  sheet.cell(CellIndex.indexByString('H1')).value = TextCellValue('رقم الوصل');
  sheet.cell(CellIndex.indexByString('I1')).value = TextCellValue(
    'تاريخ الوصل',
  );
  sheet.cell(CellIndex.indexByString('J1')).value = TextCellValue('رقم القرار');
  sheet.cell(CellIndex.indexByString('K1')).value = TextCellValue(
    'تاريخ القرار',
  );
  sheet.cell(CellIndex.indexByString('L1')).value = TextCellValue(
    'ملاحظات عامه',
  );
  // Add the data rows
  int row = 1;
  for (WPArchive item in data) {
    int col = 0;

    sheet.appendRow([
      TextCellValue(item.wpNumber ?? ''),
      TextCellValue(item.wpDate ?? ''),
      TextCellValue(item.ownerName ?? ''),
      TextCellValue(item.city ?? ''),
      TextCellValue((item.buildType ?? '')),
      TextCellValue(item.landNumber.toString()),
      TextCellValue(item.hoodh ?? ''),
      TextCellValue(item.feesReceiptNumber ?? ''),
      TextCellValue(item.receiptDate.toString()),
      TextCellValue(item.decisionNumber ?? ''),
      TextCellValue(item.decisionDate ?? ''),
      TextCellValue(item.generalNotes ?? ''),
    ]);

    row++;
  }

  if (kIsWeb) {
    //save file to download as in web
    var fileBytes = excel.save(fileName: 'My_Excel_File_Name.xlsx');
  } else
  // Save the Excel file
  {
    final dir = Directory.current.path;
    // final filePath = 'C:/Users/LENOVO/Desktop/RMP/$fileName.xlsx';
    // final filePath = 'C:/Users/LENOVO/Desktop/RMP/r1.xlsx';
    final filePath = '$path/$fileName.xlsx';

    final fileBytes = excel.encode();
    await File(filePath).writeAsBytes(fileBytes!);

    print('Excel file saved to $filePath');
  }
}
