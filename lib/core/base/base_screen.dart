import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart' as toast;
import 'package:logger/logger.dart';

import '../../di/injection_container.dart';
import '../colors/color_list.dart';
import '../constants/image_constants.dart';
import '../constants/message_constants.dart';
import '../preference/pref_helper.dart';
import '../ui/widgets/toast_widget.dart';
import '../utils/utils.dart';
import 'base_view.dart';

abstract class BaseScreen extends StatefulWidget {
  const BaseScreen({Key? key}) : super(key: key);
}

abstract class BaseScreenState<T extends BaseScreen> extends State<T>
    with WidgetsBindingObserver
    implements BaseView {
  Logger? logger = sl();
  PrefHelper? prefHelper = sl();

  @override
  void initState() {
    printLogger();
    super.initState();

    logger = sl();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    return body(context);
  }

  Widget body(BuildContext context);

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void removeFocus() => FocusScope.of(context).requestFocus(FocusNode());

  @override
  void showErrorDialog(String errorMessage) => toast.Fluttertoast.showToast(
      msg: errorMessage,
      toastLength: toast.Toast.LENGTH_SHORT,
      gravity: toast.ToastGravity.BOTTOM,
      timeInSecForIosWeb: 2);

  @override
  void showToast(String message,
      {toast.ToastGravity? gravity = toast.ToastGravity.BOTTOM}) {
    toast.Fluttertoast.showToast(
      msg: message,
      toastLength: gravity == toast.ToastGravity.TOP
          ? toast.Toast.LENGTH_LONG
          : toast.Toast.LENGTH_SHORT,
      gravity: gravity,
      backgroundColor: ColorList.black,
      textColor: ColorList.white,
      timeInSecForIosWeb: 2,
    );
  }

  @override
  void serverError() {
    toast.Fluttertoast.showToast(
        msg: labelPleaseCheckInternetConnection,
        toastLength: toast.Toast.LENGTH_LONG,
        gravity: toast.ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3);
  }

  @override
  void checkInternetConnectionError() => toast.Fluttertoast.showToast(
      msg: labelPleaseCheckInternetConnection,
      toastLength: toast.Toast.LENGTH_LONG,
      gravity: toast.ToastGravity.BOTTOM,
      timeInSecForIosWeb: 3);

  @override
  void showMessageArrivedMessage() {}

  comingSoon() {
    Utils.showToast(
        context,
        ToastWidget(
          'Coming soon. In development.',
          backgroundColor: ColorList.primaryColor,
          messageIcon: imageRightWhite,
          closeWidget: Image.asset(
            imageClose,
            color: ColorList.white,
          ),
        ));
  }

  exitApp() {
    SystemChannels.platform.invokeMethod<void>('SystemNavigator.pop');
  }

  showKeyboard() {
    SystemChannels.textInput.invokeMethod('TextInput.show');
  }

  String className = "";

  void printLogger() {
    className = runtimeType.toString();
  }

  Future<T?> showCustomBottomSheet(Widget child, {double? height}) =>
      showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
          ),
        ),
        backgroundColor: ColorList.white,
        isScrollControlled: true,
        builder: (_) => SizedBox(
            height: height == null
                ? null
                : MediaQuery.of(context).size.height * height,
            child: child),
      );
}
