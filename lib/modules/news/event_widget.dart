import 'package:cached_network_image/cached_network_image.dart';
import 'package:eschool/eschool.dart';
import 'package:eschool/src/views/publicViews/news/event_details_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class EventWidget extends StatelessWidget {
  final Event event;

  EventWidget({Key? key, required this.event}) : super(key: key);
  final TextStyle textStyle = const TextStyle(
      color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold);

  String getDescriptionFromHtml(String html) {
    return html
        .replaceAll('&hellip', '...')
        .replaceAll(
            RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true), "")
        .replaceAll('&nbsp', '')
        .replaceAll(';', '');
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => EventDetailsView(
            event: event,
          ),
        ),
      ),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        width: double.infinity,
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.background,
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            boxShadow: const [
              BoxShadow(
                  blurRadius: 5, color: Colors.black12, offset: Offset(2, 2))
            ]),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: event.imageUrl!,
              child: Container(
                height: 94.v,
                width: 84.h,
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6.8),
                    border:
                        Border.all(color: const Color(0xff0E9547), width: 1)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(6.8),
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    placeholder: (context, url) => const Center(
                      child: SpinKitCircle(
                        color: Colors.blueAccent,
                      ),
                    ),
                    errorWidget: (context, url, error) => Center(
                      child: Image.asset('assets/images/image_not_found.png'),
                    ),
                    imageUrl: event.imageUrl!,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 12,
            ),
            Expanded(
              flex: 4,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    event.title!,
                    style: textStyle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  if (getDescriptionFromHtml(event.description!) != 'null')
                    Text(
                      getDescriptionFromHtml(event.description!),
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        event.publishingDate!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary,
                            fontWeight: FontWeight.w400,
                            fontSize: 14),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
