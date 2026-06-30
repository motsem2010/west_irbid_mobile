import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:west_irbid_mobile/services_utils/ui_helpers.dart';
import 'package:west_irbid_mobile/widgets/appbar_with_profile.dart';

class PDFViewerPage extends StatefulWidget {
  final String url;
  final bool disableExternalBrowser;
  final String? title;
  final bool useWebViewByDefault;

  const PDFViewerPage({
    Key? key,
    required this.url,
    this.disableExternalBrowser = false,
    this.title,
    this.useWebViewByDefault = false,
  }) : super(key: key);

  @override
  _PDFViewerPageState createState() => _PDFViewerPageState();
}

class _PDFViewerPageState extends State<PDFViewerPage> {
  // ── PDF state ────────────────────────────────────────────────────────────
  PdfViewerController? _pdfController;
  int _pages = 0;
  int _indexPage = 0;
  String _pageText = '0';

  /// Incremented each time the user taps Retry so the SfPdfViewer is
  /// forcibly recreated with a fresh network request.
  int _viewerKey = 0;

  /// Tracks how many times we have silently auto-retried on first load.
  /// The server sometimes rejects the very first cold request; one silent
  /// retry reliably resolves it without the user ever seeing the error UI.
  int _autoRetryCount = 0;
  static const int _maxAutoRetries = 3;

  // ── Loading / error state ─────────────────────────────────────────────────
  /// True while SfPdfViewer.network is fetching / rendering the PDF.
  /// Set to false via onDocumentLoaded or onDocumentLoadFailed.
  bool _isPdfLoading = true;
  String? _errorMessage;

  // ── WebView state ────────────────────────────────────────────────────────
  bool _useWebView = false;
  bool _isWebViewLoading = false;
  late WebViewController _webViewController;

  // ─────────────────────────────────────────────────────────────────────────
  @override
  void initState() {
    super.initState();
    _pdfController = PdfViewerController();
    _useWebView = widget.useWebViewByDefault;

    debugPrint('[PDFViewer] initState — url: ${widget.url}');
    debugPrint(
      '[PDFViewer] initState — useWebView: $_useWebView | isPdfLoading: $_isPdfLoading',
    );

    if (_useWebView) {
      _isPdfLoading = false;
      _initializeWebView();
    }
  }

  // ── Retry ─────────────────────────────────────────────────────────────────
  void _retry() {
    debugPrint('[PDFViewer] _retry called — viewerKey before: $_viewerKey');
    setState(() {
      _errorMessage = null;
      _isPdfLoading = true;
      _autoRetryCount = 0; // allow one more silent retry on next failure
      _viewerKey++;
    });
    debugPrint('[PDFViewer] _retry — viewerKey after: $_viewerKey');
  }

  // ── WebView helpers ───────────────────────────────────────────────────────

