import 'package:flutter/material.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:kolobox_new_app/core/constants/image_constants.dart';

class PayStackPayment {
  final String _publicKey = '';
  late PaystackPlugin _plugin;

  final CheckoutMethod _method = CheckoutMethod.selectable;

  PayStackPayment() {
    _plugin = PaystackPlugin();
  }

  void init() {
    _plugin.initialize(publicKey: _publicKey);
  }

  void checkout(BuildContext context) async {
    Charge charge = Charge()
      ..amount = 10000 // In base currency
      ..email = 'customer@email.com'
      ..reference = 'asdfadsfadsfadsf';

    try {
      CheckoutResponse response = await _plugin.checkout(
        context,
        method: _method,
        charge: charge,
        fullscreen: false,
        logo: Image.asset(imageLogoMain),
      );
      print('Response = $response');
    } catch (e) {
      rethrow;
    }
  }
}
