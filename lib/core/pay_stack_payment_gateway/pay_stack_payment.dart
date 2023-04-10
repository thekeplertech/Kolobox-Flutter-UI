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

  bool get initialized => _plugin.sdkInitialized;

  Future<void> checkout(
    BuildContext context,
    String amt,
    String email,
    String reference,
    String accessCode,
    Function(String) onSuccess,
    Function(String) onFailure,
  ) async {
    try {
      int amount = (double.parse(amt) * 100).toInt();
      logger?.d("amount $amount");
      Charge charge = Charge()
        ..amount = amount
        ..email = email
        ..reference = reference
        ..accessCode = accessCode;

      CheckoutResponse response = await _plugin.checkout(
        context,
        method: CheckoutMethod.selectable,
        charge: charge,
        fullscreen: false,
      );

      logger?.d('Response = $response');
      if (response.status) {
        logger?.d("Payment reference : ${response.reference}");
        onSuccess(response.reference ?? '');
      } else {
        logger?.d("Payment Failed message : ${response.message}");
        onFailure(response.message);
      }
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
