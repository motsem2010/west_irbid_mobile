import 'package:flutter/material.dart';
import 'package:west_irbid_mobile/models/event_model.dart';
import 'package:west_irbid_mobile/modules/news/event_details_view.dart';
import 'package:west_irbid_mobile/services_utils/ui_helpers.dart';

class SingleNewsCard extends StatelessWidget {
  final Event? event;

  const SingleNewsCard({Key? key, this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => push(EventDetailsView(event: event!)),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          width: MediaQuery.of(context).size.width * .8,
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            border: Border.all(color: Color.fromRGBO(233, 233, 233, 1)),
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Hero(
                tag: event!.imageUrl!,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Container(
                    height: 210.0,
                    width: MediaQuery.of(context).size.width * .8,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      image: DecorationImage(
                        fit: BoxFit.fitHeight,
                        image: NetworkImage(event!.imageUrl!),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 5.0),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      (event?.title ?? ''),
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 20.0,
                        // color: Colors.red,
                      ),
                    ),
                    SizedBox(height: 5.0),
                    Text(
                      event?.publishingDate ?? '',
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.blueAccent,
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
}
