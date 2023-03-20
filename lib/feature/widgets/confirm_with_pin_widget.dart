import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kolobox_new_app/core/ui/style/app_style.dart';
import 'package:kolobox_new_app/feature/transaction_successful/presentation/transaction_successful_page.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../core/colors/color_list.dart';
import '../../core/constants/image_constants.dart';
import '../../core/ui/widgets/button.dart';
import '../../routes/routes.dart';

class ConfirmWithPinWidget extends StatelessWidget {
  const ConfirmWithPinWidget({Key? key}) : super(key: key);

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
              height: 35,
            ),
            Text(
              'Confirm with PIN',
              style:
                  AppStyle.b4Bold.copyWith(color: ColorList.blackSecondColor),
            ),
            const SizedBox(
              height: 6,
            ),
            Text(
              'Enter your secure 6 digit pin to confirm',
              style:
                  AppStyle.b8Medium.copyWith(color: ColorList.blackThirdColor),
            ),
            const SizedBox(
              height: 30,
            ),
            PinCodeTextField(
              appContext: context,
              length: 6,
              pinTheme: PinTheme(
                shape: PinCodeFieldShape.box,
                borderRadius: BorderRadius.circular(12),
                fieldHeight: 45,
                fieldWidth: 45,
                borderWidth: 1,
                inactiveColor: ColorList.greyLightColor,
                activeColor: ColorList.greyLightColor,
                selectedColor: ColorList.greyLightColor,
              ),
              textStyle: TextStyle(
                color: ColorList.blackThirdColor,
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              onChanged: (value) {
                print("asd fa fds $value");
              },
            ),
            const SizedBox(
              height: 35,
            ),
            Button(
              'Next',
              backgroundColor: ColorList.primaryColor,
              textColor: ColorList.white,
              overlayColor: ColorList.blueColor,
              borderRadius: 32,
              onPressed: () {
                navigatePush(context, const TransactionSuccessfulPage());
              },
            ),
          ],
        ),
      ),
    );
  }
}
