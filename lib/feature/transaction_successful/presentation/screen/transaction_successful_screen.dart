import 'package:flutter/material.dart';
import 'package:kolobox_new_app/core/colors/color_list.dart';
import 'package:kolobox_new_app/core/ui/style/app_style.dart';

import '../../../../../core/base/base_bloc_widget.dart';
import '../../../../core/constants/image_constants.dart';
import '../../../../core/ui/widgets/button.dart';

class TransactionSuccessfulScreen extends BaseBlocWidget {
  const TransactionSuccessfulScreen({Key? key}) : super(key: key);

  @override
  TransactionSuccessfulScreenState createState() =>
      TransactionSuccessfulScreenState();
}

class TransactionSuccessfulScreenState
    extends BaseBlocWidgetState<TransactionSuccessfulScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget getCustomBloc() => WillPopScope(
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
                        padding: const EdgeInsets.all(10),
                        child: Image.asset(imageDepositSuccessIcon),
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
                    Container(
                      decoration: BoxDecoration(
                        color: ColorList.lightBlue3Color,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Wallet',
                            style: AppStyle.b3Bold
                                .copyWith(color: ColorList.blackSecondColor),
                          ),
                          Image.asset(imageWalletSuccessIconSelected),
                        ],
                      ),
                    ),
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
                      onPressed: () {},
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );

  @override
  void dispose() {
    super.dispose();
  }
}
