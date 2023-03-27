import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kolobox_new_app/core/base/base_screen.dart';
import 'package:kolobox_new_app/core/constants/image_constants.dart';
import 'package:kolobox_new_app/core/enums/weekly_enum.dart';
import 'package:kolobox_new_app/core/ui/style/app_style.dart';
import 'package:kolobox_new_app/feature/widgets/recurring_deposit/models/month_day_model.dart';
import 'package:kolobox_new_app/routes/routes.dart';

import '../../../core/colors/color_list.dart';
import '../../../core/ui/widgets/button.dart';

class SelectRecurringDateMonthlyWidget extends BaseScreen {
  final Function(WeeklyEnum) onPop;

  const SelectRecurringDateMonthlyWidget({
    Key? key,
    required this.onPop,
  }) : super(key: key);

  @override
  State<SelectRecurringDateMonthlyWidget> createState() =>
      _SelectRecurringDateMonthlyWidgetState();
}

class _SelectRecurringDateMonthlyWidgetState
    extends BaseScreenState<SelectRecurringDateMonthlyWidget> {
  StreamController<int> dayStreamController = StreamController<int>.broadcast();
  int selectedDay = 1;

  List<MonthDayModel> days = [
    MonthDayModel(day: 31, isSelectable: false),
    MonthDayModel(day: 1, isSelected: true),
    MonthDayModel(day: 2),
    MonthDayModel(day: 3),
    MonthDayModel(day: 4),
    MonthDayModel(day: 5),
    MonthDayModel(day: 6),
    MonthDayModel(day: 7),
    MonthDayModel(day: 8),
    MonthDayModel(day: 9),
    MonthDayModel(day: 10),
    MonthDayModel(day: 11),
    MonthDayModel(day: 12),
    MonthDayModel(day: 13),
    MonthDayModel(day: 14),
    MonthDayModel(day: 15),
    MonthDayModel(day: 16),
    MonthDayModel(day: 17),
    MonthDayModel(day: 18),
    MonthDayModel(day: 19),
    MonthDayModel(day: 20),
    MonthDayModel(day: 21),
    MonthDayModel(day: 22),
    MonthDayModel(day: 23),
    MonthDayModel(day: 24),
    MonthDayModel(day: 25),
    MonthDayModel(day: 26),
    MonthDayModel(day: 27),
    MonthDayModel(day: 28),
    MonthDayModel(day: 29, isSelectable: false),
    MonthDayModel(day: 30, isSelectable: false),
    MonthDayModel(day: 31, isSelectable: false),
    MonthDayModel(day: 1, isSelectable: false),
    MonthDayModel(day: 2, isSelectable: false),
    MonthDayModel(day: 3, isSelectable: false),
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
                  'Monthly',
                  style: AppStyle.b4Bold.copyWith(color: ColorList.white),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            'Select a recurring day of each month',
            style:
                AppStyle.b8Regular.copyWith(color: ColorList.blackSecondColor),
          ),
          const SizedBox(
            height: 25,
          ),
          getMonthWidget(),
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
              // widget.onPop(weeklyEnum);
              goBack(context);
            },
          ),
        ],
      ),
    );
  }

  StreamBuilder<int> getMonthWidget() {
    return StreamBuilder<int>(
        initialData: selectedDay,
        stream: dayStreamController.stream,
        builder: (context, snapshot) {
          return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 7,
              ),
              itemCount: days.length,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (_, index) {
                MonthDayModel day = days[index];
                return Container(
                  padding: const EdgeInsets.all(5),
                  child: GestureDetector(
                    onTap: () {
                      if (!day.isSelectable) return;
                      selectedDay = day.day;
                      for (var element in days) {
                        element.isSelected = false;
                      }
                      day.isSelected = true;
                      print("asdf $selectedDay");
                      dayStreamController.add(selectedDay);
                    },
                    child: Container(
                      width: double.maxFinite,
                      height: double.maxFinite,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: day.isSelected
                            ? ColorList.primaryColor
                            : ColorList.white,
                      ),
                      child: Center(
                        child: Text(
                          day.day.toString(),
                          style: AppStyle.b7SemiBold.copyWith(
                              color: (day.isSelectable
                                  ? (day.isSelected
                                      ? ColorList.white
                                      : ColorList.blackSecondColor)
                                  : ColorList.greyLight13Color)),
                        ),
                      ),
                    ),
                  ),
                );
              });
        });
  }

  @override
  void dispose() {
    super.dispose();
    dayStreamController.close();
  }
}
