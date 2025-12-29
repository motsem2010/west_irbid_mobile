import 'package:flutter/material.dart';
import 'package:west_irbid_mobile/widgets_cc/app_bar_widget.dart';
import 'package:photo_view/photo_view.dart';

class NetworkImageView extends StatelessWidget {
  final String? imageURL;

  const NetworkImageView({Key? key, this.imageURL}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(),
      body: !(imageURL!.contains('http:') || imageURL!.contains('https:'))
          ? Image.asset(imageURL!)
          : PhotoView(
              imageProvider: NetworkImage(imageURL!),
              errorBuilder: (con, v, a) {
                Uri uri = Uri.parse(imageURL!);
                if (uri.scheme == 'http')
                  return PhotoView(
                    imageProvider: NetworkImage(
                      imageURL!.replaceAll("http://", "https://"),
                    ),
                  );
                else
                  return PhotoView(
                    imageProvider: NetworkImage(
                      imageURL!.replaceAll("https://", "http://"),
                    ),
                  );
              },
            ),
    );
  }
}
