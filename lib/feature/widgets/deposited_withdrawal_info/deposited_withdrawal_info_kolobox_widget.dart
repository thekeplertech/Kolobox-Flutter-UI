import 'package:flutter/material.dart';
import 'package:kolobox_new_app/core/constants/kolo_box_icon.dart';
import 'package:kolobox_new_app/core/enums/kolobox_fund_enum.dart';
import 'package:kolobox_new_app/core/ui/style/app_style.dart';
import 'package:kolobox_new_app/core/ui/widgets/button.dart';
import 'package:kolobox_new_app/core/ui/widgets/currency_text_input_formatter.dart';
import 'package:kolobox_new_app/feature/dashboard/data/models/transactions_data_model.dart';
import 'package:kolobox_new_app/routes/routes.dart';

import '../../../../../core/base/base_screen.dart';
import '../../../../../core/colors/color_list.dart';
import '../../../core/utils/date_helper.dart';

class DepositedWithdrawalInfoKoloboxWidget extends BaseScreen {
  final Transactions transactions;

  const DepositedWithdrawalInfoKoloboxWidget({
    Key? key,
    required this.transactions,
  }) : super(key: key);

  @override
  State<DepositedWithdrawalInfoKoloboxWidget> createState() =>
      _DepositedWithdrawalInfoKoloboxWidgetState();
}

class _DepositedWithdrawalInfoKoloboxWidgetState
    extends BaseScreenState<DepositedWithdrawalInfoKoloboxWidget> {
  @override
  Widget body(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 25, left: 28, right: 28, bottom: 31),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: !isDeposit()
                  ? ColorList.redLightColor
                  : ColorList.lightBlue6Color,
              shape: BoxShape.circle,
            ),
            padding: const EdgeInsets.all(25),
            child: Icon(
              !isDeposit() ? KoloBoxIcons.withdrawal : KoloBoxIcons.deposit,
              size: 20,
              color: !isDeposit()
                  ? ColorList.redDarkColor
                  : ColorList.primaryColor,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            isDeposit() ? 'Deposited' : 'Withdrawal',
            style: AppStyle.b4Bold.copyWith(color: ColorList.blackSecondColor),
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            CurrencyTextInputFormatter.formatAmount(isDeposit()
                ? widget.transactions.depositAmount
                : widget.transactions.withdrawalAmount),
            style: AppStyle.b5SemiBold.copyWith(color: ColorList.primaryColor),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            DateHelper.getDateFromDateTime(
                widget.transactions.createdAt, 'MMM dd, yyyy - hh:mm a'),
            style:
                AppStyle.b9SemiBold.copyWith(color: ColorList.greyLight2Color),
          ),
          const SizedBox(
            height: 18,
          ),
          Text(
            'Ref',
            style:
                AppStyle.b9SemiBold.copyWith(color: ColorList.greyLight2Color),
          ),
          const SizedBox(
            height: 3,
          ),
          Text(
            '092829-20991090009w0220',
            style: AppStyle.b8Medium.copyWith(color: ColorList.blackThirdColor),
          ),
          const SizedBox(
            height: 30,
          ),
          Text(
            '${isDeposit() ? 'Deposit' : 'Withdrawal'} destination',
            style:
                AppStyle.b8SemiBold.copyWith(color: ColorList.blackSecondColor),
          ),
          const SizedBox(
            height: 8,
          ),
          getOptionWidget(),
          const SizedBox(
            height: 20,
          ),
          Button(
            'Share',
            backgroundColor: ColorList.lightBlue3Color,
            textColor: ColorList.primaryColor,
            overlayColor: ColorList.blueColor,
            borderRadius: 32,
            onPressed: () {
              comingSoon();
            },
          ),
          const SizedBox(
            height: 20,
          ),
          Button(
            'Ok',
            backgroundColor: ColorList.primaryColor,
            textColor: ColorList.white,
            overlayColor: ColorList.blueColor,
            borderRadius: 32,
            onPressed: () {
              goBack(context);
            },
          ),
        ],
      ),
    );
  }

  Widget getOptionWidget() {
    KoloboxFundEnum? koloboxFundEnum =
        widget.transactions.productId?.getEnumFromProductId();
    return GestureDetector(
      onTap: () async {
        // switch (fundEnum) {
        //   case KoloboxFundEnum.koloFlex:
        //   case KoloboxFundEnum.koloTarget:
        //   case KoloboxFundEnum.koloFamily:
        //   case KoloboxFundEnum.koloGroup:
        //     showCustomBottomSheet(
        //         DepositYourKoloboxWidget(
        //           koloboxFundEnum: fundEnum,
        //         ),
        //         height: 0.9);
        //     break;
        //   case KoloboxFundEnum.koloTargetPlus:
        //     comingSoon();
        //     break;
        // }
      },
      child: Container(
        decoration: BoxDecoration(
          color: koloboxFundEnum!.getFundBackColorValue,
          borderRadius: BorderRadius.circular(14),
        ),
        padding: const EdgeInsets.all(24),
        child: Row(
          children: [
            Expanded(
              child: Text(
                koloboxFundEnum.getFundValue,
                style: AppStyle.b3Bold
                    .copyWith(color: koloboxFundEnum.getFundTextColorValue),
              ),
            ),
            koloboxFundEnum.isPhotoEnabledAsIcon
                ? Icon(
                    koloboxFundEnum.getFundIconValue,
                    size: 48,
                    color:
                        koloboxFundEnum.getFundIconColorValue.withOpacity(0.4),
                  )
                : Image.asset(
                    koloboxFundEnum.getFundImageValue,
                    width: 48,
                    height: 48,
                  ),
          ],
        ),
      ),
    );
  }

  bool isDeposit() =>
      double.parse(widget.transactions.depositAmount ?? '0') != 0;
}
