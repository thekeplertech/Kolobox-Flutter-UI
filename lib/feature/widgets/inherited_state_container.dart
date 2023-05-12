import 'package:flutter/material.dart';
import 'package:kolobox_new_app/core/constants/app_constants.dart';
import 'package:kolobox_new_app/core/enums/kolobox_fund_enum.dart';
import 'package:kolobox_new_app/core/enums/period_enum.dart';
import 'package:kolobox_new_app/feature/dashboard/data/models/get_group_tenor_response_model.dart';

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
  String? _amount = '', _targetAmount = '';
  PaymentGatewayEnum? _paymentGatewayEnum;
  String? _popUntil;
  PeriodEnum? _periodEnum;
  GroupTenorModel? _groupTenorModel;
  DateTime? _targetDate;
  String? _targetName;
  bool isSuccessful = false;

  @override
  Widget build(BuildContext context) => _InheritedStateContainer(
        data: this,
        key: widget.key!,
        child: widget.child,
      );

  KoloboxFundEnum? getKoloBoxEnum() => _koloboxFundEnum;

  String getAmount() => _amount ?? '0.0';

  String getTargetAmount() => _targetAmount ?? '0.0';

  DateTime? getTargetDate() => _targetDate;

  String? getTargetName() => _targetName;

  PaymentGatewayEnum? getPaymentGatewayEnum() => _paymentGatewayEnum;

  PeriodEnum getPeriodEnum() => _periodEnum ?? PeriodEnum.monthly;

  GroupTenorModel? getGroupTenorModel() => _groupTenorModel;

  String getPopUntil() => _popUntil ?? '/';

  bool? isWallet() => _isWallet;

  bool isFundYourKoloBox() => _isFundYourKoloBox ?? false;

  void openFundMyKoloBox({
    bool? isFundYourKoloBox,
    KoloboxFundEnum? fundEnum,
    String? amount,
    String? targetAmount,
    String? targetName,
    DateTime? targetDateTime,
    PaymentGatewayEnum? paymentEnum,
    PeriodEnum? periodEnum,
    GroupTenorModel? groupTenorModel,
    String? popUntil,
    bool? isWallet,
  }) {
    _koloboxFundEnum = fundEnum;
    _amount =
        amount?.replaceAll(nigerianCurrency, '').replaceAll(',', '').trim();
    _targetAmount = targetAmount
        ?.replaceAll(nigerianCurrency, '')
        .replaceAll(',', '')
        .trim();
    _targetName = targetName;
    _targetDate = targetDateTime;
    _paymentGatewayEnum = paymentEnum;
    _periodEnum = periodEnum;
    _groupTenorModel = groupTenorModel;
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
    _targetAmount = null;
    _targetDate = null;
    _paymentGatewayEnum = null;
    _groupTenorModel = null;
    _popUntil = null;
    _isWallet = null;
    _isFundYourKoloBox = null;
    isSuccessful = false;
  }
}
