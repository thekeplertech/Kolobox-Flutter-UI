import 'package:flutter/material.dart';
import 'package:kolobox_new_app/core/base/base_screen.dart';
import 'package:kolobox_new_app/core/constants/image_constants.dart';
import 'package:kolobox_new_app/core/ui/style/app_style.dart';
import 'package:kolobox_new_app/routes/routes.dart';

import '../../core/colors/color_list.dart';
import '../../core/ui/widgets/button.dart';

class WithdrawalSelectionKoloboxWidget extends BaseScreen {
  const WithdrawalSelectionKoloboxWidget({Key? key}) : super(key: key);

  @override
  State<WithdrawalSelectionKoloboxWidget> createState() =>
      _WithdrawalSelectionKoloboxWidgetState();
}

class _WithdrawalSelectionKoloboxWidgetState
    extends BaseScreenState<WithdrawalSelectionKoloboxWidget> {
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
                  AppStyle.b3Bold.copyWith(color: ColorList.blackSecondColor),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Enter Amount',
              style:
                  AppStyle.b8Regular.copyWith(color: ColorList.blackThirdColor),
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
              decoration: BoxDecoration(
                color: ColorList.greyLight5Color,
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.all(13),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 7, bottom: 14),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Bank account',
                            style: AppStyle.b7Regular
                                .copyWith(color: ColorList.blackSecondColor),
                          ),
                        ),
                        Text('a'),
                      ],
                    ),
                  ),
                  Divider(
                      color: ColorList.lightBlue5Color,
                      height: 1,
                      thickness: 1),
                  Padding(
                    padding: const EdgeInsets.only(top: 14, bottom: 7),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            'My Wallet',
                            style: AppStyle.b7Regular
                                .copyWith(color: ColorList.blackSecondColor),
                          ),
                        ),
                        Text('a'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Button(
              'Next',
              backgroundColor: ColorList.primaryColor,
              textColor: ColorList.white,
              overlayColor: ColorList.blueColor,
              borderRadius: 32,
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
