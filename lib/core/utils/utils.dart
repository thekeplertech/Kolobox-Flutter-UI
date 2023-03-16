import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kolobox_new_app/core/constants/app_constants.dart';

class Utils {
  Utils._();

  static RegExp numReg = RegExp(r".*[0-9].*");
  static RegExp letterReg = RegExp(r".*[A-Za-z].*");

  static bool emailValid(String email) => RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(email);

  static void showToast(BuildContext context, Widget child,
      {bool isTab = false}) {
    FToast fToast = FToast();
    fToast.init(context);
    fToast.showToast(
        child: GestureDetector(
            onTap: () => fToast.removeCustomToast(), child: child),
        gravity: ToastGravity.BOTTOM,
        toastDuration: const Duration(seconds: 2),
        positionedToastBuilder: (context, child) => Positioned(
              bottom: isTab ? (24 + dashboardTabHeight) : 24,
              left: 24,
              right: 24,
              child: child,
            ));
  }

  static bool isNumber(String input) => numReg.hasMatch(input);

  static bool isLetter(String input) => letterReg.hasMatch(input);

  static bool isPasswordShort(String input) => input.length < 6;

  static bool isPasswordLong(String input) => input.length < 8;
}
