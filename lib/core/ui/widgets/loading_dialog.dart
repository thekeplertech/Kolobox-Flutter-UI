import 'package:flutter/material.dart';

import '../../colors/color_list.dart';

Future<Widget?> loadingDialog({
  required BuildContext context,
  required GlobalKey<ScaffoldState> key,
}) =>
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (_) => WillPopScope(
        onWillPop: () async => false,
        child: SimpleDialog(
          key: key,
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  decoration: const ShapeDecoration(
                    color: ColorList.white,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: ColorList.white),
                      borderRadius: BorderRadius.all(
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
    const CircularProgressIndicator(
      backgroundColor: ColorList.white,
      valueColor: AlwaysStoppedAnimation<Color>(
        ColorList.primaryMaterialColor,
      ),
    );
