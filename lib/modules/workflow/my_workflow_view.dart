import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:west_irbid_mobile/modules/workflow/workflow_controller.dart';
import 'package:west_irbid_mobile/services_utils/ui_helpers.dart';
import 'package:west_irbid_mobile/widgets/diwan_list_item.dart';
import 'package:west_irbid_mobile/widgets_cc/no_items_widget.dart';

class MyWorkflowView extends StatelessWidget {
  const MyWorkflowView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WorkflowController>(
      builder: (controller) => Column(
        children: [
          Container(
            color: Colors.white,
            child: TabBar(
              controller: controller.tabController,
              labelColor: Get.theme.primaryColor,
              unselectedLabelColor: Colors.grey,
              indicatorColor: Get.theme.primaryColor,
              tabs: [
                _buildTab(
                  'myInbox'.tr,
                  (controller.myWFList ?? []).length,
                  Colors.blue,
                  () async {
                    startLoading(context, willPop: true);
                    await controller.refreshMyListsData();
                    pop(context);
                  },
                ),
                _buildTab(
                  'requireAction'.tr,
                  (controller.mainMyWFDiwanTranseerToMyList ?? []).length,
                  Colors.amber,
                  () async {
                    startLoading(context, willPop: true);
                    await controller.refreshMyWFProceduresData();
                    pop(context);
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              controller: controller.tabController,
              children: [
                _buildWorkflowList(controller.myWFList),
                _buildWorkflowList(
                  controller.mainMyWFDiwanTranseerToMyList,
                  withTracking: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTab(
    String label,
    int count,
    Color badgeColor,
    VoidCallback onRefresh,
  ) {
    return Tab(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FittedBox(child: Text(label)),
          if (count > 0) ...[
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: badgeColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                count.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
          IconButton(
            constraints: const BoxConstraints(),
            padding: const EdgeInsets.only(right: 4),
            icon: const Icon(Icons.refresh, size: 16),
            onPressed: onRefresh,
          ),
        ],
      ),
    );
  }

  Widget _buildWorkflowList(List? list, {bool withTracking = false}) {
    if (list == null || list.isEmpty) {
      return NoItemsWidget(text: 'noDataAvailable'.tr);
    }
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: list.length,
      itemBuilder: (ctx, ind) {
        return DiwanCardItem(
          diwanObj: list[ind],
          ind: ind + 1,
          // withTracking: withTracking,
          // returnAction: () async {
          //   Get.find<WorkflowController>().refreshMyWFProceduresData();
          // },
        );
      },
    );
  }
}
