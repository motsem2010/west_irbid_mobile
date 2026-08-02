import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:west_irbid_mobile/widgets/appbar_with_profile.dart';

class NetworkImagesListView extends StatelessWidget {
  final List<String>? images;

  const NetworkImagesListView({Key? key, this.images}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarAtaa(title: 'certificates'),
      body: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        children: [
          for (var image in images!)
            SizedBox(
              height: MediaQuery.of(context).size.height * .9,
              width: MediaQuery.of(context).size.width,
              child: PhotoView(imageProvider: NetworkImage(image)),
            ),
        ],
      ),
    );
  }
}

class NetworkImagesListViewHorizontal extends StatelessWidget {
  final String? title;
  final int currentIndex;
  final List<String>? images;

  const NetworkImagesListViewHorizontal({
    Key? key,
    this.images,
    this.title,
    this.currentIndex = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarAtaa(title: title ?? ''),
      body: images == null || images!.isEmpty
          ? Center(child: Text('No images available'))
          : PageView.builder(
              controller: PageController(initialPage: currentIndex),
              itemCount: images!.length,
              itemBuilder: (context, index) {
                return PhotoView(
                  backgroundDecoration: BoxDecoration(color: Colors.white),
                  imageProvider: NetworkImage(images![index]),
                  minScale: PhotoViewComputedScale.contained,
                  maxScale: PhotoViewComputedScale.covered * 2,
                );
              },
            ),
    );
  }
}
