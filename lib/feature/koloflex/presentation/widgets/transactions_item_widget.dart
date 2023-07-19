import 'package:flutter/material.dart';
import 'package:kolobox_new_app/core/ui/widgets/currency_text_input_formatter.dart';
import 'package:kolobox_new_app/core/utils/date_helper.dart';
import 'package:kolobox_new_app/feature/dashboard/data/models/transactions_data_model.dart';

import '../../../../core/colors/color_list.dart';
import '../../../../core/constants/kolo_box_icon.dart';
import '../../../../core/ui/style/app_style.dart';
import '../../../dashboard/data/models/group_transactions_data_model.dart';

class TransactionsItemWidget extends StatelessWidget {
  final Function() onPressed;
  final Transactions? transactions;
  final GroupTransactions? groupTransactions;

  const TransactionsItemWidget({
    Key? key,
    required this.onPressed,
    this.transactions,
    this.groupTransactions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: AbsorbPointer(
        child: Column(
          children: [
            const SizedBox(
              height: 12,
            ),
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: !isDeposit()
                          ? ColorList.redLightColor
                          : ColorList.lightBlue6Color,
                      shape: BoxShape.circle),
                  padding: const EdgeInsets.all(15),
                  child: Icon(
                    !isDeposit()
                        ? KoloBoxIcons.withdrawal
                        : KoloBoxIcons.deposit,
                    size: 12,
                    color: !isDeposit()
                        ? ColorList.redDarkColor
                        : ColorList.primaryColor,
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        isDeposit() ? 'Deposit' : 'Withdrawal',
                        style: AppStyle.b8SemiBold
                            .copyWith(color: ColorList.blackSecondColor),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        (transactions?.createdAt != null
                            ? DateHelper.getDateFromDateTime(
                                transactions?.createdAt,
                                'MMM dd, yyyy - hh:mm a')
                            : (groupTransactions?.createdAt != null
                                ? DateHelper.getDateFromDateTime(
                                    groupTransactions?.createdAt,
                                    'MMM dd, yyyy - hh:mm a')
                                : '')),
                        style: AppStyle.b10SemiBold
                            .copyWith(color: ColorList.greyLight2Color),
                      ),
                    ],
                  ),
                ),
                Text(
                  (transactions != null
                      ? CurrencyTextInputFormatter.formatAmount(isDeposit()
                          ? transactions?.depositAmount
                          : transactions?.withdrawalAmount)
                      : (groupTransactions != null
                          ? CurrencyTextInputFormatter.formatAmount(
                              groupTransactions?.totalAmount)
                          : '')),
                  style: AppStyle.b8SemiBold
                      .copyWith(color: ColorList.blackSecondColor),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Divider(
                thickness: 1,
                height: 1,
                color: ColorList.greyDisableCircleColor),
          ],
        ),
      ),
    );
  }

  bool isDeposit() => transactions != null
      ? double.parse(transactions?.depositAmount ?? '0') != 0
      : true;
}
