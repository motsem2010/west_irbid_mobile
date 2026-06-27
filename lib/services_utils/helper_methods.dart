import 'dart:developer';
import 'dart:io';

import 'package:cool_alert/cool_alert.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:west_irbid_mobile/models/attachment_model.dart';
import 'package:west_irbid_mobile/models/licensed_model.dart';
import 'package:west_irbid_mobile/models/roles_model.dart';
import 'package:west_irbid_mobile/models/wp_model.dart';
import 'package:west_irbid_mobile/services_utils/constants.dart';
import 'package:west_irbid_mobile/services_utils/supa_api.dart';
import 'package:west_irbid_mobile/services_utils/ui_helpers.dart';

class HelperMethods {
  static String? getPmAmTime(
    String time, {
    bool split = true,
    bool isEnglish = true,
  }) {
    var pmam = '';
    if (!time.contains('T')) return time;
    var bt = split ? time.split('T')[1] : time;
    var hour = int.tryParse(bt.split(':')[0]);
    if (hour! > 11) {
      if (isEnglish)
        pmam = ' PM';
      else
        pmam = ' م';
    } else {
      if (isEnglish)
        pmam = ' AM';
      else
        pmam = ' ص';
    }
    if (hour > 12) {
      hour -= 12;
    }

    return hour.toString() + ":" + bt.split(":")[1] + pmam;
  }

  static Future<bool> lanch_attachment(String attach) {
    return launchUrl(Uri.parse(attach), mode: LaunchMode.externalApplication);
  }

  static disableKeyboard(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }

