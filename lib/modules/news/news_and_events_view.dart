import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:west_irbid_mobile/models/event_model.dart';
import 'package:west_irbid_mobile/modules/news/event_widget.dart';
// import 'package:west_irbid_mobile/services_utils/constants.dart';
import 'package:west_irbid_mobile/services_utils/supa_api.dart';
import 'package:west_irbid_mobile/services_utils/translation_service.dart';
import 'package:west_irbid_mobile/services_utils/ui_helpers.dart';
import 'package:west_irbid_mobile/widgets_cc/custom_view_n.dart';
import 'package:west_irbid_mobile/widgets_cc/no_items_widget.dart';

class NewsAndEventsView extends StatefulWidget {
  static final String id = 'news_and_events_view';

  @override
  _NewsAndEventsViewState createState() => _NewsAndEventsViewState();
}

class _NewsAndEventsViewState extends State<NewsAndEventsView> {
  List<Event> events = [];
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        events =
            await SupaApi.get_Table<Event>(
              table_name: 'news_and_events',
              fromJson: Event.fromJson,
              context: Get.context!,
              pageNumber: 1,
              query: {},
              pageSize: 30,
            ) ??
            [];
      },
      // Main.enableBranchesCalendarAndEvents
      //     ? initDataSource(context)
      //     : GeneralController.read(context).getEvents().showLoading()
    );
  }

  Future initDataSource(BuildContext context) async {
    startLoading(context);
    // get attachment files
    pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TranslationService().isLocaleArabic()
          ? TextDirection.rtl
          : TextDirection.ltr,
      child: CustomViewN(
        // appBar: MainAppBar(
        title: 'newsAndEvents'.tr,
        builder: (context, controller, child) {
          return Column(
            children: [
              // if (Main.enableBranchesCalendarAndEvents) ...[
              //   const SizedBox(height: 15),
              //   CustomDropDownWithContHeaderList(
              //     list: controller.calendarAndEventBranches,
              //     hint: Settings.language.selectBranch,
              //     edgeInsets: const EdgeInsets.symmetric(horizontal: 20),
              //     onChange: (val) async {
              //       startLoading(context);
              //       await controller.getEventsByBranch(
              //         branchID: val.id.toString(),
              //       );
              //       pop(context);
              //     },
              //   ),
              // ],
              // if (events.isNotEmpty)
              if (events.isEmpty)
                NoItemsWidget(text: 'noNewsAndEvents'.tr)
              else
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.only(top: 5),
                    shrinkWrap: true,
                    itemCount: events.length + 1,
                    itemBuilder: (context, int index) {
                      if (index == 0) return SizedBox(height: 20);
                      return EventWidget(event: events[index - 1]);
                    },
                  ),
                ),
            ],
          );
        },
      ),
      // ),
    );
  }
}
