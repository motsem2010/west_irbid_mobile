import 'package:cached_network_image/cached_network_image.dart';
import 'package:eschool/src/views/publicViews/news/event_details_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
// import 'package:skeletons/skeletons.dart';

import '../../../../eschool.dart';

class MiniNewsCard extends StatelessWidget {
  final Event? event;

  MiniNewsCard({this.event});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    print("this.event.description");
    print(this.event!.description);
    return GestureDetector(
      onTap: () => push(EventDetailsView(
        event: event,
      )),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            border: Border.all(
              color: Color.fromRGBO(233, 233, 233, 1),
            ),
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Hero(
                  tag: event!.imageUrl!,
                  child: CachedNetworkImage(
                    height: 94.v,
                    width: 86.h,
                    fit: BoxFit.cover,
                    cacheKey: event!.imageUrl,
                    placeholder: (context, url) => Center(child: skeletonCard()
                        //      SkeletonAvatar(
                        //   style: SkeletonAvatarStyle(
                        //       shape: BoxShape.rectangle,
                        //       width: width * .25,
                        //       height: 80),
                        // )

                        ),
                    errorWidget: (context, url, error) => Center(
                      child: SizedBox(),
                    ),
                    imageUrl: event!.imageUrl!,
                  ),
                ),
              ),
              SizedBox(
                width: 30.0,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      (this.event?.title ?? ''),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16.0,
                        // color: Colors.red,
                      ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Html(
                      data: this.event!.description,
                      style: {
                        '#': Style(
                            fontSize: FontSize(16),
                            maxLines: 2,
                            textOverflow: TextOverflow.ellipsis,
                            color: Color.fromRGBO(139, 144, 165, 1)),
                      },
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Row(
                      children: [
                        Text(
                          this.event?.creatingDate ?? '',
                          style: TextStyle(
                              fontSize: 14.0, color: Colors.blueAccent),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
