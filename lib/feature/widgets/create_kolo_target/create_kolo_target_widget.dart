import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kolobox_new_app/core/base/base_screen.dart';
import 'package:kolobox_new_app/core/constants/image_constants.dart';
import 'package:kolobox_new_app/core/ui/style/app_style.dart';
import 'package:kolobox_new_app/feature/widgets/create_kolo_target/kolo_target_summary_widget.dart';
import 'package:kolobox_new_app/routes/routes.dart';

import '../../../core/colors/color_list.dart';
import '../../../core/ui/widgets/button.dart';
import '../../../core/ui/widgets/custom_text_field.dart';
import '../../../core/ui/widgets/flutter_custom_switch.dart';

class CreateKoloTargetWidget extends BaseScreen {
  const CreateKoloTargetWidget({Key? key}) : super(key: key);

  @override
  State<CreateKoloTargetWidget> createState() => _CreateKoloTargetWidgetState();
}

class _CreateKoloTargetWidgetState
    extends BaseScreenState<CreateKoloTargetWidget> {
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
            'Create Kolotarget',
            style: AppStyle.b4Bold.copyWith(color: ColorList.blackSecondColor),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            'Start investing towards your goal',
            style:
                AppStyle.b9Regular.copyWith(color: ColorList.blackThirdColor),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            'Name your target',
            style:
                AppStyle.b9Medium.copyWith(color: ColorList.blackSecondColor),
          ),
          const SizedBox(
            height: 7,
          ),
          CustomTextField(
            'Enter your target name',
            keyboardType: TextInputType.name,
            textInputAction: TextInputAction.next,
            textCapitalization: TextCapitalization.words,
            controller: nameTextEditingController,
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            'Target amount',
            style:
                AppStyle.b9Regular.copyWith(color: ColorList.blackThirdColor),
          ),
          const SizedBox(
            height: 7,
          ),
          CustomTextField(
            '₦ 0.00',
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.next,
            textCapitalization: TextCapitalization.none,
            inputFormatter: [FilteringTextInputFormatter.digitsOnly],
            textStyle: AppStyle.b3Bold.copyWith(color: ColorList.primaryColor),
            hintStyle: AppStyle.b3Bold.copyWith(color: ColorList.primaryColor),
            textAlign: TextAlign.center,
            // controller: emailTextEditingController,
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            'Target date (Target date equals end date)',
            style:
                AppStyle.b9Regular.copyWith(color: ColorList.blackThirdColor),
          ),
          const SizedBox(
            height: 7,
          ),
          CustomTextField(
            'Select date',
            keyboardType: TextInputType.name,
            textInputAction: TextInputAction.next,
            textCapitalization: TextCapitalization.words,
            // controller: emailTextEditingController,
            onPressed: () {},
            postIcon: imageCalendar,
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            'How much you plan to save now',
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
            height: 15,
          ),
          Text(
            'Archive your goal faster by enabling recurring deposit',
            style: AppStyle.b9Medium.copyWith(color: ColorList.blackThirdColor),
          ),
          const SizedBox(
            height: 7,
          ),
          GestureDetector(
            onTap: () {
              isEnableRecurringDeposit = !isEnableRecurringDeposit;
              enableRecurringDepositStreamController
                  .add(isEnableRecurringDeposit);
            },
            child: AbsorbPointer(
              child: Container(
                decoration: BoxDecoration(
                  color: ColorList.greyLight5Color,
                  borderRadius: BorderRadius.circular(12),
                ),
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Enable recurring deposit',
                      style: AppStyle.b9Medium
                          .copyWith(color: ColorList.blackSecondColor),
                    ),
                    StreamBuilder<bool>(
                        initialData: isEnableRecurringDeposit,
                        stream: enableRecurringDepositStreamController.stream,
                        builder: (context, snapshot) {
                          return FlutterCustomSwitch(
                            value: isEnableRecurringDeposit,
                            onChanged: (value) {},
                            activeColor: ColorList.white,
                            inActiveColor: ColorList.white,
                            activeThumbColor: ColorList.primaryColor,
                            inActiveThumbColor: ColorList.blackSecondColor,
                          );
                        }),
                  ],
                ),
              ),
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
              showCustomBottomSheet(const KoloTargetSummaryWidget(),
                  height: 0.9);
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
