import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Utils {
  Utils._();

  static void showToast(BuildContext context, Widget child) {
    FToast fToast = FToast();
    fToast.init(context);
    fToast.showToast(
        child: GestureDetector(
            onTap: () => fToast.removeCustomToast(), child: child),
        gravity: ToastGravity.BOTTOM,
        toastDuration: const Duration(seconds: 2),
        positionedToastBuilder: (context, child) => Positioned(
              bottom: 24,
              left: 24,
              right: 24,
              child: child,
            ));
  }
}
