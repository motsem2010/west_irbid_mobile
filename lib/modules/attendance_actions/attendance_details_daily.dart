import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:west_irbid_mobile/models/check_in_out_model.dart';
import 'package:west_irbid_mobile/services_utils/translation_service.dart';
import 'package:west_irbid_mobile/widgets/appbar_with_profile.dart';
import 'package:west_irbid_mobile/widgets_cc/custom_scaffold.dart';

class AttendanceDetailsDaily extends StatelessWidget {
  final List<CheckInOutModel> checkInOutList;

  const AttendanceDetailsDaily({super.key, required this.checkInOutList});

  AttendanceTypeConfig _getConfig(String? typeStr) {
    final type = int.tryParse(typeStr ?? '');
    switch (type) {
      case 1: // Check-in
        return AttendanceTypeConfig(
          label: 'checkIn'.tr,
          icon: Icons.login_rounded,
          primaryColor: const Color(0xFF10B981), // Emerald Green
          backgroundColor: const Color(0xFFE6FDF4),
        );
      case 2: // Check-out
        return AttendanceTypeConfig(
          label: 'checkOut'.tr,
          icon: Icons.logout_rounded,
          primaryColor: const Color(0xFFEF4444), // Rose Red
          backgroundColor: const Color(0xFFFEE2E2),
        );
      case 3: // Temporary Leave
        return AttendanceTypeConfig(
          label: 'temporaryLeave'.tr,
          icon: Icons.directions_walk_rounded,
          primaryColor: const Color(0xFFF59E0B), // Amber Orange
          backgroundColor: const Color(0xFFFEF3C7),
        );
      case 4: // Return from Leave
        return AttendanceTypeConfig(
          label: 'returnFromLeave'.tr,
          icon: Icons.keyboard_return_rounded,
          primaryColor: const Color(0xFF3B82F6), // Blue
          backgroundColor: const Color(0xFFEFF6FF),
        );
      default:
        return AttendanceTypeConfig(
          label: typeStr ?? 'unknown'.tr,
          icon: Icons.fingerprint_rounded,
          primaryColor: const Color(0xFF6B7280), // Slate Grey
          backgroundColor: const Color(0xFFF3F4F6),
        );
    }
  }

  String _formatTime(DateTime? dateTime) {
    if (dateTime == null) return "";
    try {
      return DateFormat(
        'hh:mm a',
        TranslationService().isLocaleArabic() ? 'ar' : 'en',
      ).format(dateTime);
    } catch (e) {
      return "";
    }
  }

  String _formatDate(DateTime? dateTime) {
    if (dateTime == null) return "";
    try {
      return DateFormat(
        'yyyy-MM-dd',
        TranslationService().isLocaleArabic() ? 'ar' : 'en',
      ).format(dateTime);
    } catch (e) {
      return "";
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return CustomScaffold(
      appBar: AppBarAtaa(title: 'dailyAttendanceDetails'.tr),
      body: checkInOutList.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.calendar_today_outlined,
                    size: 64,
                    color: colors.onSurfaceVariant.withValues(alpha: 0.5),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'noRecordsFound'.tr,
                    style: TextStyle(
                      fontSize: 16,
                      color: colors.onSurfaceVariant,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              itemCount: checkInOutList.length,
              itemBuilder: (context, index) {
                final record = checkInOutList[index];
                final config = _getConfig(record.fingerprintType);

                return InkWell(
                  onTap: () {
                    debugPrint(record.toJson().toString());
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Card(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                        side: BorderSide(
                          color: colors.outlineVariant.withValues(alpha: 0.4),
                          width: 1,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                // Icon with colored circle background
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: config.backgroundColor,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    config.icon,
                                    color: config.primaryColor,
                                    size: 24,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                // Type and Time
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        config.label,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: colors.onSurface,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        _formatTime(record.createdAt),
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: colors.onSurfaceVariant,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                // Success / Failed Badge
                                if (record.success != null)
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: record.success == true
                                          ? const Color(0xFFE6FDF4)
                                          : const Color(0xFFFEE2E2),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      record.success == true
                                          ? 'success'.tr
                                          : 'failed'.tr,
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: record.success == true
                                            ? const Color(0xFF10B981)
                                            : const Color(0xFFEF4444),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Divider(
                              color: colors.outlineVariant.withValues(
                                alpha: 0.4,
                              ),
                              height: 1,
                            ),
                            const SizedBox(height: 12),
                            // Date & Zone Status
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Date
                                Row(
                                  children: [
                                    Icon(
                                      Icons.calendar_today_rounded,
                                      size: 14,
                                      color: colors.onSurfaceVariant,
                                    ),
                                    const SizedBox(width: 6),
                                    Text(
                                      _formatDate(record.createdAt),
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: colors.onSurfaceVariant,
                                      ),
                                    ),
                                  ],
                                ),
                                // Zone status
                                if (record.isWithinZone != null)
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: record.isWithinZone == true
                                          ? const Color(0xFFE0F2FE)
                                          : const Color(0xFFF3F4F6),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          record.isWithinZone == true
                                              ? Icons.check_circle_rounded
                                              : Icons.cancel_rounded,
                                          size: 12,
                                          color: record.isWithinZone == true
                                              ? const Color(0xFF0284C7)
                                              : const Color(0xFF6B7280),
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          record.isWithinZone == true
                                              ? 'isWithinZone'.tr
                                              : 'isOutsideZone'.tr,
                                          style: TextStyle(
                                            fontSize: 11,
                                            fontWeight: FontWeight.w600,
                                            color: record.isWithinZone == true
                                                ? const Color(0xFF0284C7)
                                                : const Color(0xFF6B7280),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                              ],
                            ),
                            // Coordinates
                            if (record.targetLat != null &&
                                record.targetLon != null) ...[
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  Icon(
                                    Icons.location_on_rounded,
                                    size: 14,
                                    color: colors.onSurfaceVariant,
                                  ),
                                  const SizedBox(width: 6),
                                  Expanded(
                                    child: Text(
                                      "${'coordinates'.tr}: ${record.targetLat!.toStringAsFixed(6)}, ${record.targetLon!.toStringAsFixed(6)}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: colors.onSurfaceVariant,
                                        fontFamily: 'monospace',
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                            // Message
                            if (record.message != null &&
                                record.message!.isNotEmpty) ...[
                              const SizedBox(height: 10),
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  color: colors.surfaceContainerHighest
                                      .withValues(alpha: 0.3),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  record.message!,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: colors.onSurfaceVariant,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}

class AttendanceTypeConfig {
  final String label;
  final IconData icon;
  final Color primaryColor;
  final Color backgroundColor;

  AttendanceTypeConfig({
    required this.label,
    required this.icon,
    required this.primaryColor,
    required this.backgroundColor,
  });
}
