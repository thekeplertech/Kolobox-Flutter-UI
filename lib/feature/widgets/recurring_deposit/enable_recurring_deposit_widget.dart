import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kolobox_new_app/core/base/base_screen.dart';
import 'package:kolobox_new_app/core/constants/image_constants.dart';
import 'package:kolobox_new_app/core/constants/kolo_box_icon.dart';
import 'package:kolobox_new_app/core/ui/style/app_style.dart';
import 'package:kolobox_new_app/routes/routes.dart';

import '../../../core/colors/color_list.dart';
import '../../../core/ui/widgets/button.dart';
import '../../../core/ui/widgets/custom_text_field.dart';
import 'enable_recurring_deposit_summary_widget.dart';

class EnableRecurringDepositWidget extends BaseScreen {
  const EnableRecurringDepositWidget({Key? key}) : super(key: key);

  @override
  State<EnableRecurringDepositWidget> createState() =>
      _EnableRecurringDepositWidgetState();
}

class _EnableRecurringDepositWidgetState
    extends BaseScreenState<EnableRecurringDepositWidget> {
  TextEditingController nameTextEditingController = TextEditingController();

  StreamController<bool> enableRecurringDepositStreamController =
      StreamController<bool>.broadcast();
  bool isEnableRecurringDeposit = false;

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
            'Recurring deposit',
            style: AppStyle.b4Bold.copyWith(color: ColorList.blackSecondColor),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            'Setup your recurring deposit',
            style:
                AppStyle.b9Regular.copyWith(color: ColorList.blackThirdColor),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            'Select recurring period',
            style:
                AppStyle.b8Medium.copyWith(color: ColorList.blackSecondColor),
          ),
          const SizedBox(
            height: 7,
          ),
          CustomTextField(
            'Monthly',
            keyboardType: TextInputType.name,
            textInputAction: TextInputAction.next,
            textCapitalization: TextCapitalization.words,
            onPressed: () {},
            iconData: KoloBoxIcons.downArrow,
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            'Select recurring date',
            style:
                AppStyle.b8Medium.copyWith(color: ColorList.blackSecondColor),
          ),
          const SizedBox(
            height: 7,
          ),
          CustomTextField(
            'Select date',
            keyboardType: TextInputType.name,
            textInputAction: TextInputAction.next,
            textCapitalization: TextCapitalization.words,
            onPressed: () {},
            postIcon: imageCalendar,
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            'Enter recurring deposit',
            style:
                AppStyle.b9Regular.copyWith(color: ColorList.blackThirdColor),
          ),
          const SizedBox(
            height: 7,
          ),
          CustomTextField(
            '₦ 0.00',
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.done,
            textCapitalization: TextCapitalization.none,
            inputFormatter: [FilteringTextInputFormatter.digitsOnly],
            textStyle:
                AppStyle.b3Bold.copyWith(color: ColorList.blackSecondColor),
            hintStyle:
                AppStyle.b3Bold.copyWith(color: ColorList.blackSecondColor),
            textAlign: TextAlign.center,
            // controller: emailTextEditingController,
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
              showCustomBottomSheet(
                  const EnableRecurringDepositSummaryWidget());
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    enableRecurringDepositStreamController.close();
  }
}
