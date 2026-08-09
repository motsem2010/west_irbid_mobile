import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:west_irbid_mobile/models/attachment_model.dart';
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
        startLoading(context, willPop: true);
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
        debugPrint('events length = ${events.length}');
        for (var item in events) {
          if ((item.imageUrl ?? '').length > 10 &&
              item.imageUrl != 'error' &&
              (item.imageUrlSupa ?? '').isEmpty) {
            item.imageUrlSupa = await SupaApi.getPublicUrl(item.imageUrl!);
          }
        }
        pop(context);
        setState(() {});
      },
      // Main.enableBranchesCalendarAndEvents
      //     ? initDataSource(context)
      //     : GeneralController.read(context).getEvents().showLoading()
    );
  }

  Future<Event> loadImages(Event eventItem, BuildContext context) async {
    Event eventRet = eventItem;
    if ((eventItem.attachmentsUrlString ?? '').trim().isEmpty) {
      show_snackBar(context, Colors.red, 'noImagesToView'.tr);

      return eventItem;
    }
    debugPrint('attachments_url_string ${eventItem.attachmentsUrlString}');
    eventRet.attachments = [];
    String? _supaSignedUrl;
    List<String> _ImagesUrl = (eventItem.attachmentsUrlString ?? '').split(';');
    debugPrint('with _ImagesUrl ${_ImagesUrl.length}');
    if (_ImagesUrl.isNotEmpty) {
      for (var e in _ImagesUrl) {
        _supaSignedUrl = await SupaApi.getPublicUrl(e.trim());
        debugPrint(_supaSignedUrl);
        // pop(context);
        // if (_supaSignedUrl != null)
        eventRet.attachments?.add(
          Attachment(url: e, supaSignedUrl: _supaSignedUrl),
        );
      }

      debugPrint('with attachements ${eventRet.attachments?.length}');
      setState(() {});
      return eventRet;
    } else {
      debugPrint('no attachements');
      return eventRet;
    }
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

        body: [
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
            Center(child: NoItemsWidget(text: 'noNewsAndEvents'.tr))
          else
            ListView.builder(
              padding: const EdgeInsets.only(top: 5),
              shrinkWrap: true,
              itemCount: events.length + 1,
              itemBuilder: (context, int index) {
                if (index == 0) return SizedBox(height: 20);
                return EventWidget(event: events[index - 1]);
              },
            ),
        ],
      ),
    );
  }
}
