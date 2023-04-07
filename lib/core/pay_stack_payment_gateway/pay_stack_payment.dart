import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:kolobox_new_app/config/flavor_config.dart';

import '../../routes/routes.dart';

class PayStackPayment {
  late PaystackPlugin _plugin;

  final CheckoutMethod _method = CheckoutMethod.selectable;

  PayStackPayment() {
    _plugin = PaystackPlugin();
    _plugin.initialize(publicKey: FlavorConfig.instance?.payStackKey ?? '');
  }

  void checkout(BuildContext context) async {
    Charge charge = Charge()
      ..amount = 100 // In base currency
      ..email = 'customer@email.com'
      ..reference = _getReference();

    try {
      CheckoutResponse response = await _plugin.checkout(
        context,
        method: CheckoutMethod.card,
        charge: charge,
        fullscreen: false,
      );
      logger?.d('Response = $response');
    } catch (e) {
      logger?.d("pay stack checkout $e");
    }
  }

  String _getReference() {
    String platform;
    if (Platform.isIOS) {
      platform = 'iOS';
    } else {
      platform = 'Android';
    }

    return 'ChargedFrom${platform}_${DateTime.now().millisecondsSinceEpoch}';
  }
}
