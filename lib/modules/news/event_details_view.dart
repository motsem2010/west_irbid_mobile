import 'package:cached_network_image/cached_network_image.dart';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:eschool/eschool.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart'
    show launchUrl, LaunchMode, canLaunchUrl, launch;
import 'package:west_irbid_mobile/models/attachment_model.dart';
import 'package:west_irbid_mobile/models/event_model.dart';
import 'package:west_irbid_mobile/services_utils/supa_api.dart';
import 'package:west_irbid_mobile/services_utils/ui_helpers.dart';
import 'package:west_irbid_mobile/widgets_cc/attachment_widget.dart';
import 'package:west_irbid_mobile/widgets_cc/custom_view_n.dart';
import 'package:west_irbid_mobile/widgets_cc/images_list_view.dart';
import 'package:west_irbid_mobile/widgets_cc/newwork_image_view.dart';
// import 'package:flutter_html/flutter_html.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:webview_flutter/webview_flutter.dart';

class EventDetailsView extends StatefulWidget {
  Event event;

  static const String id = 'event_details_view';

  EventDetailsView({Key? key, required this.event}) : super(key: key);

  @override
  _EventDetailsViewState createState() => _EventDetailsViewState();
}

class _EventDetailsViewState extends State<EventDetailsView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        startLoading(context, willPop: true);
        widget.event = await loadImages(widget.event, context);

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

  @override
  Widget build(BuildContext context) {
    debugPrint(widget.event.attachments?.length.toString());
    String data =
        // (Main.currentSchool == School.newEnglish ||
        //     Main.currentSchool == School.ets)
        // ? widget.event!.description!
        //       //todo: replace this with new english eschool
        //       //.replaceAll('src="', 'src="http://eschool.nes.edu.jo')
        //       .replaceAll('alt=""', 'alt="image error"')
        //       .replaceAll('width:', 'ss:')
        //       .replaceAll('height:', 'ss:')
        // :
        widget.event.description ?? '';

    // debugPrint(data.toString());

    final double height = MediaQuery.of(context).size.height;
    const double padding = 30;
    int urlIframeChanges = 0;
    return CustomViewN(
      title: widget.event.title,
      body: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Hero(
              tag: widget.event.imageUrl!,
              child: SizedBox(
                width: MediaQuery.of(context).size.width * .75,
                height: height * .2,
                child: Center(
                  child: (widget.event.imageList ?? []).isNotEmpty
                      ? CarouselView(
                          itemExtent: double.maxFinite,
                          // itemCount: (widget.event?.imageList ?? []).length,
                          // options: CarouselOptions(
                          //   autoPlay: true,
                          //   viewportFraction: 1.0,
                          // ),
                          children: [
                            for (
                              int i = 0;
                              i < (widget.event.attachments?.length ?? 0);
                              i++
                            )
                              GestureDetector(
                                onTap: () {
                                  if (widget.event.imageList == null ||
                                      widget.event.imageList!.isEmpty) {
                                    return;
                                  }
                                  push(
                                    NetworkImagesListViewHorizontal(
                                      currentIndex: i,
                                      images: widget.event.imageList,
                                      title: widget.event.title!,
                                    ),
                                  );
                                },
                                child: CachedNetworkImage(
                                  imageUrl:
                                      widget
                                          .event
                                          ?.attachments?[i]
                                          .supaSignedUrl ??
                                      'assets/images/app_icon.png',
                                  // 'assets/icon/ataa_logo.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                          ],
                        )
                      : GestureDetector(
                          onTap: () {
                            if (widget.event.imageUrlSupa == null ||
                                widget.event.imageUrlSupa!.isEmpty) {
                              return;
                            }
                            push(
                              NetworkImageView(
                                imageURL: widget.event.imageUrlSupa!,
                              ),
                            );
                          },
                          child: CachedNetworkImage(
                            fit: BoxFit.fill,
                            placeholder: (context, url) => const Center(
                              child: SpinKitCircle(color: Colors.blueAccent),
                            ),
                            errorWidget: (context, url, error) => Center(
                              child: Image.asset('assets/images/news.png'),
                            ),
                            imageUrl: widget.event.imageUrlSupa ?? '',
                          ),
                        ),
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: padding),
              Text(
                widget.event!.publishingDate!,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
              const SizedBox(height: padding),
              Text(
                widget.event!.title!,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: padding),
              Html(
                data: data.replaceAll('null', '---'),
                // extensions: [
                //   IframeHtmlExtension(
                //     navigationDelegate: NavigationDelegate(
                //       onUrlChange: (change) async {
                //         debugPrint("URL changed to: ${change.url}");
                //         urlIframeChanges++;
                //         if (change.url == null || urlIframeChanges < 2) return;
                //         if (await canLaunchUrl(Uri.parse(change.url!))) {
                //           await launchUrl(
                //             Uri.parse(change.url!),
                //             mode: LaunchMode.externalApplication,
                //           );
                //         }
                //       },
                //       // onNavigationRequest: (NavigationRequest request) async {
                //       //   final url = request.url;
                //       //
                //       //   // Check if it's a YouTube link
                //       //   if (url.contains("youtube.com") ||
                //       //       url.contains("youtu.be")) {
                //       //     // Try to launch the URL in the YouTube app
                //       //     if (await canLaunchUrl(Uri.parse(url))) {
                //       //       await launchUrl(Uri.parse(url),
                //       //           mode: LaunchMode.externalApplication);
                //       //       return NavigationDecision.prevent;
                //       //     }
                //       //   }
                //       //
                //       //   return NavigationDecision.navigate;
                //       // },
                //       // onPageStarted: (url) {
                //       //   debugPrint("Page started: $url");
                //       // },
                //       // onPageFinished: (url) {
                //       //   debugPrint("Page finished: $url");
                //       // },
                //       // onProgress: (progress) {
                //       //   debugPrint("Progress: $progress%");
                //       // },
                //       // onWebResourceError: (error) {
                //       //   debugPrint("WebResourceError: $error");
                //       // },

                //       // onHttpError: (error) {
                //       //   debugPrint("HTTP Error: $error");
                //       // },
                //       // onHttpAuthRequest: (request) {
                //       //   debugPrint("Auth Request: $request");
                //       // },
                //     ),
                //   ),
                // ],
                onLinkTap: (url, _, __) {
                  launch(url!);
                },
              ),
              for (var attachment in (widget.event.attachments ?? []))
                AttachmentWidget(attachment: attachment),
            ],
          ),
        ),
      ],
    );
  }
}
