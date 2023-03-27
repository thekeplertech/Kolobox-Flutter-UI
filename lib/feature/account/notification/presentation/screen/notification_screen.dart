import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kolobox_new_app/core/colors/color_list.dart';
import 'package:kolobox_new_app/core/constants/image_constants.dart';
import 'package:kolobox_new_app/core/ui/style/app_style.dart';

import '../../../../../core/base/base_bloc_widget.dart';
import '../../../../../core/ui/widgets/flutter_custom_switch.dart';
import '../../../../../core/ui/widgets/no_app_bar.dart';
import '../../../../../core/ui/widgets/no_overflow_scrollbar_behaviour.dart';
import '../../../../widgets/home_app_bar_widget.dart';

class NotificationScreen extends BaseBlocWidget {
  const NotificationScreen({
    Key? key,
  }) : super(key: key);

  @override
  NotificationState createState() => NotificationState();
}

class NotificationState extends BaseBlocWidgetState<NotificationScreen> {
  StreamController<bool> smsAlertStreamController =
      StreamController<bool>.broadcast();
  bool isSMSAlert = false;

  StreamController<bool> emailAlertStreamController =
      StreamController<bool>.broadcast();
  bool isEmailAlert = false;

  StreamController<bool> pushNotificationStreamController =
      StreamController<bool>.broadcast();
  bool isPushNotification = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget getCustomBloc() {
    return Scaffold(
      backgroundColor: ColorList.white,
      appBar: const NoAppBar(),
      body: ScrollConfiguration(
        behavior: NoOverFlowScrollbarBehaviour(),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const HomeAppBarWidget(
                  leftIcon: imageBackArrowIcon, title: 'Notification'),
              Padding(
                padding: const EdgeInsets.only(
                    left: 28, right: 28, top: 20, bottom: 28),
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        isSMSAlert = !isSMSAlert;
                        smsAlertStreamController.add(true);
                      },
                      child: StreamBuilder<bool>(
                          stream: smsAlertStreamController.stream,
                          builder: (context, snapshot) {
                            return AbsorbPointer(
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'SMS Alert',
                                      style: AppStyle.b8Medium.copyWith(
                                          color: ColorList.blackSecondColor),
                                    ),
                                    FlutterCustomSwitch(
                                      value: isSMSAlert,
                                      onChanged: (value) {},
                                      activeColor: ColorList.lightBlue14Color,
                                      borderColor: isSMSAlert
                                          ? ColorList.lightBlue14Color
                                          : ColorList.greyLight14Color,
                                      inActiveColor: ColorList.greyLight14Color,
                                      activeThumbColor: ColorList.primaryColor,
                                      inActiveThumbColor:
                                          ColorList.blackSecondColor,
                                    )
                                  ],
                                ),
                              ),
                            );
                          }),
                    ),
                    Divider(
                        color: ColorList.greyDisableCircleColor,
                        height: 10,
                        thickness: 1),
                    InkWell(
                      onTap: () {
                        isEmailAlert = !isEmailAlert;
                        emailAlertStreamController.add(true);
                      },
                      child: StreamBuilder<bool>(
                          stream: emailAlertStreamController.stream,
                          builder: (context, snapshot) {
                            return AbsorbPointer(
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Email Alert',
                                      style: AppStyle.b8Medium.copyWith(
                                          color: ColorList.blackSecondColor),
                                    ),
                                    FlutterCustomSwitch(
                                      value: isEmailAlert,
                                      onChanged: (value) {},
                                      activeColor: ColorList.lightBlue14Color,
                                      borderColor: isEmailAlert
                                          ? ColorList.lightBlue14Color
                                          : ColorList.greyLight14Color,
                                      inActiveColor: ColorList.greyLight14Color,
                                      activeThumbColor: ColorList.primaryColor,
                                      inActiveThumbColor:
                                          ColorList.blackSecondColor,
                                    )
                                  ],
                                ),
                              ),
                            );
                          }),
                    ),
                    Divider(
                        color: ColorList.greyDisableCircleColor,
                        height: 10,
                        thickness: 1),
                    InkWell(
                      onTap: () {
                        isPushNotification = !isPushNotification;
                        pushNotificationStreamController.add(true);
                      },
                      child: StreamBuilder<bool>(
                          stream: pushNotificationStreamController.stream,
                          builder: (context, snapshot) {
                            return AbsorbPointer(
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Push Notification',
                                      style: AppStyle.b8Medium.copyWith(
                                          color: ColorList.blackSecondColor),
                                    ),
                                    FlutterCustomSwitch(
                                      value: isPushNotification,
                                      onChanged: (value) {},
                                      activeColor: ColorList.lightBlue14Color,
                                      borderColor: isPushNotification
                                          ? ColorList.lightBlue14Color
                                          : ColorList.greyLight14Color,
                                      inActiveColor: ColorList.greyLight14Color,
                                      activeThumbColor: ColorList.primaryColor,
                                      inActiveThumbColor:
                                          ColorList.blackSecondColor,
                                    )
                                  ],
                                ),
                              ),
                            );
                          }),
                    ),
                    Divider(
                        color: ColorList.greyDisableCircleColor,
                        height: 10,
                        thickness: 1),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    smsAlertStreamController.close();
    emailAlertStreamController.close();
    pushNotificationStreamController.close();
  }
}
