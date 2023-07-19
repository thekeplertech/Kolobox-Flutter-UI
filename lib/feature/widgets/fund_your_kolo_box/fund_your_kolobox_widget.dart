import 'package:flutter/material.dart';
import 'package:kolobox_new_app/core/base/base_screen.dart';
import 'package:kolobox_new_app/core/constants/image_constants.dart';
import 'package:kolobox_new_app/core/enums/kolobox_fund_enum.dart';
import 'package:kolobox_new_app/core/ui/style/app_style.dart';
import 'package:kolobox_new_app/feature/widgets/deposit/deposit_your_kolobox_widget_page.dart';
import 'package:kolobox_new_app/routes/routes.dart';

import '../../../core/colors/color_list.dart';
import '../inherited_state_container.dart';

class FundYourKoloboxWidget extends BaseScreen {
  const FundYourKoloboxWidget({Key? key}) : super(key: key);

  @override
  State<FundYourKoloboxWidget> createState() => _FundYourKoloboxWidgetState();
}

class _FundYourKoloboxWidgetState
    extends BaseScreenState<FundYourKoloboxWidget> {
  @override
  Widget body(BuildContext context) => Padding(
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
            getOptionWidget(KoloboxFundEnum.koloFlex),
            const SizedBox(
              height: 18,
            ),
            getOptionWidget(KoloboxFundEnum.koloTarget),
            const SizedBox(
              height: 18,
            ),
            // getOptionWidget(KoloboxFundEnum.koloTargetPlus),
            // const SizedBox(
            //   height: 18,
            // ),
            getOptionWidget(KoloboxFundEnum.koloFamily),
            const SizedBox(
              height: 18,
            ),
            getOptionWidget(KoloboxFundEnum.koloGroup),
            const SizedBox(
              height: 18,
            ),
          ],
        ),
      );

  Widget getOptionWidget(KoloboxFundEnum fundEnum) {
    return GestureDetector(
      onTap: () async {
        StateContainer.of(context).openFundMyKoloBox(fundEnum: fundEnum);
        switch (fundEnum) {
          case KoloboxFundEnum.koloFlex:
          case KoloboxFundEnum.koloTarget:
          case KoloboxFundEnum.koloFamily:
          case KoloboxFundEnum.koloGroup:
            showCustomBottomSheet(
              DepositYourKoloboxWidgetPage(
                key: Key(
                    'deposit_your_kolobox_${DateTime.now().millisecondsSinceEpoch}'),
              ),
            );
            break;
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: fundEnum.getFundBackColorValue,
          borderRadius: BorderRadius.circular(14),
        ),
        padding: const EdgeInsets.all(24),
        child: Row(
          children: [
            Expanded(
              child: Text(
                fundEnum.getFundValue,
                style: AppStyle.b3Bold
                    .copyWith(color: fundEnum.getFundTextColorValue),
              ),
            ),
            fundEnum.isPhotoEnabledAsIcon
                ? Icon(
                    fundEnum.getFundIconValue,
                    size: 48,
                    color: fundEnum.getFundIconColorValue.withOpacity(0.4),
                  )
                : Image.asset(
                    fundEnum.getFundImageValue,
                    width: 48,
                    height: 48,
                  ),
          ],
        ),
      ),
    );
  }
}