  static Future<Attachment?> getFileAttachment(context, int? maxLeng) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'pdf', 'doc', 'png', 'jpeg', 'gif', 'tiff'],
    );

    if (result != null) {
      Get.log(
        '${result.files.single.path.toString()} with size=${result.files.single.size.toString()} ',
      );
      if (result.files.single.size / (1024 * 1000) < (maxLeng ?? 1))
        return Attachment(
          fileName: result.files.single.name,
          size: result.files.single.size / 1024,
          url: result.files.single.path,
        );
      else
        alert(
          context,
          CoolAlertType.error,
          'toLargefileOver20'.tr + ' ${maxLeng ?? 1}',
        );
      // File file = File(result.files.single.path);
    }
  }

  static Future<String?> getSingleFile(context) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      // allowedExtensions: ['jpg', 'pdf', 'doc', 'png', 'jpeg', 'gif', 'tiff'],
    );

    if (result != null) {
      Get.log(
        '${result.files.single.path.toString()} with size=${result.files.single.size.toString()} ',
      );
      if (result.files.single.size / (1024 * 10) < 100)
        return result.files.single.path;
      else
        alert(context, CoolAlertType.error, 'toLargefileOver20'.tr);
      // File file = File(result.files.single.path);
    }
  }

  static DateTime findMinDate(List<DateTime> dates) {
    if (dates.isEmpty) {
      throw Exception("The list is empty.");
    }
    return dates.reduce((a, b) => a.isBefore(b) ? a : b);
  }

  static DateTime findMaxDate(List<DateTime> dates) {
    if (dates.isEmpty) {
      throw Exception("The list is empty.");
    }
    return dates.reduce((a, b) => a.isAfter(b) ? a : b);
  }

  static Future runCommand() async {
    // Specify the command you want to execute
    final command = 'start wiaacmgr';

    try {
      ProcessResult result = await Process.run(command, [], runInShell: true);
      // result.
      if (result.exitCode == 0) {
        print('Command executed successfully');
        print('Output:');
        print(result.stdout);
        // print(result.);
      } else {
        print('Command failed with exit code ${result.exitCode}');
        print('Error:');
        print(result.stderr);
      }
    } catch (e) {
      print('Error executing command: $e');
    }
  }

  static Future runCommand2() async {
    // Specify the command you want to execute
    final command = 'start wiaacmgr';
    final outputPath = 'C:\scan_file'; // Replace with your desired path

    try {
      Directory(outputPath).createSync(recursive: true);

      ProcessResult result = await Process.run('cmd', ['/c', command]);
      // result.
      if (result.exitCode == 0) {
        print('Command executed successfully');
        print('Output:');
        print(result.stdout);
        // print(result.);
      } else {
        print('Command failed with exit code ${result.exitCode}');
        print('Error:');
        print(result.stderr);
      }
    } catch (e) {
      print('Error executing command: $e');
    }
  }

  // Create the output directory if it doesn't exist

  // Then launch the scanner interface

  static Widget coupertinoSliding(BuildContext context) {
    String groupValue = '1';
    var segmentsMap = <String, Widget>{
      '1': ElevatedButton(onPressed: () {}, child: Text('1')),
      '2': const Text('2'),
      '3': const Text('3'),
    };
    return CupertinoSlidingSegmentedControl(
      children: segmentsMap,
      onValueChanged: (value) {
        debugPrint('Selected value: $value');
        if (value != null) groupValue = value;
      },
      groupValue: groupValue,
      backgroundColor: CupertinoColors.activeBlue,
    );
  }

  static Future<Object?> dialogView({
    required BuildContext context,
    String? message,
    int type = 2,
    Widget? content,
  }) {
    //type 0 sucess , 1 error 2 info 3 warning
    return showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'MTS',
      transitionDuration: Duration(milliseconds: 200),
      transitionBuilder: (context, a1, a2, child) {
        var curve = Curves.easeInOutQuad.transform(a1.value);
        return Transform.scale(
          scale: curve,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Align(
                  heightFactor: 1.3,
                  child: CircleAvatar(
                    radius: 25,
                    backgroundColor: type == 0
                        ? Colors.green
                        : type == 1
                        ? Colors.red
                        : type == 2
                        ? Colors.blueGrey
                        : Colors.amber,
                    child: Icon(
                      type == 0
                          ? Icons.golf_course
                          : type == 1
                          ? Icons.error_outline_rounded
                          : type == 2
                          ? Icons.info_outline_rounded
                          : Icons.warning_amber_rounded,
                      color: Colors.white,
                    ),
                  ),
                ).animate(delay: Duration(milliseconds: 500)).scale(),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 50),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  // height: 300,
                  width: 500,
                  child:
                      content ??
                      Text(
                        message ?? '',
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 5,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                ),
              ],
            ),
          ),
        );
      },
      pageBuilder: (ctx, a1, a2) {
        return Container(
          child: Center(
            heightFactor: 0.4,
            widthFactor: 0.3,
            child: Text(
              message ?? '',
              style: TextStyle(color: Colors.white, fontSize: 30),
            ),
          ),
        );
      },
    );
  }

  static void showDetailsDialog(
    BuildContext context, {
    BuildLicenseModel? buildLicenceItem,
    WPModel? wpItem,
    required bool isBuildLicence,
    required String title,
  }) {
    showGeneralDialog<bool>(
      barrierDismissible: true,
      barrierLabel: title,
      transitionDuration: const Duration(milliseconds: 300),
      context: context,
      transitionBuilder: (context, a1, a2, child) {
        var curve = Curves.easeInOut.transform(a1.value);
        return Transform.scale(
          scale: curve,
          child: Dialog(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
              ),
              padding: EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Row(
                    children: [
                      SizedBox(
                        width: 200,
                        child: Text(
                          (isBuildLicence == true
                                  ? buildLicenceItem
                                        ?.licenceBuildDetailsLandNumber
                                        .toString()
                                  : wpItem?.licenceBuildDetailsLandNumber
                                        .toString()) ??
                              '',
                          style: Theme.of(
                            context,
                          ).textTheme.bodyLarge?.copyWith(),
                        ),
                      ),
                      Text(
                        (isBuildLicence == true
                                ? buildLicenceItem
                                      ?.licenceBuildDetailsLandNumber
                                      .toString()
                                : wpItem?.licenceBuildDetailsLandNumber
                                      .toString()) ??
                            '',
                        style: Theme.of(
                          context,
                        ).textTheme.bodyLarge?.copyWith(),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.0),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      backgroundColor: Colors.red,
                    ),
                    onPressed: () async {
                      if (1 == 3) {
                        pop(context);
                      } else {
                        showToast(
                          'ss',
                          // record?.$2?.toString() ?? '__',
                        );
                      }
                    },
                    // Close the dialog
                    child: Text('Ok'.tr),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      pageBuilder: (ctx, a1, a2) {
        return Container();
      },
    );
  }

  static void showMediasDialog(
    BuildContext context, {
    required String medisUrl,
    required String title,
  }) {
    showGeneralDialog<bool>(
      barrierDismissible: true,
      barrierLabel: title,
      transitionDuration: const Duration(milliseconds: 300),
      context: context,
      transitionBuilder: (context, a1, a2, child) {
        var curve = Curves.easeInOut.transform(a1.value);
        return Transform.scale(
          scale: curve,
          child: Dialog(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
              ),
              padding: EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ConstrainedBox(
                    constraints: BoxConstraints(maxHeight: Get.height * 0.8),
                    child: Image.network(medisUrl, fit: BoxFit.contain),
                  ),
                  SizedBox(height: 16.0),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      backgroundColor: Colors.blue,
                    ),
                    onPressed: () async {
                      if (1 == 3) {
                        pop(context);
                      } else {
                        pop(context);
                        // showToast(medisUrl
                        //     // record?.$2?.toString() ?? '__',
                        //     );
                      }
                    },
                    // Close the dialog
                    child: Text('Ok'.tr),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      pageBuilder: (ctx, a1, a2) {
        return Container();
      },
    );
  }

  static Future<String?> selectFolderLocation() async {
    final result = await FilePicker.platform.getDirectoryPath();
    return result;
  }

  static Future<void> get_user_roles(BuildContext context) async {
    debugPrint(SupaApi.supaUser?.email.toString());
    debugPrint(
      SupaApi.supaInstCLient.auth.currentSession?.user.email.toString() ??
          '' + ' From auth',
    );
    if (ConstantsData.rolesList.isEmpty) {
      List<RoleModel>? roles = await SupaApi.get_roles_list(context: context);
      log((roles ?? []).length.toString());
    }

    if ((ConstantsData.rolesList).isNotEmpty &&
        SupaApi.supaInstCLient.auth.currentSession?.user.email != null) {
      await SupaApi.get_roles_for_user(
        context: context,
        user_email:
            SupaApi.supaInstCLient.auth.currentSession?.user.email.toString() ??
            '',
      );
    } else {
      HelperMethods.dialogView(
        context: context,
        message: 'No roles return from server or user email is null',
        type: 1,
      );
    }
  }

  static List<String> readCSVFile(String filePath) {
    File file = File(filePath);
    List<String> lines = file.readAsLinesSync() ?? [];

    for (String line in lines) {
      List<String> values = line.split(',');
      // print(values[0] + values[2]);
    }
    return lines;
  }
}
