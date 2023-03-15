import 'package:flutter/material.dart';
import 'package:kolobox_new_app/core/base/base_screen.dart';
import 'package:kolobox_new_app/core/constants/image_constants.dart';
import 'package:kolobox_new_app/core/ui/style/app_style.dart';
import 'package:kolobox_new_app/routes/routes.dart';

import '../../core/colors/color_list.dart';

class FundYourKoloboxWidget extends BaseScreen {
  const FundYourKoloboxWidget({Key? key}) : super(key: key);

  @override
  State<FundYourKoloboxWidget> createState() => _FundYourKoloboxWidgetState();
}

class _FundYourKoloboxWidgetState
    extends BaseScreenState<FundYourKoloboxWidget> {
  @override
  Widget body(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        goBack(context);
        return false;
      },
      child: SingleChildScrollView(
        child: Padding(
          padding:
              const EdgeInsets.only(top: 17, left: 28, right: 28, bottom: 68),
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
                style: AppStyle.b8Regular
                    .copyWith(color: ColorList.blackThirdColor),
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
              getOptionWidget(ColorList.koloFlexColor, "Koloflex",
                  ColorList.koloFlexTextColor, imageFlexIcon),
              const SizedBox(
                height: 18,
              ),
              getOptionWidget(ColorList.blueLight2Color, "Kolotarget",
                  ColorList.primaryColor, imageTargetIcon),
              const SizedBox(
                height: 18,
              ),
              getOptionWidget(ColorList.koloTargetPlusColor, "Kolotarget+",
                  ColorList.blackSecondColor, imageTargetPlusIcon),
              const SizedBox(
                height: 18,
              ),
              getOptionWidget(ColorList.koloFamilyColor, "Kolofamily",
                  ColorList.koloFamilyTextColor, imageFamilyIcon),
              const SizedBox(
                height: 18,
              ),
              getOptionWidget(ColorList.blackSecondColor, "Kologroup",
                  ColorList.white, imageGroupIcon),
              const SizedBox(
                height: 18,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getOptionWidget(
      Color backColor, String title, Color titleColor, String icon) {
    return GestureDetector(
      onTap: () async {
        goBack(context);
        // print('eer');
        // showCustomBottomSheet(const DepositYourKoloboxWidget()).then((value) {
        //   print('asdf');
        //   BlocProvider.of<DashboardBloc>(context)
        //       .add(ShowEnableBottomScreenEvent());
        // });
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
