import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:intl/intl.dart';
import 'package:west_irbid_mobile/models/check_in_out_record.dart';
import 'package:west_irbid_mobile/modules/attendance_actions/attendance_controller.dart';
import 'package:west_irbid_mobile/services_utils/constants.dart';
import 'package:west_irbid_mobile/services_utils/translation_service.dart';
import 'package:west_irbid_mobile/services_utils/ui_helpers.dart';
import 'package:west_irbid_mobile/widgets/appbar_with_profile.dart';
import 'package:west_irbid_mobile/widgets_cc/custom_scaffold.dart';

import 'location_service.dart';

class AttendanceActionsView extends GetView<AttendanceController> {
  static const String id = 'attendance_actions_view';
  //   const AttendanceActionsView({super.key});

  //   @override
  //   State<AttendanceActionsView> createState() => _AttendanceActionsViewState();
  // }

  // class _AttendanceActionsViewState extends State<AttendanceActionsView> {
  final LocationService _locationService = LocationService();

  String? loadingAction;
  DateTime currentDate = DateTime.now();

  List<EmployeeRecord> checkInOutRecords = [];
  bool isLoadingRecords = false;

  // @override
  // void initState() {
  //   super.initState();
  //   _loadRecords();
  // }

  Future<void> _loadRecords() async {
    isLoadingRecords = true;

    try {
      final record = await controller.checkOutInRecords();
      if (record != null && record.employeeRecords != null) {
        checkInOutRecords = record.employeeRecords!;
      }
    } catch (e) {
      debugPrint("Error loading attendance records: $e");
    } finally {
      isLoadingRecords = false;
    }
  }
  // }

  List<Map<String, dynamic>> getActions(BuildContext context) {
    return [
      {
        "fingerprintType": "1",
        "id": "check_in",
        "title": 'checkIn',
        "description": 'checkInDesc',
        "icon": Icons.login,
      },
      {
        "fingerprintType": "2",
        "id": "check_out",
        "title": 'checkOut',
        "description": 'checkOutDesc',
        "icon": Icons.logout,
      },
      {
        "fingerprintType": "3",
        "id": "temporary_leave",
        "title": 'temporaryLeave',
        "description": 'tempLeaveDesc',
        "icon": Icons.exit_to_app,
      },
      {
        "fingerprintType": "4",
        "id": "return",
        "title": 'returnFromLeave',
        "description": 'returnDesc',
        "icon": Icons.keyboard_return,
      },
    ];
  }

  String getFingerprintTypeName(int? type) {
    switch (type) {
      case 1:
        return 'checkIn';
      case 2:
        return 'checkOut';
      case 3:
        return 'temporaryLeave';
      case 4:
        return 'returnFromLeave';
      default:
        return "";
    }
  }

