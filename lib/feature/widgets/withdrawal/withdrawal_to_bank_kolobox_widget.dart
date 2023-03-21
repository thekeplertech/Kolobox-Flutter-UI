import 'package:flutter/material.dart';
import 'package:kolobox_new_app/core/base/base_screen.dart';
import 'package:kolobox_new_app/core/constants/image_constants.dart';
import 'package:kolobox_new_app/core/constants/kolo_box_icon.dart';
import 'package:kolobox_new_app/core/ui/style/app_style.dart';
import 'package:kolobox_new_app/routes/routes.dart';

import '../../../core/colors/color_list.dart';
import '../../../core/ui/widgets/button.dart';
import 'withdrawal_summary_kolobox_widget.dart';

class WithdrawalToBankKoloboxWidget extends BaseScreen {
  const WithdrawalToBankKoloboxWidget({Key? key}) : super(key: key);

  @override
  State<WithdrawalToBankKoloboxWidget> createState() =>
      _WithdrawalToBankKoloboxWidgetState();
}

class _WithdrawalToBankKoloboxWidgetState
    extends BaseScreenState<WithdrawalToBankKoloboxWidget> {
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
              'Withdraw to my bank account',
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
              style: AppStyle.b8SemiBold
                  .copyWith(color: ColorList.blackSecondColor),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              width: double.maxFinite,
              decoration: BoxDecoration(
                color: ColorList.lightBlue3Color,
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        KoloBoxIcons.bank,
                        size: 18,
                        color: ColorList.primaryColor,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Zenith Bank',
                        style: AppStyle.b8SemiBold
                            .copyWith(color: ColorList.blackSecondColor),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    '0949830020004',
                    style: AppStyle.b6Bold
                        .copyWith(color: ColorList.blackSecondColor),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    'Dami Anoreq',
                    style: AppStyle.b8Medium
                        .copyWith(color: ColorList.blackSecondColor),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Center(
              child: Container(
                decoration: BoxDecoration(
                    color: ColorList.lightBlue3Color,
                    borderRadius: BorderRadius.circular(32)),
                padding:
                    const EdgeInsets.symmetric(horizontal: 27, vertical: 17),
                child: IntrinsicWidth(
                  child: Row(
                    children: [
                      Text(
                        'Add Bank Account',
                        style: AppStyle.b7SemiBold
                            .copyWith(color: ColorList.primaryColor),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Icon(
                        KoloBoxIcons.bank,
                        size: 18,
                        color: ColorList.primaryColor,
                      ),
                    ],
                  ),
                ),
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
