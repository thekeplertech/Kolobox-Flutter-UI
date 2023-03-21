import 'package:flutter/material.dart';
import 'package:kolobox_new_app/core/base/base_screen.dart';
import 'package:kolobox_new_app/core/constants/image_constants.dart';
import 'package:kolobox_new_app/core/ui/style/app_style.dart';
import 'package:kolobox_new_app/feature/widgets/withdrawal/withdrawal_summary_kolobox_widget.dart';
import 'package:kolobox_new_app/routes/routes.dart';

import '../../../core/colors/color_list.dart';
import '../../../core/ui/widgets/button.dart';

class WithdrawalToMyWalletKoloboxWidget extends BaseScreen {
  const WithdrawalToMyWalletKoloboxWidget({Key? key}) : super(key: key);

  @override
  State<WithdrawalToMyWalletKoloboxWidget> createState() =>
      _WithdrawalToMyWalletKoloboxWidgetState();
}

class _WithdrawalToMyWalletKoloboxWidgetState
    extends BaseScreenState<WithdrawalToMyWalletKoloboxWidget> {
  @override
  Widget body(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding:
            const EdgeInsets.only(top: 17, left: 28, right: 28, bottom: 31),
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
              'Withdrawal',
              style:
                  AppStyle.b4Bold.copyWith(color: ColorList.blackSecondColor),
            ),
            const SizedBox(height: 5),
            Text(
              'Withdraw to my wallet',
              style:
                  AppStyle.b9Regular.copyWith(color: ColorList.blackThirdColor),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Enter Amount',
              style:
                  AppStyle.b9Regular.copyWith(color: ColorList.blackThirdColor),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: ColorList.greyLightColor, width: 1),
                borderRadius: BorderRadius.circular(12),
              ),
              width: double.maxFinite,
              padding: const EdgeInsets.all(27),
              child: Center(
                child: Text(
                  '₦ 0.00',
                  style: AppStyle.b3Bold
                      .copyWith(color: ColorList.blackSecondColor),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              'Withdraw to',
              style: AppStyle.b9SemiBold
                  .copyWith(color: ColorList.blackSecondColor),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              width: double.maxFinite,
              decoration: BoxDecoration(
                color: ColorList.blueLight2Color,
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Wallet',
                    style: AppStyle.b3Bold
                        .copyWith(color: ColorList.blackSecondColor),
                  ),
                  Image.asset(imageWalletSuccessIconSelected,
                      width: 48, height: 48),
                ],
              ),
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
                showCustomBottomSheet(const WithdrawalSummaryKoloboxWidget());
              },
            ),
          ],
        ),
      ),
    );
  }
}
