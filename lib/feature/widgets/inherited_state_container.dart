import 'package:flutter/material.dart';
import 'package:kolobox_new_app/core/constants/app_constants.dart';
import 'package:kolobox_new_app/core/enums/kolobox_fund_enum.dart';

import '../../core/enums/payment_gateway_enum.dart';

class _InheritedStateContainer extends InheritedWidget {
  final StateContainerState data;

  const _InheritedStateContainer({
    required Key key,
    required this.data,
    required Widget child,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(_InheritedStateContainer old) => true;
}

class StateContainer extends StatefulWidget {
  final Widget child;

  const StateContainer({
    required Key key,
    required this.child,
  }) : super(key: key);

  static StateContainerState of(BuildContext context) {
    return (context
                .dependOnInheritedWidgetOfExactType<_InheritedStateContainer>()
            as _InheritedStateContainer)
        .data;
  }

  @override
  StateContainerState createState() => StateContainerState();
}

class StateContainerState extends State<StateContainer> {
  bool? _isFundYourKoloBox;
  bool? _isWallet;
  KoloboxFundEnum? _koloboxFundEnum;
  String? _amount = '';
  PaymentGatewayEnum? _paymentGatewayEnum;
  String? _popUntil;
  bool isSuccessful = false;

  @override
  Widget build(BuildContext context) => _InheritedStateContainer(
        data: this,
        key: widget.key!,
        child: widget.child,
      );

  KoloboxFundEnum? getKoloBoxEnum() => _koloboxFundEnum;

  String getAmount() => _amount ?? '0.0';

  PaymentGatewayEnum? getPaymentGatewayEnum() => _paymentGatewayEnum;

  String getPopUntil() => _popUntil ?? '/';

  bool? isWallet() => _isWallet;

  bool isFundYourKoloBox() => _isFundYourKoloBox ?? false;

  void openFundMyKoloBox({
    bool? isFundYourKoloBox,
    KoloboxFundEnum? fundEnum,
    String? amount,
    PaymentGatewayEnum? paymentEnum,
    String? popUntil,
    bool? isWallet,
  }) {
    _koloboxFundEnum = fundEnum;
    _amount =
        amount?.replaceAll(nigerianCurrency, '').replaceAll(',', '').trim();
    _paymentGatewayEnum = paymentEnum;
    if (popUntil != null) {
      _popUntil = popUntil;
    }
    if (isWallet != null) {
      _isWallet = isWallet;
    }
    if (isFundYourKoloBox != null) {
      _isFundYourKoloBox = isFundYourKoloBox;
    }
  }

  void clearData() {
    _koloboxFundEnum = null;
    _amount = null;
    _paymentGatewayEnum = null;
    _popUntil = null;
    _isWallet = null;
    _isFundYourKoloBox = null;
    isSuccessful = false;
  }
}
