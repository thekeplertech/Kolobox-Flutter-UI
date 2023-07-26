import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kolobox_new_app/core/base/base_screen.dart';
import 'package:kolobox_new_app/core/constants/image_constants.dart';
import 'package:kolobox_new_app/core/ui/style/app_style.dart';
import 'package:kolobox_new_app/routes/routes.dart';

import '../../../core/colors/color_list.dart';
import '../../../core/constants/kolo_box_icon.dart';
import '../../../core/ui/widgets/button.dart';
import '../../../core/ui/widgets/currency_text_input_formatter.dart';
import '../../../core/ui/widgets/custom_text_field.dart';

class WithdrawalSelectionKoloboxWidget extends BaseScreen {
  const WithdrawalSelectionKoloboxWidget({Key? key}) : super(key: key);

  @override
  State<WithdrawalSelectionKoloboxWidget> createState() =>
      _WithdrawalSelectionKoloboxWidgetState();
}

class _WithdrawalSelectionKoloboxWidgetState
    extends BaseScreenState<WithdrawalSelectionKoloboxWidget> {
  StreamController<bool> withdrawalSelectionStreamController =
      StreamController<bool>.broadcast();
  bool isBankAccount = false;

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
              'Withdrawal',
              style:
                  AppStyle.b4Bold.copyWith(color: ColorList.blackSecondColor),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Enter Amount',
              style:
                  AppStyle.b9Regular.copyWith(color: ColorList.blackThirdColor),
            ),
            const SizedBox(
              height: 10,
            ),
            CustomTextField(
              '₦ 0.00',
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.done,
              textCapitalization: TextCapitalization.none,
              inputFormatter: [
                CurrencyTextInputFormatter(
                  name: '₦ ',
                )
              ],
              textStyle:
                  AppStyle.b3Bold.copyWith(color: ColorList.blackSecondColor),
              hintStyle:
                  AppStyle.b3Bold.copyWith(color: ColorList.blackSecondColor),
              textAlign: TextAlign.center,
              contentPadding: const EdgeInsets.symmetric(vertical: 25),
              // controller: emailTextEditingController,
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              'Withdraw to',
              style: AppStyle.b8SemiBold
                  .copyWith(color: ColorList.blackSecondColor),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              decoration: BoxDecoration(
                color: ColorList.greyLight5Color,
                borderRadius: BorderRadius.circular(12),
              ),
              child: StreamBuilder<bool>(
                initialData: isBankAccount,
                stream: withdrawalSelectionStreamController.stream,
                builder: (_, snapshot) {
                  return Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          isBankAccount = true;
                          withdrawalSelectionStreamController
                              .add(isBankAccount);
                        },
                        child: AbsorbPointer(
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 15, right: 15, top: 15, bottom: 10),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    'Bank account',
                                    style: AppStyle.b8Regular.copyWith(
                                        color: ColorList.blackSecondColor),
                                  ),
                                ),
                                SizedBox(
                                  width: 25,
                                  height: 25,
                                  child: Stack(
                                    children: [
                                      Image.asset(isBankAccount
                                          ? imageCheckedIcon
                                          : imageUncheckedIcon),
                                      if (isBankAccount) ...[
                                        Center(
                                          child: Icon(
                                            KoloBoxIcons.check,
                                            color: ColorList.white,
                                            size: 20,
                                          ),
                                        ),
                                      ],
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Divider(
                          color: ColorList.lightBlue5Color,
                          height: 1,
                          thickness: 1),
                      GestureDetector(
                        onTap: () {
                          isBankAccount = false;
                          withdrawalSelectionStreamController
                              .add(isBankAccount);
                        },
                        child: AbsorbPointer(
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 15, right: 15, top: 10, bottom: 15),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    'My Wallet',
                                    style: AppStyle.b7Regular.copyWith(
                                        color: ColorList.blackSecondColor),
                                  ),
                                ),
                                SizedBox(
                                  width: 25,
                                  height: 25,
                                  child: Stack(
                                    children: [
                                      Image.asset(!isBankAccount
                                          ? imageCheckedIcon
                                          : imageUncheckedIcon),
                                      if (!isBankAccount) ...[
                                        Center(
                                          child: Icon(
                                            KoloBoxIcons.check,
                                            color: ColorList.white,
                                            size: 20,
                                          ),
                                        ),
                                      ],
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
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
                // showCustomBottomSheet(isBankAccount
                //     ? const WithdrawalToBankKoloboxWidget()
                //     : const WithdrawalToMyWalletKoloboxWidget());
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    withdrawalSelectionStreamController.close();
  }
}
