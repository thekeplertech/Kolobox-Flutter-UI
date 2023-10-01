import 'package:flutter/material.dart';
import 'package:kolobox_new_app/core/enums/kolobox_fund_enum.dart';
import 'package:kolobox_new_app/core/ui/style/app_style.dart';

import '../../core/colors/color_list.dart';
import '../../core/constants/image_constants.dart';
import '../../core/ui/widgets/button.dart';
import '../../routes/routes.dart';

class KoloInfoWidget extends StatelessWidget {
  final bool isWallet;
  final KoloboxFundEnum? koloboxFundEnum;

  const KoloInfoWidget({
    Key? key,
    this.koloboxFundEnum,
    this.isWallet = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding:
            const EdgeInsets.only(top: 17, left: 28, right: 28, bottom: 31),
        child: Column(
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
            const SizedBox(
              height: 20,
            ),
            Container(
              decoration: BoxDecoration(
                color: koloboxFundEnum == null
                    ? ColorList.lightBlue13Color
                    : koloboxFundEnum!.getFundBackColorValue,
                shape: BoxShape.circle,
              ),
              padding: const EdgeInsets.all(45),
              child: koloboxFundEnum == null
                  ? Image.asset(
                      imageWalletInfoIcon,
                    )
                  : Icon(
                      koloboxFundEnum!.getFundIconValue,
                      size: 90,
                      color: koloboxFundEnum!.getFundIconColorValue,
                    ),
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              'Learn about ${(koloboxFundEnum == null) ? 'your wallet' : koloboxFundEnum!.getFundValue}',
              style:
                  AppStyle.b5Bold.copyWith(color: ColorList.blackSecondColor),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28),
              child: Text(
                getDesc(),
                style: AppStyle.b8Regular
                    .copyWith(color: ColorList.blackThirdColor),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(
              height: 35,
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
      ),
    );
  }

  String getDesc() {
    if (isWallet) {
      return 'Wallet Balances\nUnlocked Funds refer to investments in a flexible plan that allows you easy access to liquid funds just after a 30-day tenor and subsequently once every month\nLocked Funds refer to investments where funds are locked for tenors between 90, 180 days and above.\nWithdrawable Funds refer to matured funds from all products accessible to the user.';
    }
    switch (koloboxFundEnum) {
      case KoloboxFundEnum.koloFlex:
        return 'This is an unlocked plan that allows flexibility and liquidity of funds. Tenor: Investment is made for a period of 30 days. . Access: Withdrawal can be made anytime subsequently. . Interest rate: 6% annual percentage rate (APR)';
      case KoloboxFundEnum.koloTarget:
        return 'This is a locked plan aimed at individuals trying to save towards a target – a car, rent, school fees etc. . Tenor: return is expected on this class of investment over a period of 3 Months (90days). . Access: Withdrawal is not allowed till due date. . Interest rate: 8% annual percentage rate (APR).';
      case KoloboxFundEnum.koloGroup:
        return 'This is a locked collective plan where customers can now invest as a group, saving towards better financial opportunities e.g. cooperative society, association etc. . How to Use: A user will serve as the Administrator; set up, name the group, invite members and recommend amount and frequency. . Tenor: A fixed return is expected on this investment class over 6 months (180 days). . Access: Withdrawal is not allowed till the due date. . Interest rate: 10% annual percentage rate (APR)';
      case KoloboxFundEnum.koloFamily:
        return 'This is a locked collective plan where customers can now invest as a group, saving towards better financial opportunities e.g. cooperative society, association etc. . Tenor: A fixed return is expected on this investment class over 6 months (180 days). . Access: Withdrawal is not allowed till the due date. . Interest rate: 10% annual percentage rate (APR)';
      default:
        return '';
    }
  }
}
