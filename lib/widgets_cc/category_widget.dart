import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:west_irbid_mobile/services_utils/constants.dart';
import 'package:west_irbid_mobile/services_utils/ui_helpers.dart';
import 'package:url_launcher/url_launcher.dart';

class CategoryWidget extends StatelessWidget {
  final String? routeId;
  final String? image;
  final String? title;
  final String? url;
  final String? args;
  final bool fitText;
  Function()? onPressFunction;

  final TextStyle textStyle = const TextStyle(
    color: Colors.white,
    fontSize: 12,
    fontWeight: FontWeight.bold,
  );

  CategoryWidget({
    Key? key,
    this.routeId,
    this.image,
    this.title,
    this.url,
    this.args,
    this.fitText = true,
    this.onPressFunction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: SizedBox(
        height: width / 3.2,
        width: width / 2.6,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            // border: Border.all(width: 1, color: Colors.grey),
            borderRadius: BorderRadius.all(Radius.circular(15)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.25),
                blurRadius: 10,
                spreadRadius: -5,
                blurStyle: BlurStyle.outer,
              ),
            ],
          ),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
            onPressed: () {
              if (url == null && onPressFunction == null) {
                // GeneralController.read(context).initBlockName = title;
                pushNamed(routeId!, args: args ?? title);
              }
              if (onPressFunction != null) {
                onPressFunction!.call();
              } else {
                // GeneralController.read(context).initBlockName = url;
                launchUrl(Uri.parse(url!));
              }
            },
            child: SizedBox(
              width: width / 2.4,
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (image!.substring(image!.length - 3, image!.length) !=
                        'png')
                      SvgPicture.asset(
                        image!,
                        color: Theme.of(context).primaryColor,
                      )
                    else
                      Image.asset(
                        image!,
                        color: Theme.of(context).primaryColor,
                        width: 35,
                      ),
                    const SizedBox(height: 15),
                    if (!fitText) getText(),
                    if (fitText) FittedBox(child: getText()),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Text getText() => Text(
    title!,
    style: TextStyle(color: Colors.black, fontSize: 16),
    maxLines: 1,
    overflow: TextOverflow.ellipsis,
    textAlign: TextAlign.center,
  );
}
