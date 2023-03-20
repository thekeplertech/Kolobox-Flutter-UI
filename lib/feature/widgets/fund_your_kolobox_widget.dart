import 'package:flutter/material.dart';
import 'package:kolobox_new_app/core/base/base_screen.dart';
import 'package:kolobox_new_app/core/constants/image_constants.dart';
import 'package:kolobox_new_app/core/constants/kolo_box_icon.dart';
import 'package:kolobox_new_app/core/enums/kolobox_fund_enum.dart';
import 'package:kolobox_new_app/core/ui/style/app_style.dart';
import 'package:kolobox_new_app/routes/routes.dart';

import '../../core/colors/color_list.dart';
import 'deposit_your_kolobox_widget.dart';

class FundYourKoloboxWidget extends BaseScreen {
  const FundYourKoloboxWidget({Key? key}) : super(key: key);

  @override
  State<FundYourKoloboxWidget> createState() => _FundYourKoloboxWidgetState();
}

class _FundYourKoloboxWidgetState
    extends BaseScreenState<FundYourKoloboxWidget> {
  @override
  Widget body(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding:
            const EdgeInsets.only(top: 17, left: 28, right: 28, bottom: 10),
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
              'Fund your KoloBox',
              style:
                  AppStyle.b3Bold.copyWith(color: ColorList.blackSecondColor),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              'Deposit into your KoloBox',
              style:
                  AppStyle.b8Regular.copyWith(color: ColorList.blackThirdColor),
            ),
            const SizedBox(
              height: 38,
            ),
            Text(
              'Select a Product to proceed',
              style: AppStyle.b7SemiBold
                  .copyWith(color: ColorList.blackSecondColor),
            ),
            const SizedBox(
              height: 16,
            ),
            getOptionWidget(KoloboxFundEnum.koloFlex, ColorList.koloFlexColor,
                "Koloflex", ColorList.koloFlexTextColor, imageFlexIcon),
            const SizedBox(
              height: 18,
            ),
            getOptionWidget(
                KoloboxFundEnum.koloTarget,
                ColorList.blueLight2Color,
                "Kolotarget",
                ColorList.primaryColor,
                imageTargetIcon),
            const SizedBox(
              height: 18,
            ),
            getOptionWidget(
                KoloboxFundEnum.koloTargetPlus,
                ColorList.koloTargetPlusColor,
                "Kolotarget+",
                ColorList.blackSecondColor,
                imageTargetPlusIcon),
            const SizedBox(
              height: 18,
            ),
            getOptionWidget(
                KoloboxFundEnum.koloFamily,
                ColorList.koloFamilyColor,
                "Kolofamily",
                ColorList.koloFamilyTextColor,
                imageFamilyIcon),
            const SizedBox(
              height: 18,
            ),
            getOptionWidget(
                KoloboxFundEnum.koloGroup,
                ColorList.blackSecondColor,
                "Kologroup",
                ColorList.white,
                imageGroupIcon),
            const SizedBox(
              height: 18,
            ),
          ],
        ),
      ),
    );
  }

  Widget getOptionWidget(KoloboxFundEnum fundEnum, Color backColor,
      String title, Color titleColor, String icon) {
    return GestureDetector(
      onTap: () async {
        switch (fundEnum) {
          case KoloboxFundEnum.koloFlex:
          case KoloboxFundEnum.koloTarget:
          case KoloboxFundEnum.koloFamily:
          case KoloboxFundEnum.koloGroup:
            showCustomBottomSheet(const DepositYourKoloboxWidget(),
                height: 0.9);
            break;
          case KoloboxFundEnum.koloTargetPlus:
            comingSoon();
            break;
        }
      },
      child: Container(
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
            Icon(
              KoloBoxIcons.koloFlex,
              size: 48,
              color: ColorList.koloFlexTextColor.withOpacity(0.4),
            ),
            Image.asset(
              icon,
              width: 48,
              height: 48,
            ),
          ],
        ),
      ),
    );
  }
}
