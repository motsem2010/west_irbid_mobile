import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SocialMediaButton extends StatelessWidget {
  final String? imagePath;
  final String? url;
  final double height;

  const SocialMediaButton({Key? key, this.imagePath, this.url, this.height = 50})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await launch(url!);
      },
      child: Container(
        width: height,
        height: height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(imagePath!),
          ),
        ),
      ),
    );
  }
}
