import 'package:flutter/material.dart';
import 'package:kolobox_new_app/core/colors/color_list.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../../core/base/base_bloc_widget.dart';
import '../../../../routes/routes.dart';

class PayWebViewScreen extends BaseBlocWidget {
  final String authorizationUrl;

  const PayWebViewScreen({
    Key? key,
    required this.authorizationUrl,
  }) : super(key: key);

  @override
  PayWebViewScreenState createState() => PayWebViewScreenState();
}

class PayWebViewScreenState extends BaseBlocWidgetState<PayWebViewScreen> {
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
          // onPageStarted: (String url) {
          //   if (url.startsWith('https://kolobox.ng/payment-loader.html')) {
          //     if (!isLoaded) {
          //       _controller.loadRequest(Uri.parse(widget.authorizationUrl));
          //       isLoaded = true;
          //     } else {
          //       goBack(context, result: 'failed');
          //     }
          //   } else if (url.startsWith('https://www.kolobox.ng') && isLoaded) {
          //     goBack(context, result: url.substring(url.lastIndexOf('=') + 1));
          //   }
          // },
          onPageStarted: (String url) {
            if (url.startsWith('https://kolobox.ng/payment-loader.html')) {
              if (!isLoaded) {
                _controller.loadRequest(Uri.parse(widget.authorizationUrl));
                isLoaded = true;
              } else {
                goBack(context, result: 'failed');
              }
            } else if (url.startsWith('https://www.kolobox.ng') && isLoaded) {
              goBack(context, result: url.substring(url.lastIndexOf('=') + 1));
            }
          },
        ),
      )
      ..loadRequest(Uri.parse('https://kolobox.ng/payment-loader.html'));
  }

  @override
  Widget getCustomBloc() {
    return Scaffold(
      backgroundColor: ColorList.white,
      body: WebViewWidget(controller: _controller),
    );
  }
}
