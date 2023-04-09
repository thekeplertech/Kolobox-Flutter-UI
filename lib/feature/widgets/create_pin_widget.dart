import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kolobox_new_app/core/base/base_screen.dart';
import 'package:kolobox_new_app/core/ui/style/app_style.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../core/colors/color_list.dart';
import '../../core/constants/image_constants.dart';
import '../../core/ui/widgets/button.dart';
import '../../core/ui/widgets/toast_widget.dart';
import '../../core/utils/utils.dart';
import '../../routes/routes.dart';

class CreatePinWidget extends BaseScreen {
  final Function(String) onBack;
  final bool isConfirmPin;

  const CreatePinWidget({
    Key? key,
    required this.onBack,
    this.isConfirmPin = false,
  }) : super(key: key);

  @override
  State<CreatePinWidget> createState() => _CreatePinWidgetState();
}

class _CreatePinWidgetState extends BaseScreenState<CreatePinWidget> {
  TextEditingController otpTextEditingController = TextEditingController();

  @override
  Widget body(BuildContext context) {
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
              widget.isConfirmPin
                  ? 'Confirm Transaction Pin Setup'
                  : 'Transaction Pin Setup',
              style:
                  AppStyle.b5Bold.copyWith(color: ColorList.blackSecondColor),
            ),
            const SizedBox(
              height: 6,
            ),
            Text(
              widget.isConfirmPin
                  ? 'Enter again to confirm your transaction Pin'
                  : 'Create a Pin to secure all your transactions',
              style:
                  AppStyle.b9Medium.copyWith(color: ColorList.blackThirdColor),
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: PinCodeTextField(
                appContext: context,
                controller: otpTextEditingController,
                length: 4,
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
                textStyle: AppStyle.b9Bold.copyWith(
                  color: ColorList.blackThirdColor,
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                onChanged: (String value) {},
              ),
            ),
            const SizedBox(
              height: 35,
            ),
            Button(
              widget.isConfirmPin ? 'Set PIN' : 'Next',
              backgroundColor: ColorList.primaryColor,
              textColor: ColorList.white,
              overlayColor: ColorList.blueColor,
              borderRadius: 32,
              onPressed: () {
                onClickNext();
              },
            ),
          ],
        ),
      ),
    );
  }

  onClickNext() {
    hideKeyboard();
    if (otpTextEditingController.text.isEmpty) {
      Utils.showToast(
          context,
          ToastWidget(
            'Enter otp',
            borderColor: ColorList.redDarkColor,
            backgroundColor: ColorList.white,
            textColor: ColorList.black,
            messageIcon: imageCloseRed,
            closeWidget: Image.asset(
              imageClose,
              color: ColorList.black,
            ),
          ));
      return;
    }
    if (otpTextEditingController.text.length != 4) {
      Utils.showToast(
          context,
          ToastWidget(
            'Enter valid otp',
            borderColor: ColorList.redDarkColor,
            backgroundColor: ColorList.white,
            textColor: ColorList.black,
            messageIcon: imageCloseRed,
            closeWidget: Image.asset(
              imageClose,
              color: ColorList.black,
            ),
          ));
      return;
    }
    widget.onBack(otpTextEditingController.text);
    goBack(context);
  }
}
