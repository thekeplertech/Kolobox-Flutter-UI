import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kolobox_new_app/core/base/base_screen.dart';
import 'package:kolobox_new_app/core/constants/image_constants.dart';
import 'package:kolobox_new_app/core/constants/kolo_box_icon.dart';
import 'package:kolobox_new_app/core/enums/weekly_enum.dart';
import 'package:kolobox_new_app/core/ui/style/app_style.dart';
import 'package:kolobox_new_app/routes/routes.dart';

import '../../../core/colors/color_list.dart';
import '../../../core/ui/widgets/button.dart';

class SelectRecurringDateDailyWidget extends BaseScreen {
  final Function(WeeklyEnum) onPop;

  const SelectRecurringDateDailyWidget({
    Key? key,
    required this.onPop,
  }) : super(key: key);

  @override
  State<SelectRecurringDateDailyWidget> createState() =>
      _SelectRecurringDateDailyWidgetState();
}

class _SelectRecurringDateDailyWidgetState
    extends BaseScreenState<SelectRecurringDateDailyWidget> {
  StreamController<bool> hourStreamController =
      StreamController<bool>.broadcast();
  int hour = 12;

  StreamController<bool> minuteStreamController =
      StreamController<bool>.broadcast();
  int minute = 0;

  StreamController<bool> amPmStreamController =
      StreamController<bool>.broadcast();
  bool isAM = true;

  int isSelected = 0; // 0 means hour, 1 means minute & 2 means AM/PM

  @override
  Widget body(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 17, left: 28, right: 28, bottom: 31),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: () {
                goBack(context);
              },
              child: Image.asset(imageClose),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            'Select a recurring time',
            style: AppStyle.b4Bold.copyWith(color: ColorList.blackSecondColor),
          ),
          const SizedBox(
            height: 20,
          ),
          getTimeWidget(),
          const SizedBox(
            height: 20,
          ),
          Button(
            'Next',
            backgroundColor: ColorList.primaryColor,
            textColor: ColorList.white,
            overlayColor: ColorList.blueColor,
            borderRadius: 32,
            onPressed: () {
              // widget.onPop(weeklyEnum);
              goBack(context);
            },
          ),
        ],
      ),
    );
  }

  Widget getTimeWidget() => Row(
        children: [
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  isSelected = 0;
                  minuteStreamController.add(true);
                  amPmStreamController.add(true);

                  if (hour == 12) {
                    hour = 1;
                  } else {
                    hour++;
                  }

                  hourStreamController.add(true);
                },
                child: AbsorbPointer(
                  child: Container(
                    width: double.maxFinite,
                    padding: const EdgeInsets.all(10),
                    child: Icon(
                      KoloBoxIcons.upArrow,
                      size: 24,
                      color: ColorList.greyLight2Color,
                    ),
                  ),
                ),
              ),
              StreamBuilder<bool>(
                  stream: hourStreamController.stream,
                  builder: (context, snapshot) {
                    return Container(
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: isSelected == 0
                                ? ColorList.primaryColor
                                : ColorList.greyLight7Color,
                            width: 1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.all(15),
                      child: Center(
                        child: Text(
                          NumberFormat("00").format(hour),
                          style: (isSelected == 0
                                  ? AppStyle.b7SemiBold
                                  : AppStyle.b8Regular)
                              .copyWith(color: ColorList.blackSecondColor),
                        ),
                      ),
                    );
                  }),
              GestureDetector(
                onTap: () {
                  isSelected = 0;
                  minuteStreamController.add(true);
                  amPmStreamController.add(true);

                  if (hour == 1) {
                    hour = 12;
                  } else {
                    hour--;
                  }

                  hourStreamController.add(true);
                },
                child: AbsorbPointer(
                  child: Container(
                    width: double.maxFinite,
                    padding: const EdgeInsets.all(10),
                    child: Icon(
                      KoloBoxIcons.downArrow,
                      size: 24,
                      color: ColorList.greyLight2Color,
                    ),
                  ),
                ),
              ),
            ],
          )),
          getDotWidget(),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  isSelected = 1;
                  hourStreamController.add(true);
                  amPmStreamController.add(true);

                  if (minute == 59) {
                    minute = 0;
                  } else {
                    minute++;
                  }

                  minuteStreamController.add(true);
                },
                child: AbsorbPointer(
                  child: Container(
                    width: double.maxFinite,
                    padding: const EdgeInsets.all(10),
                    child: Icon(
                      KoloBoxIcons.upArrow,
                      size: 24,
                      color: ColorList.greyLight2Color,
                    ),
                  ),
                ),
              ),
              StreamBuilder<bool>(
                  stream: minuteStreamController.stream,
                  builder: (context, snapshot) {
                    return Container(
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: isSelected == 1
                                ? ColorList.primaryColor
                                : ColorList.greyLight7Color,
                            width: 1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.all(15),
                      child: Center(
                        child: Text(
                          NumberFormat("00").format(minute),
                          style: (isSelected == 1
                                  ? AppStyle.b7SemiBold
                                  : AppStyle.b8Regular)
                              .copyWith(color: ColorList.blackSecondColor),
                        ),
                      ),
                    );
                  }),
              GestureDetector(
                onTap: () {
                  isSelected = 1;
                  hourStreamController.add(true);
                  amPmStreamController.add(true);

                  if (minute == 0) {
                    minute = 59;
                  } else {
                    minute--;
                  }

                  minuteStreamController.add(true);
                },
                child: AbsorbPointer(
                  child: Container(
                    width: double.maxFinite,
                    padding: const EdgeInsets.all(10),
                    child: Icon(
                      KoloBoxIcons.downArrow,
                      size: 24,
                      color: ColorList.greyLight2Color,
                    ),
                  ),
                ),
              ),
            ],
          )),
          getDotWidget(),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  isSelected = 2;
                  hourStreamController.add(true);
                  minuteStreamController.add(true);

                  isAM = !isAM;
                  amPmStreamController.add(isAM);
                },
                child: AbsorbPointer(
                  child: Container(
                    width: double.maxFinite,
                    padding: const EdgeInsets.all(10),
                    child: Icon(
                      KoloBoxIcons.upArrow,
                      size: 24,
                      color: ColorList.greyLight2Color,
                    ),
                  ),
                ),
              ),
              StreamBuilder<bool>(
                  stream: amPmStreamController.stream,
                  builder: (context, snapshot) {
                    return Container(
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: isSelected == 2
                                ? ColorList.primaryColor
                                : ColorList.greyLight7Color,
                            width: 1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.all(15),
                      child: Center(
                        child: StreamBuilder<bool>(
                            stream: amPmStreamController.stream,
                            builder: (context, snapshot) => Text(
                                  isAM ? 'AM' : 'PM',
                                  style: (isSelected == 2
                                          ? AppStyle.b7SemiBold
                                          : AppStyle.b8Regular)
                                      .copyWith(
                                          color: ColorList.blackSecondColor),
                                )),
                      ),
                    );
                  }),
              GestureDetector(
                onTap: () {
                  isSelected = 2;
                  hourStreamController.add(true);
                  minuteStreamController.add(true);

                  isAM = !isAM;
                  amPmStreamController.add(isAM);
                },
                child: AbsorbPointer(
                  child: Container(
                    width: double.maxFinite,
                    padding: const EdgeInsets.all(10),
                    child: Icon(
                      KoloBoxIcons.downArrow,
                      size: 24,
                      color: ColorList.greyLight2Color,
                    ),
                  ),
                ),
              ),
            ],
          )),
        ],
      );

  Widget getDotWidget() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: ColorList.greyLight2Color,
              ),
              child: const SizedBox(
                width: 5,
                height: 5,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: ColorList.greyLight2Color,
              ),
              child: const SizedBox(
                width: 5,
                height: 5,
              ),
            ),
          ],
        ),
      );

  @override
  void dispose() {
    super.dispose();
    hourStreamController.close();
    minuteStreamController.close();
    amPmStreamController.close();
  }
}
