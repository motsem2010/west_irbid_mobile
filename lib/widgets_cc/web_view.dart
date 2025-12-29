// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:webview_flutter/webview_flutter.dart';

// class WebViewWidget extends StatefulWidget {
//   final String? url;

//   const WebViewWidget({Key? key, this.url}) : super(key: key);

//   @override
//   WebViewWidgetState createState() => WebViewWidgetState();
// }

// class WebViewWidgetState extends State<WebViewWidget> {
//   @override
//   void initState() {
//     super.initState();
//     if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
//   }

//   @override
//   Widget build(BuildContext context) {
//     debugPrint(widget.url);
//     return WebView(
//       initialUrl: widget.url,
//     );
//   }
// }
