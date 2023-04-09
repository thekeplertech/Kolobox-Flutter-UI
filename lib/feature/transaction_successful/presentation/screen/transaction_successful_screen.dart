import 'package:flutter/material.dart';
import 'package:kolobox_new_app/core/colors/color_list.dart';
import 'package:kolobox_new_app/core/constants/kolo_box_icon.dart';
import 'package:kolobox_new_app/core/ui/style/app_style.dart';

import '../../../../../core/base/base_bloc_widget.dart';
import '../../../../core/constants/image_constants.dart';
import '../../../../core/enums/kolobox_fund_enum.dart';
import '../../../../core/ui/widgets/button.dart';

class TransactionSuccessfulScreen extends BaseBlocWidget {
  const TransactionSuccessfulScreen({
    Key? key,
  }) : super(key: key);

  @override
  TransactionSuccessfulScreenState createState() =>
      TransactionSuccessfulScreenState();
}

class TransactionSuccessfulScreenState
    extends BaseBlocWidgetState<TransactionSuccessfulScreen>
    with TickerProviderStateMixin {
  // late AnimationController scaleController = AnimationController(
  //     duration: const Duration(milliseconds: 800), vsync: this);
  // late Animation<double> scaleAnimation =
  //     CurvedAnimation(parent: scaleController, curve: Curves.elasticOut);
  // late AnimationController checkController =
  //     AnimationController(duration: const Duration(seconds: 2), vsync: this);
  // late Animation<double> checkAnimation =
  //     CurvedAnimation(parent: checkController, curve: Curves.linearToEaseOut);

  @override
  void initState() {
    super.initState();
    // scaleController.addStatusListener((status) {
    //   if (status == AnimationStatus.completed) {
    //     checkController.forward();
    //   }
    // });
    // scaleController.forward();
  }

  @override
  Widget getCustomBloc() {
    // double circleSize = 140;
    // double iconSize = 108;
    //
    // return Stack(
    //   children: [
    //     Center(
    //       child: ScaleTransition(
    //         scale: scaleAnimation,
    //         child: Container(
    //           height: circleSize,
    //           width: circleSize,
    //           decoration: BoxDecoration(
    //             color: ColorList.accentMaterialColor,
    //             shape: BoxShape.circle,
    //           ),
    //         ),
    //       ),
    //     ),
    //     SizeTransition(
    //       sizeFactor: checkAnimation,
    //       axis: Axis.horizontal,
    //       axisAlignment: -1,
    //       child: Center(
    //         child:
    //             Icon(Icons.check_rounded, color: Colors.white, size: iconSize),
    //       ),
    //     ),
    //   ],
    // );
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: ColorList.white,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 30),
          child: Column(
            children: [
              Expanded(
                  child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 22,
                    ),
                    Image.asset(imageConfirm),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      'Transaction Successful',
                      style: AppStyle.b4Bold
                          .copyWith(color: ColorList.blackSecondColor),
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    Text(
                      'This transaction was successful',
                      style: AppStyle.b8Medium
                          .copyWith(color: ColorList.blackThirdColor),
                    ),
                    const SizedBox(
                      height: 17,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: ColorList.lightBlue6Color,
                        shape: BoxShape.circle,
                      ),
                      padding: const EdgeInsets.all(25),
                      child: Icon(
                        KoloBoxIcons.deposit,
                        size: 20,
                        color: ColorList.primaryColor,
                      ),
                    ),
                    const SizedBox(
                      height: 17,
                    ),
                    Text(
                      'Deposited',
                      style: AppStyle.b4Bold
                          .copyWith(color: ColorList.blackSecondColor),
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    Text(
                      '₦ 14,200.00',
                      style: AppStyle.b5SemiBold
                          .copyWith(color: ColorList.primaryColor),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Aug 02, 2022 - 11:34 PM',
                      style: AppStyle.b9SemiBold
                          .copyWith(color: ColorList.greyLight2Color),
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    Text(
                      'Ref',
                      style: AppStyle.b9SemiBold
                          .copyWith(color: ColorList.greyLight2Color),
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    Text(
                      '092829-20991090009w0220',
                      style: AppStyle.b8Medium
                          .copyWith(color: ColorList.blackThirdColor),
                    ),
                  ],
                ),
              )),
              Column(
                children: [
                  Text(
                    'Deposit destination',
                    style: AppStyle.b8SemiBold
                        .copyWith(color: ColorList.blackSecondColor),
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  // getOptionWidget(StateContainer.of(context).koloboxFundEnum),
                  // Container(
                  //   decoration: BoxDecoration(
                  //     color: ColorList.lightBlue3Color,
                  //     borderRadius: BorderRadius.circular(14),
                  //   ),
                  //   padding: const EdgeInsets.symmetric(
                  //       horizontal: 20, vertical: 20),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     children: [
                  //       Text(
                  //         'Wallet',
                  //         style: AppStyle.b3Bold
                  //             .copyWith(color: ColorList.blackSecondColor),
                  //       ),
                  //       Image.asset(imageWalletSuccessIconSelected),
                  //     ],
                  //   ),
                  // ),
                  const SizedBox(
                    height: 15,
                  ),
                  Button(
                    'Share',
                    backgroundColor: ColorList.lightBlue3Color,
                    textColor: ColorList.primaryColor,
                    overlayColor: ColorList.blueColor,
                    borderRadius: 32,
                    onPressed: () {},
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Button(
                    'Ok',
                    backgroundColor: ColorList.primaryColor,
                    textColor: ColorList.white,
                    overlayColor: ColorList.blueColor,
                    borderRadius: 32,
                    onPressed: () {
                      // BlocProvider.of<DashboardBloc>(context).add(
                      //   ClearBackStackEvent(
                      //     until: StateContainer.of(context).isFromFundMyKoloBox
                      //         ? '/'
                      //         : StateContainer.of(context)
                      //             .koloboxFundEnum
                      //             .getFundPageValue(
                      //                 StateContainer.of(context).isFromDetail),
                      //   ),
                      // );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getOptionWidget(KoloboxFundEnum fundEnum) {
    return GestureDetector(
      onTap: () async {},
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

  @override
  void dispose() {
    // scaleController.dispose();
    // checkController.dispose();
    super.dispose();
  }
}
