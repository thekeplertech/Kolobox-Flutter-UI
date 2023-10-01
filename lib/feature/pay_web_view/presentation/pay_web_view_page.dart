import 'package:flutter/material.dart';

import '../../../../core/base/base_page.dart';
import 'screen/pay_web_view_screen.dart';

class PayWebViewPage extends BasePage {
  final String authorizationUrl;

  const PayWebViewPage({
    Key? key,
    required this.authorizationUrl,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => PayWebViewPageState();
}

class PayWebViewPageState extends BasePageState<PayWebViewPage> {
  @override
  Widget getChildBlocWidget(BuildContext context) => PayWebViewScreen(
        authorizationUrl: widget.authorizationUrl,
      );
}
