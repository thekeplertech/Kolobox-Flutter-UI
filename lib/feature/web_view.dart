import 'package:flutter/material.dart';
import 'package:kolobox_new_app/routes/routes.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../core/colors/color_list.dart';

class WebView extends StatefulWidget {
  final String authorizationUrl;

  const WebView({Key? key, required this.authorizationUrl}) : super(key: key);

  @override
  State<WebView> createState() => _WebViewState();
}

class _WebViewState extends State<WebView> {
  final GlobalKey webViewKey = GlobalKey();
  late WebViewController _controller;
  bool isLoaded = false;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(ColorList.white)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (String url) {
            print('webviewflutter onPageFinished $url $isLoaded');
            if (url.startsWith('https://kolobox.ng/payment-loader.html')) {
              if (!isLoaded) {
                _controller.loadRequest(Uri.parse(widget.authorizationUrl));
                isLoaded = true;
              } else {
                goBack(context);
              }
            } else if (url.startsWith('https://www.kolobox.ng') && isLoaded) {
              print(url.substring(url.lastIndexOf('=') + 1));
              goBack(context);
            }
          },
        ),
      )
      ..loadRequest(Uri.parse('https://kolobox.ng/payment-loader.html'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebViewWidget(controller: _controller),
    );
  }
}
