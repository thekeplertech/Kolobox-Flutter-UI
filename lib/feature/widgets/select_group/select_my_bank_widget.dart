import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kolobox_new_app/core/base/base_screen.dart';
import 'package:kolobox_new_app/core/constants/image_constants.dart';
import 'package:kolobox_new_app/core/ui/style/app_style.dart';
import 'package:kolobox_new_app/feature/dashboard/data/models/get_all_my_banks_response_model.dart';
import 'package:kolobox_new_app/routes/routes.dart';

import '../../../core/colors/color_list.dart';
import '../../../core/ui/widgets/button.dart';
import '../../../core/ui/widgets/toast_widget.dart';
import '../../../core/utils/utils.dart';

class SelectMyBankWidget extends BaseScreen {
  final Function(MyBankData) onPop;
  final MyBankData? selectedBankData;
  final List<MyBankData> bankModels;

  const SelectMyBankWidget({
    Key? key,
    required this.selectedBankData,
    required this.bankModels,
    required this.onPop,
  }) : super(key: key);

  @override
  State<SelectMyBankWidget> createState() => _SelectMyBankWidgetState();
}

class _SelectMyBankWidgetState extends BaseScreenState<SelectMyBankWidget> {
  StreamController<bool> bankStreamController =
      StreamController<bool>.broadcast();
  MyBankData? selectedBankData;
  List<MyBankData> bankModels = [];

  @override
  void initState() {
    super.initState();
    selectedBankData = widget.selectedBankData;
    bankModels = widget.bankModels;
  }

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
          const SizedBox(
            height: 10,
          ),
          Text(
            'Select a family',
            style:
                AppStyle.b8Regular.copyWith(color: ColorList.blackSecondColor),
          ),
          const SizedBox(
            height: 15,
          ),
          StreamBuilder<bool>(
              stream: bankStreamController.stream,
              builder: (context, snapshot) {
                return ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: bankModels.length,
                    itemBuilder: (_, index) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Button(
                          bankModels[index].bankName ?? '',
                          backgroundColor: ColorList.whiteColor,
                          overlayColor: ColorList.blueColor,
                          textColor: ColorList.blackSecondColor,
                          borderSide: BorderSide(
                              color:
                                  bankModels[index].id == selectedBankData?.id
                                      ? ColorList.primaryColor
                                      : ColorList.greyLight7Color,
                              width: 1),
                          borderRadius: 12,
                          textStyle:
                              (bankModels[index].id == selectedBankData?.id
                                      ? AppStyle.b7SemiBold
                                      : AppStyle.b8Regular)
                                  .copyWith(color: ColorList.blackSecondColor),
                          onPressed: () {
                            selectedBankData = bankModels[index];
                            bankStreamController.add(true);
                          },
                        ),
                      );
                    });
              }),
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
              if (selectedBankData == null) {
                Utils.showToast(
                    context,
                    ToastWidget(
                      'Select bank',
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
              widget.onPop(selectedBankData!);
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
    bankStreamController.close();
  }
}
