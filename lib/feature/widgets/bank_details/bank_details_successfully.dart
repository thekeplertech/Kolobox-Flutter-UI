import 'package:flutter/material.dart';
import 'package:kolobox_new_app/core/base/base_screen.dart';
import 'package:kolobox_new_app/core/constants/image_constants.dart';
import 'package:kolobox_new_app/core/ui/style/app_style.dart';
import 'package:kolobox_new_app/routes/routes.dart';

import '../../../core/colors/color_list.dart';
import '../../../core/ui/widgets/button.dart';

class BankDetailsSuccessfullyWidget extends BaseScreen {
  const BankDetailsSuccessfullyWidget({Key? key}) : super(key: key);

  @override
  State<BankDetailsSuccessfullyWidget> createState() =>
      _BankDetailsSuccessfullyWidgetState();
}

class _BankDetailsSuccessfullyWidgetState
    extends BaseScreenState<BankDetailsSuccessfullyWidget> {
  @override
  Widget body(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 45, left: 28, right: 28, bottom: 31),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(child: Image.asset(imageConfirm)),
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 35),
            child: Text(
              'Bank Details Saved Successfully',
              style:
                  AppStyle.b5Bold.copyWith(color: ColorList.blackSecondColor),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 55),
            child: Text(
              'You have successfully added a bank account details to your account',
              style:
                  AppStyle.b9Medium.copyWith(color: ColorList.blackThirdColor),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          Button(
            'Next',
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
              goBack(context);
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
