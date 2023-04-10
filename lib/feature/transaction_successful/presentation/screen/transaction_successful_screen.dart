import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kolobox_new_app/core/colors/color_list.dart';
import 'package:kolobox_new_app/core/constants/kolo_box_icon.dart';
import 'package:kolobox_new_app/core/ui/style/app_style.dart';
import 'package:kolobox_new_app/core/ui/widgets/currency_text_input_formatter.dart';
import 'package:kolobox_new_app/core/utils/date_helper.dart';
import 'package:kolobox_new_app/feature/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:kolobox_new_app/feature/dashboard/presentation/bloc/dashboard_event.dart';
import 'package:kolobox_new_app/feature/transaction_successful/presentation/bloc/transaction_successful_bloc.dart';
import 'package:kolobox_new_app/feature/transaction_successful/presentation/bloc/transaction_successful_event.dart';
import 'package:kolobox_new_app/feature/transaction_successful/presentation/bloc/transaction_successful_state.dart';
import 'package:kolobox_new_app/feature/widgets/product_item_widget.dart';

import '../../../../../core/base/base_bloc_widget.dart';
import '../../../../core/constants/image_constants.dart';
import '../../../../core/ui/widgets/button.dart';
import '../../../widgets/inherited_state_container.dart';

class TransactionSuccessfulScreen extends BaseBlocWidget {
  final String referenceCode;
  final String amount;
  final bool isDeposited;
  final bool isSuccess;
  final String errorMessage;

  const TransactionSuccessfulScreen({
    Key? key,
    required this.referenceCode,
    required this.isDeposited,
    required this.isSuccess,
    required this.amount,
    required this.errorMessage,
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
          child: BlocListener<TransactionSuccessfulBloc,
              TransactionSuccessfulState>(
            listener: (_, state) {
              if (state is CallProductState) {
                StateContainer.of(context).isSuccessful = true;
                Future.delayed(const Duration(milliseconds: 300), () {
                  BlocProvider.of<DashboardBloc>(context)
                      .add(ClearBackStackEvent(
                    until: StateContainer.of(context).getPopUntil(),
                  ));
                });
              }
            },
            child: getChild(),
          ),
        ),
      ),
    );
  }

  Column getChild() {
    return Column(
      children: [
        Expanded(
            child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 22,
              ),
              Image.asset(widget.isSuccess ? imageConfirm : imageErrorIcon),
              const SizedBox(
                height: 8,
              ),
              Text(
                widget.isSuccess
                    ? 'Transaction Successful'
                    : 'Transaction Failed',
                style:
                    AppStyle.b4Bold.copyWith(color: ColorList.blackSecondColor),
              ),
              const SizedBox(
                height: 7,
              ),
              Text(
                widget.isSuccess
                    ? 'This transaction was successful'
                    : widget.errorMessage,
                style: AppStyle.b8Medium
                    .copyWith(color: ColorList.blackThirdColor),
              ),
              const SizedBox(
                height: 17,
              ),
              Container(
                decoration: BoxDecoration(
                  color: widget.isDeposited
                      ? ColorList.lightBlue6Color
                      : ColorList.redLightColor,
                  shape: BoxShape.circle,
                ),
                padding: const EdgeInsets.all(25),
                child: Icon(
                  widget.isDeposited
                      ? KoloBoxIcons.deposit
                      : KoloBoxIcons.withdrawal,
                  size: 20,
                  color: widget.isDeposited
                      ? ColorList.primaryColor
                      : ColorList.redDarkColor,
                ),
              ),
              const SizedBox(
                height: 17,
              ),
              Text(
                widget.isDeposited ? 'Deposited' : 'Withdrawal',
                style:
                    AppStyle.b4Bold.copyWith(color: ColorList.blackSecondColor),
              ),
              const SizedBox(
                height: 14,
              ),
              Text(
                CurrencyTextInputFormatter.formatAmount(widget.amount),
                style:
                    AppStyle.b5SemiBold.copyWith(color: ColorList.primaryColor),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                DateHelper.getTextFromDateTime(
                    DateTime.now(), 'MMM dd, yyyy - hh:mm a'),
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
                widget.referenceCode,
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
            if (StateContainer.of(context).getKoloBoxEnum() != null) ...[
              ProductItemWidget(
                  fundEnum: StateContainer.of(context).getKoloBoxEnum()!),
            ],
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
              onPressed: () => comingSoon(),
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
              onPressed: () =>
                  BlocProvider.of<TransactionSuccessfulBloc>(context)
                      .add(CallProductEvent()),
            ),
          ],
        ),
      ],
    );
  }

  @override
  void dispose() {
    // scaleController.dispose();
    // checkController.dispose();
    super.dispose();
  }
}