  Future<void> executeAttendanceAction(Map<String, dynamic> action) async {
    if (loadingAction != null) return;

    loadingAction = action["id"];

    try {
      Position? position = await _locationService.getCurrentLocation();

      if (position == null) {
        throw Exception("Unable to get location");
      }

      final request = {
        "employeeID": ConstantsData.currentUser?.id,
        // "employeeID": "70",
        "fingerprintType": action["fingerprintType"],
        "targetLat": position.latitude,
        "targetLon": position.longitude,
      };

      debugPrint("Attendance Request: $request");

      final checkInOut = await controller.checkOutInByLocation(request);
      if ((checkInOut == null || checkInOut.isWithinZone == false)) {
        return coolAlert(
          context: Get.context!,
          type: CoolAlertType.warning,
          confirmText: 'ok'.tr,
          text: checkInOut?.message ?? 'somethingWentWrong'.tr,
        );
      }

      _loadRecords();

      coolAlert(
        context: Get.context!,
        type: CoolAlertType.success,
        onTap: () {
          pop(Get.context!);
          pop(Get.context!);
        },
        confirmText: 'ok'.tr,
        text: checkInOut?.message ?? 'somethingWentWrong'.tr,
      );
    } catch (e) {
      ScaffoldMessenger.of(
        Get.context!,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    } finally {
      loadingAction = null;
    }
  }
  // }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final currentActions = getActions(context);
    final args = ModalRoute.of(context)?.settings.arguments as String?;

    return CustomScaffold(
      appBar: AppBarAtaa(title: args ?? 'حضور وانصراف'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(colors),
              const SizedBox(height: 20),
              _buildStatusCard(colors),
              const SizedBox(height: 20),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: currentActions.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 1.1,
                ),
                itemBuilder: (_, index) {
                  return _buildActionCard(currentActions[index], colors);
                },
              ),
              _buildRecordsTable(colors),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(ColorScheme colors) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('today'.tr, style: TextStyle(color: colors.onSurfaceVariant)),
        const SizedBox(height: 5),
        Text(
          "${currentDate.day}/"
          "${currentDate.month}/"
          "${currentDate.year}",
          style: Theme.of(Get.context!).textTheme.titleLarge,
        ),
        Text(
          TimeOfDay.now().format(Get.context!),
          style: Theme.of(Get.context!).textTheme.bodyLarge,
        ),
      ],
    );
  }

  Widget _buildStatusCard(ColorScheme colors) {
    String statusText = 'notRegistered';
    if (checkInOutRecords.isNotEmpty) {
      statusText = getFingerprintTypeName(
        checkInOutRecords.last.fingerprintType,
      );
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(Icons.badge, color: colors.primary),
            const SizedBox(width: 12),
            Text("attendanceStatus: $statusText"),
          ],
        ),
      ),
    );
  }

  Widget _buildActionCard(Map<String, dynamic> action, ColorScheme colors) {
    final isLoading = loadingAction == action["id"];

    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: loadingAction == null
          ? () => executeAttendanceAction(action)
          : null,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              isLoading
                  ? const CircularProgressIndicator()
                  : Icon(action["icon"], size: 40, color: colors.primary),
              const SizedBox(height: 12),
              Text(
                action["title"],
                style: Theme.of(Get.context!).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              Text(
                action["description"],
                textAlign: TextAlign.center,
                style: TextStyle(color: colors.onSurfaceVariant),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRecordsTable(ColorScheme colors) {
    if (isLoadingRecords) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20),
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (checkInOutRecords.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 24),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Text(
            "attendanceRecords".tr,
            style: Theme.of(Get.context!).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: colors.primary,
            ),
          ),
        ),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            color: colors.surface,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: colors.shadow.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
            border: Border.all(
              color: colors.outlineVariant.withOpacity(0.5),
              width: 1,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Table(
              columnWidths: const {
                0: FlexColumnWidth(1),
                1: FlexColumnWidth(1),
              },
              children: [
                TableRow(
                  decoration: BoxDecoration(color: colors.primary),
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 14,
                        horizontal: 16,
                      ),
                      child: Text(
                        "time".tr,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: colors.onPrimary,
                          fontSize: 15,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 14,
                        horizontal: 16,
                      ),
                      child: Text(
                        "action".tr,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: colors.onPrimary,
                          fontSize: 15,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
                ...checkInOutRecords.asMap().entries.map((entry) {
                  final index = entry.key;
                  final record = entry.value;
                  final isEven = index % 2 == 0;

                  return TableRow(
                    decoration: BoxDecoration(
                      color: isEven
                          ? colors.surface
                          : colors.surfaceVariant.withOpacity(0.3),
                      border: Border(
                        bottom: BorderSide(
                          color: colors.outlineVariant.withOpacity(0.3),
                          width: 1,
                        ),
                      ),
                    ),
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 14,
                          horizontal: 16,
                        ),
                        child: Text(
                          formatTime(record.transactionTime ?? ''),
                          style: TextStyle(
                            color: colors.surfaceTint,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 14,
                          horizontal: 16,
                        ),
                        child: Text(
                          getFingerprintTypeName(record.fingerprintType),
                          style: TextStyle(
                            color: colors.surfaceTint,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  String formatTime(String time) {
    try {
      late DateTime dateTime;
      if (time.contains('.')) {
        // HH:mm:ss.SSSSSSS
        final timeParts = time.split('.');
        dateTime = DateFormat('HH:mm:ss').parse(timeParts.first);
      } else {
        // HH:mm:ss
        dateTime = DateFormat('HH:mm:ss').parse(time);
      }
      return DateFormat(
        'hh:mm a',
        TranslationService().isLocaleArabic() ? 'ar' : 'en',
      ).format(dateTime);
    } catch (e) {
      return time;
    }
  }
}
