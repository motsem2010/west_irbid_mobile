import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:west_irbid_mobile/services_utils/ui_helpers.dart';

class CategoryWidgetWithImage extends StatelessWidget {
  final String? routeId;
  final String? image;
  final String? title;
  final String? url;
  final Function? onPress;

  final TextStyle textStyle = const TextStyle(
    color: Colors.white,
    fontSize: 12,
    fontWeight: FontWeight.bold,
  );

  const CategoryWidgetWithImage({
    Key? key,
    this.routeId,
    this.image,
    this.title,
    this.url,
    this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: onPress == null
          ? () =>
                // url == null ? pushNamed(routeId) : launchUrl(Uri.parse(url)),
                url == null ? pushNamed(routeId!) : null
          : () => onPress?.call(),
      //  launch(url!)
      child: SizedBox(
        height: height / 4,
        width: width / 5,
        child: Card(
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
            side: BorderSide(color: Colors.black.withAlpha(150)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                flex: 3,
                child: SizedBox(
                  height: height * 0.04,
                  width: double.infinity,
                  child: Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(20),
                        topLeft: Radius.circular(20),
                      ),
                      child: Image.asset(
                        image ?? "assets/images/logo_icon.png",
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.04,
                child: Padding(
                  padding: EdgeInsets.all(2.0),
                  child: FittedBox(
                    child: Text(
                      title ?? 'TEST',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ).paddingAll(10);
  }
}
