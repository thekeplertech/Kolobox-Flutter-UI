import 'package:flutter/material.dart';
import 'package:kolobox_new_app/core/colors/color_list.dart';
import 'package:kolobox_new_app/core/constants/kolo_box_icon.dart';
import 'package:kolobox_new_app/core/ui/style/app_style.dart';
import 'package:kolobox_new_app/core/ui/widgets/currency_text_input_formatter.dart';
import 'package:kolobox_new_app/core/utils/date_helper.dart';
import 'package:kolobox_new_app/feature/dashboard/data/models/investment_goal_response_model.dart';

import '../../../../core/enums/kolobox_fund_enum.dart';

class KoloTargetItemWidget extends StatelessWidget {
  final InvestmentGoalModel model;
  final KoloboxFundEnum koloboxFundEnum;
  final bool isPaid;
  final String amount;
  final Function() onPressed;

  const KoloTargetItemWidget({
    Key? key,
    this.isPaid = false,
    required this.onPressed,
    required this.model,
    required this.amount,
    this.koloboxFundEnum = KoloboxFundEnum.koloTarget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onPressed();
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: ColorList.greyLight11Color, width: 1)),
        padding:
            const EdgeInsets.only(left: 10, right: 10, top: 12, bottom: 10),
        child: Column(
          children: [
            Row(
              children: [
                Icon(
                  koloboxFundEnum.getFundIconValue,
                  size: 24,
                  color: isPaid
                      ? ColorList.greyLight2Color
                      : koloboxFundEnum.getFundIconColorValue,
                ),
                const SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        model.purpose ?? '',
                        style: AppStyle.b7Bold
                            .copyWith(color: ColorList.blackSecondColor),
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      Text(
                        CurrencyTextInputFormatter.formatAmount(amount),
                        style: AppStyle.b8SemiBold
                            .copyWith(color: ColorList.primaryColor),
                      ),
                    ],
                  ),
                ),
                const Icon(
                  KoloBoxIcons.forwardArrow,
                  size: 15,
                  color: ColorList.lightBlue8Color,
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: ColorList.lightBlue9Color,
              ),
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
              child: Row(
                children: [
                  Text(
                    'End date',
                    style: AppStyle.b9Medium
                        .copyWith(color: ColorList.greyLight12Color),
                  ),
                  const SizedBox(
                    width: 3,
                  ),
                  Text(
                    DateHelper.getDateFromDateTime(
                        model.dueDate ?? '', 'dd MMM yyyy'),
                    style: AppStyle.b9SemiBold.copyWith(
                        color: isPaid
                            ? ColorList.redDarkColor
                            : ColorList.blackSecondColor),
                  ),
                  const Spacer(),
                  Text(
                    'Target',
                    style: AppStyle.b9Medium
                        .copyWith(color: ColorList.greyLight12Color),
                  ),
                  const SizedBox(
                    width: 3,
                  ),
                  Text(
                    CurrencyTextInputFormatter.formatAmountDouble(
                        model.goalAmount),
                    style: AppStyle.b9SemiBold
                        .copyWith(color: ColorList.primaryColor),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
