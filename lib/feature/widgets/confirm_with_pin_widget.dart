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

class ConfirmWithPinWidget extends BaseScreen {
  final Function(String) onPopUp;

  const ConfirmWithPinWidget({
    Key? key,
    required this.onPopUp,
  }) : super(key: key);

  @override
  State<ConfirmWithPinWidget> createState() => _ConfirmWithPinWidgetState();
}

class _ConfirmWithPinWidgetState extends BaseScreenState<ConfirmWithPinWidget> {
  final TextEditingController pinTextEditingController =
      TextEditingController();

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
              'Confirm with PIN',
              style:
                  AppStyle.b4Bold.copyWith(color: ColorList.blackSecondColor),
            ),
            const SizedBox(
              height: 6,
            ),
            Text(
              'Enter your secure 4 digit pin to confirm',
              style:
                  AppStyle.b8Medium.copyWith(color: ColorList.blackThirdColor),
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: PinCodeTextField(
                appContext: context,
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
                controller: pinTextEditingController,
              ),
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
                if (pinTextEditingController.text.isEmpty ||
                    pinTextEditingController.text.length != 4) {
                  Utils.showToast(
                      context,
                      ToastWidget(
                        'Enter 4 digit pin',
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
                widget.onPopUp(pinTextEditingController.text);
                goBack(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
