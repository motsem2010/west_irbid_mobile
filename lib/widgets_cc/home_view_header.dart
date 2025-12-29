import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';

import 'category_row.dart';
import 'hello_user_widget.dart';

class HomeViewHeader extends StatelessWidget {
  final List<Widget>? children;
  final double? maxChildSize;
  final double? initialChildSize;
  final double? minChildSize;
  final String? username;

  const HomeViewHeader(
      {Key? key,
      this.children,
      this.maxChildSize,
      this.initialChildSize,
      this.minChildSize,
      this.username})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        Positioned(
          top: 0,
          child: SizedBox(
            width: width,
            height: height * .55,
            child: ImageSlideshow(
              /// Width of the [ImageSlideshow].
              width: double.infinity,

              /// Height of the [ImageSlideshow].
              height: 200,
              isLoop: false,

              /// The page to show when first creating the [ImageSlideshow].
              initialPage: 0,

              /// The color to paint the indicator.
              indicatorColor: Colors.blue,

              /// The color to paint behind th indicator.
              indicatorBackgroundColor: Colors.grey,

              /// The widgets to display in the [ImageSlideshow].
              /// Add the sample image file into the images folder
              children: [
                Image.asset(
                  'images/app_image.png',
                  fit: BoxFit.fitWidth,
                ),
              ],

              /// Called whenever the page in the center of the viewport changes.
              onPageChanged: (value) {},

              /// Auto scroll interval.
              /// Do not auto scroll with null or 0.
              autoPlayInterval: 5000,
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          child: SizedBox(
            width: width,
            height: height,
            child: DraggableScrollableSheet(
              minChildSize: minChildSize ?? .55,
              initialChildSize: initialChildSize ?? .55,
              maxChildSize: maxChildSize ?? .83,
              expand: false,
              builder: (context, scrollController) => Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(40),
                      topLeft: Radius.circular(40)),
                  color: Theme.of(context).colorScheme.secondary,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Container(
                    width: width,
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(40),
                            topLeft: Radius.circular(40))),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 25,
                            ),
                            // if (Settings.currentUser != null)
                            HelloUserWidget(username: this.username ?? ''),
                            SizedBox(
                              height: 25,
                            ),
                            for (int i = 0; i < children!.length; i += 2)
                              CategoryRow(
                                fCategory: children![i],
                                sCategory: i + 1 < children!.length
                                    ? children![i + 1]
                                    : null,
                              )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
