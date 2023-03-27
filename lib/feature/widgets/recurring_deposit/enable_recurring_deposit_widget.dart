import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kolobox_new_app/core/base/base_screen.dart';
import 'package:kolobox_new_app/core/constants/image_constants.dart';
import 'package:kolobox_new_app/core/constants/kolo_box_icon.dart';
import 'package:kolobox_new_app/core/enums/period_enum.dart';
import 'package:kolobox_new_app/core/enums/weekly_enum.dart';
import 'package:kolobox_new_app/core/ui/style/app_style.dart';
import 'package:kolobox_new_app/core/ui/widgets/currency_text_input_formatter.dart';
import 'package:kolobox_new_app/feature/widgets/recurring_deposit/select_recurring_date_weekly_widget.dart';
import 'package:kolobox_new_app/feature/widgets/recurring_deposit/select_recurring_period_widget.dart';
import 'package:kolobox_new_app/routes/routes.dart';

import '../../../core/colors/color_list.dart';
import '../../../core/ui/widgets/button.dart';
import '../../../core/ui/widgets/custom_text_field.dart';
import 'enable_recurring_deposit_summary_widget.dart';

class EnableRecurringDepositWidget extends BaseScreen {
  const EnableRecurringDepositWidget({Key? key}) : super(key: key);

  @override
  State<EnableRecurringDepositWidget> createState() =>
      _EnableRecurringDepositWidgetState();
}

class _EnableRecurringDepositWidgetState
    extends BaseScreenState<EnableRecurringDepositWidget> {
  TextEditingController nameTextEditingController = TextEditingController();

  StreamController<PeriodEnum> periodStreamController =
      StreamController<PeriodEnum>.broadcast();
  PeriodEnum selectedPeriodEnum = PeriodEnum.monthly;

  StreamController<WeeklyEnum> weeklyStreamController =
      StreamController<WeeklyEnum>.broadcast();
  WeeklyEnum selectedWeeklyEnum = WeeklyEnum.monday;

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
          Text(
            'Recurring deposit',
            style: AppStyle.b4Bold.copyWith(color: ColorList.blackSecondColor),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            'Setup your recurring deposit',
            style:
                AppStyle.b9Regular.copyWith(color: ColorList.blackThirdColor),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            'Select recurring period',
            style:
                AppStyle.b8Medium.copyWith(color: ColorList.blackSecondColor),
          ),
          const SizedBox(
            height: 7,
          ),
          StreamBuilder<PeriodEnum>(
              initialData: selectedPeriodEnum,
              stream: periodStreamController.stream,
              builder: (context, snapshot) {
                return CustomTextField(
                  selectedPeriodEnum.getPeriodValue,
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  textCapitalization: TextCapitalization.words,
                  onPressed: () {
                    showCustomBottomSheet(SelectRecurringPeriodWidget(
                      periodEnum: selectedPeriodEnum,
                      onPop: (periodEnum) {
                        logger?.d("result $periodEnum");
                        selectedPeriodEnum = periodEnum;
                        periodStreamController.add(selectedPeriodEnum);
                      },
                    ));
                  },
                  iconData: KoloBoxIcons.downArrow,
                );
              }),
          const SizedBox(
            height: 15,
          ),
          Text(
            'Select recurring date',
            style:
                AppStyle.b8Medium.copyWith(color: ColorList.blackSecondColor),
          ),
          const SizedBox(
            height: 7,
          ),
          CustomTextField(
            'Select date',
            keyboardType: TextInputType.name,
            textInputAction: TextInputAction.next,
            textCapitalization: TextCapitalization.words,
            onPressed: () {
              showCustomBottomSheet(SelectRecurringDateWeeklyWidget(
                onPop: (weeklyEnum) {
                  logger?.d("result $weeklyEnum");
                },
              ));
            },
            postIcon: imageCalendar,
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            'Enter recurring deposit',
            style:
                AppStyle.b9Regular.copyWith(color: ColorList.blackThirdColor),
          ),
          const SizedBox(
            height: 7,
          ),
          CustomTextField(
            '₦ 0.00',
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.done,
            textCapitalization: TextCapitalization.none,
            inputFormatter: [
              CurrencyTextInputFormatter(
                name: '₦ ',
              )
            ],
            textStyle:
                AppStyle.b3Bold.copyWith(color: ColorList.blackSecondColor),
            hintStyle:
                AppStyle.b3Bold.copyWith(color: ColorList.blackSecondColor),
            textAlign: TextAlign.center,
            // controller: emailTextEditingController,
          ),
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
              hideKeyboard();
              showCustomBottomSheet(
                  const EnableRecurringDepositSummaryWidget());
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
    weeklyStreamController.close();
  }
}
