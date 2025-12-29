import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:west_irbid_mobile/services_utils/translation_service.dart';
import 'package:west_irbid_mobile/services_utils/ui_helpers.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class PDFViewerPage extends StatefulWidget {
  final String url;

  const PDFViewerPage({Key? key, required this.url}) : super(key: key);

  @override
  _PDFViewerPageState createState() => _PDFViewerPageState();
}

class _PDFViewerPageState extends State<PDFViewerPage> {
  File? pdfFile;

  Future fetchFile() async {
    loadNetwork(widget.url).then((value) {
      setState(() {
        pdfFile = value;
        name = basename(value.path);
        text = '${indexPage + 1} of $pages';
      });
    });
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) => fetchFile());
    super.initState();
  }

  void setPagesText({int index = 0}) {
    setState(() {
      text = '${index + 1} of $pages';
    });
  }

  String name = '';
  String text = '0';

  // void openPDF(BuildContext context, File file, String url) =>
  //     Navigator.of(context).push(
  //       MaterialPageRoute(
  //           builder: (context) => PDFViewerPage(
  //                 file: file,
  //                 url: url,
  //               )),
  //     );

  static Future<File> loadNetwork(String url) async {
    final response = await http.get(Uri.parse(url));
    final bytes = response.bodyBytes;

    return (await _storeFile(url, bytes));
  }

  static Future<File> _storeFile(String url, List<int> bytes) async {
    final filename = basename(url);
    final dir = await getApplicationDocumentsDirectory();

    final file = File('${dir.path}/$filename');
    await file.writeAsBytes(bytes, flush: true);
    return file;
  }

  PDFViewController? controller;
  int pages = 0;
  int indexPage = 0;

  @override
  Widget build(BuildContext context) {
    if (pdfFile == null)
      return Scaffold(body: CustomProgressIndicator());
    else
      return Directionality(
        textDirection: TranslationService().isLocaleArabic() == true
            ? TextDirection.rtl
            : TextDirection.ltr,
        child: Scaffold(
          appBar: AppBar(
            title: Text(name),
            actions: [
              if (pages > 1) Center(child: Text(text)),
              if (pages > 1)
                IconButton(
                  icon: Icon(Icons.chevron_left, size: 32),
                  onPressed: () {
                    final page = indexPage == 0 ? pages : indexPage - 1;
                    controller?.setPage(page);
                    setState(() {
                      setPagesText(index: page);
                    });
                  },
                ),
              if (pages > 1)
                IconButton(
                  icon: Icon(Icons.chevron_right, size: 32),
                  onPressed: () {
                    final page = (indexPage == pages - 1) ? 0 : indexPage + 1;
                    controller?.setPage(page);
                    setState(() {
                      setPagesText(index: page);
                    });
                  },
                ),
              IconButton(
                onPressed: () async {
                  launchUrl(
                    Uri.parse(widget.url),
                    mode: LaunchMode.externalApplication,
                    webViewConfiguration: WebViewConfiguration(
                      enableJavaScript: true,
                      enableDomStorage: true,
                    ),
                  );
                },
                icon: Icon(Icons.open_in_browser, size: 30),
              ),
            ],
          ),
          body: PDFView(
            filePath: pdfFile?.path,
            preventLinkNavigation: true,
            onLinkHandler: (link) {
              launchUrl(Uri.parse(link!), mode: LaunchMode.externalApplication);
            },
            onError: (m) {
              pop(context);
              launchUrl(
                Uri.parse(widget.url),
                mode: LaunchMode.externalApplication,
              );
            },
            onPageError: (i, d) {
              pop(context);
              launchUrl(
                Uri.parse(widget.url),
                mode: LaunchMode.externalApplication,
              );
            },
            autoSpacing: false,
            pageSnap: false,
            pageFling: true,
            onRender: (p) => setState(() {
              pages = p ?? 0;
              text = '${indexPage + 1} of $pages';
            }),
            onViewCreated: (controller) {
              setState(() => this.controller = controller);
              Future.delayed(Duration(seconds: 1)).then((value) {
                if (pages == 0) {
                  pop(context);
                  launchUrl(
                    Uri.parse(widget.url),
                    mode: LaunchMode.externalApplication,
                  );
                }
              });
            },
            onPageChanged: (indexPage, _) =>
                setState(() => this.indexPage = indexPage ?? 0),
          ),
        ),
      );
  }
}
