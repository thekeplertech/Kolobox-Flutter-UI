import 'package:flutter/material.dart';
import 'package:kolobox_new_app/core/base/base_screen.dart';
import 'package:kolobox_new_app/core/constants/image_constants.dart';
import 'package:kolobox_new_app/core/ui/style/app_style.dart';
import 'package:kolobox_new_app/routes/routes.dart';

import '../../../core/colors/color_list.dart';
import '../../../core/ui/widgets/button.dart';
import 'cancel_investment_successfully.dart';

class CancelInvestmentWidget extends BaseScreen {
  const CancelInvestmentWidget({Key? key}) : super(key: key);

  @override
  State<CancelInvestmentWidget> createState() => _CancelInvestmentWidgetState();
}

class _CancelInvestmentWidgetState
    extends BaseScreenState<CancelInvestmentWidget> {
  @override
  Widget body(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 17, left: 28, right: 28, bottom: 31),
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
            'Cancel Investment',
            style: AppStyle.b4Bold.copyWith(color: ColorList.blackSecondColor),
          ),
          const SizedBox(
            height: 25,
          ),
          Text(
            'You are about to request for this Investment to be cancelled, If approved your investment and avalable interest would be deposited into your flex wallet.\n\nKindly note investment cancellation fee applies',
            style:
                AppStyle.b8Regular.copyWith(color: ColorList.blackThirdColor),
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            'Learn about our investment cancellation policy',
            style: AppStyle.b9Medium.copyWith(color: ColorList.primaryColor),
          ),
          const SizedBox(
            height: 22,
          ),
          Button(
            'Go back',
            backgroundColor: ColorList.lightBlue3Color,
            textColor: ColorList.primaryColor,
            overlayColor: ColorList.blueColor,
            borderRadius: 32,
            onPressed: () {
              goBack(context);
            },
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
              showCustomBottomSheet(const CancelInvestmentSuccessfullyWidget());
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
