import 'package:fluttertoast/fluttertoast.dart';

mixin BaseView {
  void showErrorDialog(String errorMessage);

  void showToast(String message, {ToastGravity? gravity});

  void serverError();

  void checkInternetConnectionError();

  void showMessageArrivedMessage();
}
