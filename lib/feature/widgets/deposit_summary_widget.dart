import 'package:flutter/material.dart';
import 'package:kolobox_new_app/core/constants/image_constants.dart';
import 'package:kolobox_new_app/core/ui/style/app_style.dart';
import 'package:kolobox_new_app/core/ui/widgets/button.dart';
import 'package:kolobox_new_app/routes/routes.dart';

import '../../core/base/base_screen.dart';
import '../../core/colors/color_list.dart';

class DepositSummaryWidget extends BaseScreen {
  const DepositSummaryWidget({Key? key}) : super(key: key);

  @override
  State<DepositSummaryWidget> createState() => _DepositSummaryWidgetState();
}

class _DepositSummaryWidgetState extends BaseScreenState<DepositSummaryWidget> {
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
              'Deposit Summary',
              style:
                  AppStyle.b3Bold.copyWith(color: ColorList.blackSecondColor),
            ),
            const SizedBox(
              height: 13,
            ),
            Button(
              'Edit',
              backgroundColor: ColorList.lightBlue3Color,
              textColor: ColorList.primaryColor,
              overlayColor: ColorList.blueColor,
              borderRadius: 32,
              onPressed: () {},
            ),
            const SizedBox(
              height: 20,
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
                          AppStyle.b8Regular.copyWith(color: ColorList.white),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      '₦ 0.00',
                      style: AppStyle.b3Bold.copyWith(color: ColorList.white),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 17,
            ),
            Text(
              'Deposit into my',
              style:
                  AppStyle.b9Regular.copyWith(color: ColorList.blackThirdColor),
            ),
            const SizedBox(
              height: 5,
            ),
            getOptionWidget(ColorList.koloFlexColor, "Koloflex",
                ColorList.koloFlexTextColor, imageFlexIcon),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Selected Investing towards',
                  style: AppStyle.b9Medium
                      .copyWith(color: ColorList.blackSecondColor),
                ),
                Text(
                  'Renting a new home',
                  style: AppStyle.b8SemiBold
                      .copyWith(color: ColorList.blackSecondColor),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Select payment option',
              style: AppStyle.b8SemiBold
                  .copyWith(color: ColorList.blackSecondColor),
            ),
            const SizedBox(
              height: 9,
            ),
            Container(
              decoration: BoxDecoration(
                color: ColorList.greyLight5Color,
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.only(
                  left: 14.5, right: 23, top: 12, bottom: 9),
              child: Row(
                children: [
                  Text(
                    'Paystack',
                    style: AppStyle.b7Regular
                        .copyWith(color: ColorList.blackSecondColor),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 18,
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

  Widget getOptionWidget(
      Color backColor, String title, Color titleColor, String icon) {
    return Container(
      decoration: BoxDecoration(
        color: backColor,
        borderRadius: BorderRadius.circular(14),
      ),
      padding: const EdgeInsets.all(24),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: AppStyle.b3Bold.copyWith(color: titleColor),
            ),
          ),
          Image.asset(
            icon,
            width: 48,
            height: 48,
          ),
        ],
      ),
    );
  }
}
