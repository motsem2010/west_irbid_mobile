import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:west_irbid_mobile/models/diwan.dart';
import 'package:west_irbid_mobile/modules/diwan_details/diwan_details_controller.dart';
import 'package:west_irbid_mobile/modules/diwan_details/diwan_details_view.dart';
import 'package:west_irbid_mobile/services_utils/constants.dart';
import 'package:west_irbid_mobile/services_utils/helper_methods.dart';
import 'package:west_irbid_mobile/services_utils/supa_api.dart';
import 'package:west_irbid_mobile/services_utils/ui_helpers.dart';

class DiwanCardItem extends StatelessWidget {
  const DiwanCardItem({super.key, required this.diwanObj, required this.ind});
  final Diwan diwanObj;
  final int ind;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        if (diwanObj.diwan_id == null) {
          HelperMethods.dialogView(
            context: context,
            type: 2,
            message: 'youContViewWithoutDiwanProcessing'.tr,
          );
          return;
        }
        Get.put(DiwanDetailsController());
        await Get.to(
          () => DiwanDetailsView(
            diwanObj: null,
            diwan_id: diwanObj.diwan_id,
            diwan_action: diwanObj.diwan_action ?? false,
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.only(bottom: 16),
        elevation: 3,
        shadowColor: Colors.black.withOpacity(0.1),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: diwanObj.isDeleted == true ? Colors.red[50] : Colors.white,
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
                            '#${diwanObj.id ?? ind}',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontFamily: 'janna',
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        // Subject
                        Expanded(
                          child: Text(
                            diwanObj.subject ?? 'noSubject'.tr,
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
                        // Attachment Icon
                        if ((diwanObj.attachment ?? '').isNotEmpty &&
                            diwanObj.attachment != 'error')
                          IconButton(
                            onPressed: () async {
                              if (diwanObj.supaSignedUrl != null) {
                                HelperMethods.lanch_attachment(
                                  diwanObj.supaSignedUrl ?? '',
                                );
                                return;
                              }
                              startLoading(context, willPop: true);
                              diwanObj.supaSignedUrl =
                                  await SupaApi.getPublicUrl(
                                    diwanObj.attachment ?? "",
                                  );
                              pop(context);
                              if (diwanObj.supaSignedUrl != null) {
                                HelperMethods.lanch_attachment(
                                  diwanObj.supaSignedUrl ?? '',
                                );
                              }
                            },
                            icon: const Icon(
                              Icons.attach_file_rounded,
                              color: Colors.white,
                            ),
                            tooltip: 'viewAttachment'.tr,
                          ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Priority Badge
                        _buildPriorityBadge(),
                        // Status Badge
                        if (diwanObj.processed_by_diwan != true)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.red.shade400,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              'notProcessedYet'.tr,
                              style: const TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontFamily: 'janna',
                              ),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),

              // Body Content
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Details
                    _buildDetailRow(
                      icon: Icons.person_outline_rounded,
                      label: 'from'.tr,
                      value: diwanObj.from ?? '',
                      color: const Color(0xFFF59E0B),
                    ),
                    _buildDetailRow(
                      icon: Icons.location_city_rounded,
                      label: 'City'.tr,
                      value: diwanObj.city ?? '',
                      color: const Color(0xFF10B981),
                    ),
                    if (diwanObj.to != null)
                      _buildDetailRow(
                        icon: Icons.send_rounded,
                        label: 'to'.tr,
                        value: diwanObj.to!,
                        color: Colors.blue,
                      ),
                    if (diwanObj.copy_to_names != null &&
                        diwanObj.copy_to_names != '[]')
                      _buildDetailRow(
                        icon: Icons.copy_all_rounded,
                        label: 'copyTo'.tr,
                        value: diwanObj.copy_to_names!,
                        color: Colors.purple,
                      ),

                    // Summary Section
                    if (diwanObj.summary != null) ...[
                      const SizedBox(height: 8),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.blue.shade50,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: Colors.blue.shade100,
                            width: 1,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.description_rounded,
                                  size: 16,
                                  color: Colors.blue.shade700,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  'summary'.tr,
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue.shade700,
                                    fontFamily: 'janna',
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text(
                              diwanObj.summary!,
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
                          if (diwanObj.createdAt != null)
                            Row(
                              children: [
                                Icon(
                                  Icons.calendar_today,
                                  size: 12,
                                  color: Colors.grey.shade600,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  diwanObj.createdAt.toString().split(' ')[0],
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                              ],
                            ),
                          Row(
                            children: [
                              Icon(
                                Icons.person_search,
                                size: 12,
                                color: Colors.grey.shade600,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                diwanObj.from_name_user ?? '',
                                style: TextStyle(
                                  fontSize: 11,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ],
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
      ),
    );
  }

  Widget _buildPriorityBadge() {
    int x = diwanObj.diwan_priority ?? 0;
    Color color = x == 0
        ? Colors.grey
        : x == 1
        ? Colors.green
        : Colors.red;
    String label = x == 0
        ? 'low'.tr
        : x == 1
        ? 'normal'.tr
        : 'high'.tr;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.flag_rounded, size: 14, color: color),
          const SizedBox(width: 4),
          Text(
            '${'priority'.tr}: $label',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: color,
              fontFamily: 'janna',
            ),
          ),
        ],
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
