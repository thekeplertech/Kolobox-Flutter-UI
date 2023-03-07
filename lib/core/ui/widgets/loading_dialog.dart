import 'package:flutter/material.dart';

import '../../colors/color_list.dart';


Future<Widget?> loadingDialog({
  required BuildContext context,
}) =>
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (_) => WillPopScope(
        onWillPop: () async => false,
        child: SimpleDialog(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  decoration: ShapeDecoration(
                    color: ColorList.white,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: ColorList.white),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(20.0),
                      ),
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 15.0,
                    horizontal: 15.0,
                  ),
                  child: Column(
                    children: <Widget>[
                      getCircularProgressIndicator(),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );

CircularProgressIndicator getCircularProgressIndicator() =>
    CircularProgressIndicator(
      backgroundColor: ColorList.white,
      valueColor: const AlwaysStoppedAnimation<Color>(
        Color(0xff649136),
      ),
    );
