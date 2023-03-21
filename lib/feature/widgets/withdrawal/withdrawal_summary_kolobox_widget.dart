import 'package:flutter/material.dart';
import 'package:kolobox_new_app/core/base/base_screen.dart';
import 'package:kolobox_new_app/core/constants/image_constants.dart';
import 'package:kolobox_new_app/core/ui/style/app_style.dart';
import 'package:kolobox_new_app/routes/routes.dart';

import '../../../core/colors/color_list.dart';
import '../../../core/constants/kolo_box_icon.dart';
import '../../../core/ui/widgets/button.dart';
import '../confirm_with_pin_widget.dart';

class WithdrawalSummaryKoloboxWidget extends BaseScreen {
  const WithdrawalSummaryKoloboxWidget({Key? key}) : super(key: key);

  @override
  State<WithdrawalSummaryKoloboxWidget> createState() =>
      _WithdrawalSummaryKoloboxWidgetState();
}

class _WithdrawalSummaryKoloboxWidgetState
    extends BaseScreenState<WithdrawalSummaryKoloboxWidget> {
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
              'Withdrawal Summary',
              style:
                  AppStyle.b4Bold.copyWith(color: ColorList.blackSecondColor),
            ),
            const SizedBox(height: 5),
            Text(
              'Withdraw to your bank account',
              style:
                  AppStyle.b9Regular.copyWith(color: ColorList.blackThirdColor),
            ),
            const SizedBox(height: 20),
            Button(
              'Edit',
              backgroundColor: ColorList.lightBlue3Color,
              textColor: ColorList.primaryColor,
              overlayColor: ColorList.blueColor,
              borderRadius: 32,
              onPressed: () {},
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              decoration: BoxDecoration(
                color: ColorList.primaryColor,
                borderRadius: BorderRadius.circular(12),
              ),
              width: double.maxFinite,
              padding: const EdgeInsets.all(20),
              child: Center(
                child: Column(
                  children: [
                    Text(
                      'Deposit Amount',
                      style:
                          AppStyle.b9Regular.copyWith(color: ColorList.white),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      '₦ 100,000.00',
                      style: AppStyle.b4Bold.copyWith(color: ColorList.white),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 25,
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
              height: 25,
            ),
            Button(
              'Next',
              backgroundColor: ColorList.primaryColor,
              textColor: ColorList.white,
              overlayColor: ColorList.blueColor,
              borderRadius: 32,
              onPressed: () {
                showCustomBottomSheet(const ConfirmWithPinWidget());
              },
            ),
          ],
        ),
      ),
    );
  }
}
