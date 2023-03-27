import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kolobox_new_app/core/base/base_screen.dart';
import 'package:kolobox_new_app/core/constants/image_constants.dart';
import 'package:kolobox_new_app/core/enums/weekly_enum.dart';
import 'package:kolobox_new_app/core/ui/style/app_style.dart';
import 'package:kolobox_new_app/routes/routes.dart';

import '../../../core/colors/color_list.dart';
import '../../../core/ui/widgets/button.dart';

class SelectRecurringDateWeeklyWidget extends BaseScreen {
  final Function(WeeklyEnum) onPop;

  const SelectRecurringDateWeeklyWidget({
    Key? key,
    required this.onPop,
  }) : super(key: key);

  @override
  State<SelectRecurringDateWeeklyWidget> createState() =>
      _SelectRecurringDateWeeklyWidgetState();
}

class _SelectRecurringDateWeeklyWidgetState
    extends BaseScreenState<SelectRecurringDateWeeklyWidget> {
  StreamController<WeeklyEnum> weeklyStreamController =
      StreamController<WeeklyEnum>.broadcast();
  WeeklyEnum weeklyEnum = WeeklyEnum.monday;

  List<WeeklyEnum> weekly = [
    WeeklyEnum.monday,
    WeeklyEnum.tuesday,
    WeeklyEnum.wednesday,
    WeeklyEnum.thursday,
    WeeklyEnum.friday,
    WeeklyEnum.saturday,
    WeeklyEnum.sunday,
  ];

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
          Container(
            width: double.maxFinite,
            decoration: BoxDecoration(
                color: ColorList.primaryColor,
                borderRadius: BorderRadius.circular(12)),
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                Text(
                  'Recurring Date',
                  style: AppStyle.b9Medium.copyWith(color: ColorList.white),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  'Weekly',
                  style: AppStyle.b4Bold.copyWith(color: ColorList.white),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            'Select a recurring day of each week',
            style:
                AppStyle.b8Regular.copyWith(color: ColorList.blackSecondColor),
          ),
          const SizedBox(
            height: 15,
          ),
          StreamBuilder<WeeklyEnum>(
              initialData: weeklyEnum,
              stream: weeklyStreamController.stream,
              builder: (context, snapshot) {
                return ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: weekly.length,
                    itemBuilder: (_, index) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Button(
                          weekly[index].getWeeklyValue,
                          backgroundColor: ColorList.whiteColor,
                          overlayColor: ColorList.blueColor,
                          textColor: ColorList.blackSecondColor,
                          borderSide: BorderSide(
                              color: weekly[index] == weeklyEnum
                                  ? ColorList.primaryColor
                                  : ColorList.greyLight7Color,
                              width: 1),
                          borderRadius: 12,
                          textStyle: (weekly[index] == weeklyEnum
                                  ? AppStyle.b7SemiBold
                                  : AppStyle.b8Regular)
                              .copyWith(color: ColorList.blackSecondColor),
                          onPressed: () {
                            weeklyEnum = weekly[index];
                            weeklyStreamController.add(weeklyEnum);
                          },
                        ),
                      );
                    });
              }),
          const SizedBox(
            height: 25,
          ),
          Button(
            'Next',
            backgroundColor: ColorList.primaryColor,
            textColor: ColorList.white,
            overlayColor: ColorList.blueColor,
            borderRadius: 32,
            onPressed: () {
              widget.onPop(weeklyEnum);
              goBack(context);
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    weeklyStreamController.close();
  }
}