  void _initializeWebView() {
    setState(() {
      _isWebViewLoading = true;
      _useWebView = true;
    });

    _webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) => debugPrint('WebView: $progress%'),
          onPageStarted: (_) => setState(() => _isWebViewLoading = true),
          onPageFinished: (_) => setState(() => _isWebViewLoading = false),
          onWebResourceError: (WebResourceError error) {
            debugPrint('WebView error: ${error.description}');
            setState(() {
              _isWebViewLoading = false;
              _errorMessage =
                  'Unable to load PDF. Please try opening externally.';
            });
          },
        ),
      );

    final encoded = Uri.encodeComponent(widget.url);
    _webViewController.loadRequest(
      Uri.parse('https://docs.google.com/gview?embedded=true&url=$encoded'),
    );
  }

  void _toggleViewer() {
    setState(() {
      _useWebView = !_useWebView;
      _errorMessage = null;
      _isPdfLoading = !_useWebView; // reset loading flag for Syncfusion mode
    });

    if (_useWebView) {
      _initializeWebView();
    }
  }

  // ── External browser ──────────────────────────────────────────────────────

  Future<void> _openExternally() async {
    try {
      await launchUrl(
        Uri.parse(widget.url),
        mode: LaunchMode.externalApplication,
        webViewConfiguration: const WebViewConfiguration(
          enableJavaScript: true,
          enableDomStorage: true,
        ),
      );
    } catch (e) {
      debugPrint('External browser failed: $e');
      try {
        await launchUrl(
          Uri.parse(widget.url),
          mode: LaunchMode.externalNonBrowserApplication,
        );
      } catch (e2) {
        debugPrint('All launch methods failed: $e2');
      }
    }
  }

  // ── Page navigation ───────────────────────────────────────────────────────

  void _updatePageText({int index = 0}) {
    setState(() {
      _pageText = '${index + 1} of $_pages';
      _indexPage = index;
    });
  }

  // ── Build ─────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final name = widget.url.split('/').last;

    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        appBar: AppBarAtaa(
          title: widget.title ?? name,
          actions: _buildAppBarActions(context),
        ),
        body: _buildContent(context),
      ),
    );
  }

  List<Widget> _buildAppBarActions(BuildContext context) {
    return [
      // Switch back to Syncfusion (only visible in WebView mode)
      if (_useWebView)
        IconButton(
          tooltip: 'Switch to Standard Viewer',
          onPressed: _toggleViewer,
          icon: Icon(
            Icons.picture_as_pdf,
            color: Theme.of(context).primaryColor,
            size: 28,
          ),
        ),

      // Page counter + chevrons (Syncfusion only, after load)
      if (_pages > 1 && !_useWebView) ...[
        Center(child: Text(_pageText)),
        IconButton(
          icon: Icon(
            Icons.chevron_left,
            size: 32,
            color: Theme.of(context).primaryColor,
          ),
          onPressed: () {
            final page = _indexPage == 0 ? _pages - 1 : _indexPage - 1;
            _pdfController?.jumpToPage(page + 1);
          },
        ),
        IconButton(
          icon: Icon(
            Icons.chevron_right,
            size: 32,
            color: Theme.of(context).primaryColor,
          ),
          onPressed: () {
            final page = (_indexPage == _pages - 1) ? 0 : _indexPage + 1;
            _pdfController?.jumpToPage(page + 1);
          },
        ),
      ],

      // Open in external browser
      if (!widget.disableExternalBrowser)
        IconButton(
          onPressed: _openExternally,
          icon: Icon(
            Icons.open_in_browser,
            color: Theme.of(context).primaryColor,
            size: 30,
          ),
        ),
    ];
  }

  // ── Content router ────────────────────────────────────────────────────────

  Widget _buildContent(BuildContext context) {
    debugPrint(
      '[PDFViewer] _buildContent — isPdfLoading: $_isPdfLoading | errorMessage: $_errorMessage | useWebView: $_useWebView | viewerKey: $_viewerKey',
    );
    if (_errorMessage != null && !_useWebView) return _buildErrorUI(context);
    if (_useWebView) return _buildWebView();
    return _buildSyncfusionViewer(context);
  }

  // ── Syncfusion viewer (network) ───────────────────────────────────────────
  // Uses SfPdfViewer.network so Syncfusion handles HTTP internally — no
  // download-to-file pipeline, no file I/O race conditions.

  Widget _buildSyncfusionViewer(BuildContext context) {
    return Stack(
      children: [
        // The viewer is always present in the tree (even while loading) so that
        // Syncfusion can start fetching the PDF immediately.
        SfPdfViewer.network(
          widget.url,
          key: ValueKey(_viewerKey),
          controller: _pdfController,
          enableHyperlinkNavigation: true,
          onDocumentLoaded: (PdfDocumentLoadedDetails details) {
            debugPrint(
              '[PDFViewer] onDocumentLoaded — pages: ${details.document.pages.count} | viewerKey: $_viewerKey',
            );
            if (!mounted) return;
            setState(() {
              _isPdfLoading = false;
              _pages = details.document.pages.count;
              _pageText = '1 of $_pages';
            });
          },
          onPageChanged: (PdfPageChangedDetails details) {
            _updatePageText(index: details.newPageNumber - 1);
          },
          onDocumentLoadFailed: (PdfDocumentLoadFailedDetails details) {
            debugPrint('[PDFViewer] *** onDocumentLoadFailed ***');
            debugPrint('[PDFViewer]   error: ${details.error}');
            debugPrint('[PDFViewer]   description: ${details.description}');
            debugPrint(
              '[PDFViewer]   viewerKey: $_viewerKey | autoRetryCount: $_autoRetryCount | isPdfLoading before: $_isPdfLoading',
            );
            if (!mounted) return;

            if (_autoRetryCount < _maxAutoRetries) {
              _autoRetryCount++;
              // Use exponential backoff: 1s, 2s, 4s — gives the server time
              // to warm up between attempts (300ms was too short).
              final delayMs = 1000 * (1 << (_autoRetryCount - 1));
              debugPrint(
                '[PDFViewer] Silent auto-retry #$_autoRetryCount — waiting ${delayMs}ms then rebuilding viewer',
              );
              Future.delayed(Duration(milliseconds: delayMs), () {
                if (mounted) {
                  setState(() {
                    _viewerKey++;
                    // keep _isPdfLoading = true so the overlay stays visible
                  });
                }
              });
            } else {
              // Retries exhausted — show the error UI.
              setState(() {
                _isPdfLoading = false;
                _errorMessage = 'Failed to load PDF: ${details.description}';
              });
            }
          },
        ),

        // Loading overlay — shown until onDocumentLoaded fires.
        if (_isPdfLoading)
          Container(
            color: Theme.of(context).scaffoldBackgroundColor,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  CustomProgressIndicator(),
                  SizedBox(height: 20),
                  Text('Loading PDF…', style: TextStyle(fontSize: 16)),
                ],
              ),
            ),
          ),
      ],
    );
  }

  // ── WebView viewer ────────────────────────────────────────────────────────

  Widget _buildWebView() {
    return Stack(
      children: [
        WebViewWidget(controller: _webViewController),
        if (_isWebViewLoading)
          Container(
            color: Colors.white.withOpacity(0.8),
            child: const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomProgressIndicator(),
                  SizedBox(height: 20),
                  Text('Loading PDF viewer…', style: TextStyle(fontSize: 16)),
                ],
              ),
            ),
          ),
      ],
    );
  }

  // ── Error UI ──────────────────────────────────────────────────────────────

  Widget _buildErrorUI(BuildContext context) {
    debugPrint(
      '[PDFViewer] _buildErrorUI shown — errorMessage: $_errorMessage | viewerKey: $_viewerKey',
    );
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 64, color: Colors.red),
          const SizedBox(height: 16),
          const Text(
            'PDF Viewer Error',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Text(
              _errorMessage!,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 14),
            ),
          ),
          const SizedBox(height: 24),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            alignment: WrapAlignment.center,
            children: [
              ElevatedButton(onPressed: _retry, child: const Text('Retry')),
              if (!_useWebView)
                ElevatedButton(
                  onPressed: _toggleViewer,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Try Web Viewer'),
                ),
              ElevatedButton(
                onPressed: _openExternally,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Open Externally'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
