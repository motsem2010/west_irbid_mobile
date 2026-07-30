import 'package:eschool/eschool.dart';
import 'package:eschool/src/views/publicViews/news/event_widget.dart';
import 'package:flutter/material.dart';

class NewsAndEventsView extends StatefulWidget {
  static final String id = 'news_and_events_view';

  @override
  _NewsAndEventsViewState createState() => _NewsAndEventsViewState();
}

class _NewsAndEventsViewState extends State<NewsAndEventsView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async =>
        Main.enableBranchesCalendarAndEvents
            ? initDataSource(context)
            : GeneralController.read(context).getEvents().showLoading());
  }

  Future initDataSource(BuildContext context) async {
    final generalController =
        await Provider.of<GeneralController>(context, listen: false);
    startLoading(context);
    await generalController.getBranches();
    if (generalController.calendarAndEventBranches == null ||
        generalController.calendarAndEventBranches!.isEmpty)
      return pop(context);
    await generalController.getEventsByBranch(
        branchID: generalController.calendarAndEventBranches![0].id.toString());
    pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: Settings.language.textDirection,
      child: CustomViewN<GeneralController>(
        // appBar: MainAppBar(
        title: Settings.language.newsAndEvents,
        builder: (context, controller, child) {
          return Column(
            children: [
              if (Main.enableBranchesCalendarAndEvents) ...[
                const SizedBox(
                  height: 15,
                ),
                CustomDropDownWithContHeaderList(
                  list: controller.calendarAndEventBranches,
                  hint: Settings.language.selectBranch,
                  edgeInsets: const EdgeInsets.symmetric(horizontal: 20),
                  onChange: (val) async {
                    startLoading(context);
                    await controller.getEventsByBranch(
                        branchID: val.id.toString());
                    pop(context);
                  },
                ),
              ],
              if (controller.events != null)
                if (controller.events!.isEmpty)
                  NoItemsWidget(text: Settings.language.noNewsAndEvents)
                else
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.only(top: 5),
                      shrinkWrap: true,
                      itemCount: controller.events!.length + 1,
                      itemBuilder: (context, int index) {
                        if (index == 0)
                          return SizedBox(
                            height: 20,
                          );
                        return EventWidget(
                          event: controller.events![index - 1],
                        );
                      },
                    ),
                  )
              else
                SizedBox.shrink(),
            ],
          );
        },
      ),
      // ),
    );
  }
}
