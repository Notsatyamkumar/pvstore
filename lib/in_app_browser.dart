import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class InAppBrowser extends StatefulWidget {
  final String allowedUrl;

  const InAppBrowser({Key? key, required this.allowedUrl}) : super(key: key);

  @override
  State<InAppBrowser> createState() => _InAppBrowserState();
}

class _InAppBrowserState extends State<InAppBrowser> {
late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
    
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
     
      ..loadRequest(Uri.parse(widget.allowedUrl));
      _controller.setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Optionally handle progress updates
          },
          onPageStarted: (String url) {
            // Optionally handle page start
          },
          onPageFinished: (String url) {
            // Optionally handle page finish
          },
          onNavigationRequest: (NavigationRequest request) {
         
     
            if (request.url.startsWith("https://pvstore.padhaivadhai.com")) {
              return NavigationDecision.navigate; // Allow navigation
            } else {
              // Block navigation to other sites
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Navigation to other sites is not allowed.')),
              );
              return NavigationDecision.prevent;
            }
          },
        ),
      );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: WebViewWidget(controller: _controller),
    );
  }
}
