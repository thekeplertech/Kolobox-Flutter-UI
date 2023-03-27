import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kolobox_new_app/core/base/base_screen.dart';
import 'package:kolobox_new_app/core/constants/image_constants.dart';
import 'package:kolobox_new_app/core/ui/extension.dart';
import 'package:kolobox_new_app/core/ui/style/app_style.dart';
import 'package:kolobox_new_app/routes/routes.dart';

import '../../../core/colors/color_list.dart';
import '../../../core/ui/widgets/button.dart';

class SelectRecurringPeriodWidget extends BaseScreen {
  final Function(PeriodEnum) onPop;
  final PeriodEnum periodEnum;

  const SelectRecurringPeriodWidget({
    Key? key,
    required this.periodEnum,
    required this.onPop,
  }) : super(key: key);

  @override
  State<SelectRecurringPeriodWidget> createState() =>
      _SelectRecurringPeriodWidgetState();
}

class _SelectRecurringPeriodWidgetState
    extends BaseScreenState<SelectRecurringPeriodWidget> {
  StreamController<PeriodEnum> periodStreamController =
      StreamController<PeriodEnum>.broadcast();
  PeriodEnum periodEnum = PeriodEnum.monthly;

  List<PeriodEnum> periods = [
    PeriodEnum.monthly,
    PeriodEnum.weekly,
    PeriodEnum.daily,
  ];

  @override
  void initState() {
    super.initState();
    periodEnum = widget.periodEnum;
  }

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
            'Select a recurring period',
            style:
                AppStyle.b8Regular.copyWith(color: ColorList.blackSecondColor),
          ),
          const SizedBox(
            height: 15,
          ),
          StreamBuilder<PeriodEnum>(
              initialData: periodEnum,
              stream: periodStreamController.stream,
              builder: (context, snapshot) {
                return ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: periods.length,
                    itemBuilder: (_, index) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Button(
                          periods[index].getPeriodValue,
                          backgroundColor: ColorList.whiteColor,
                          overlayColor: ColorList.blueColor,
                          textColor: ColorList.blackSecondColor,
                          borderSide: BorderSide(
                              color: periods[index] == periodEnum
                                  ? ColorList.primaryColor
                                  : ColorList.greyLight7Color,
                              width: 1),
                          borderRadius: 12,
                          textStyle: (periods[index] == periodEnum
                                  ? AppStyle.b7SemiBold
                                  : AppStyle.b8Regular)
                              .copyWith(color: ColorList.blackSecondColor),
                          onPressed: () {
                            periodEnum = periods[index];
                            periodStreamController.add(periodEnum);
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
              widget.onPop(periodEnum);
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
    periodStreamController.close();
  }
}
