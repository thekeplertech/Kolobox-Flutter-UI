import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kolobox_new_app/core/base/base_screen.dart';
import 'package:kolobox_new_app/core/constants/image_constants.dart';
import 'package:kolobox_new_app/core/ui/style/app_style.dart';
import 'package:kolobox_new_app/feature/widgets/bank_details/select_bank_widget.dart';

import '../../../core/colors/color_list.dart';
import '../../../core/constants/kolo_box_icon.dart';
import '../../../core/ui/widgets/button.dart';
import '../../../core/ui/widgets/custom_text_field.dart';
import '../../../core/ui/widgets/toast_widget.dart';
import '../../../core/utils/utils.dart';
import '../../../routes/routes.dart';
import '../../dashboard/data/models/get_banks_response_model.dart';

class AddBankDetailsWidget extends BaseScreen {
  final List<BankData> banks;
  final Function(BankData, String, String) onSave;

  const AddBankDetailsWidget({
    Key? key,
    required this.banks,
    required this.onSave,
  }) : super(key: key);

  @override
  State<AddBankDetailsWidget> createState() => _AddBankDetailsWidgetState();
}

class _AddBankDetailsWidgetState extends BaseScreenState<AddBankDetailsWidget> {
  final TextEditingController numberTextEditingController =
      TextEditingController();
  final TextEditingController nameTextEditingController =
      TextEditingController();

  StreamController<bool> bankStreamController =
      StreamController<bool>.broadcast();

  List<BankData> banks = [];
  BankData? selectedBankData;

  @override
  void initState() {
    super.initState();
    banks = widget.banks;
  }

  @override
  Widget body(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 17, left: 28, right: 28, bottom: 31),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Add Bank Account',
                  style: AppStyle.b4Bold
                      .copyWith(color: ColorList.blackSecondColor),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    goBack(context);
                  },
                  child: Image.asset(imageClose),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          Text(
            'Select Bank',
            style:
                AppStyle.b9Medium.copyWith(color: ColorList.blackSecondColor),
          ),
          const SizedBox(
            height: 7,
          ),
          StreamBuilder<bool>(
              stream: bankStreamController.stream,
              builder: (context, snapshot) {
                return CustomTextField(
                  selectedBankData?.name ?? 'Select a bank',
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  textCapitalization: TextCapitalization.none,
                  onPressed: () => showDialogSelectBanks(),
                  iconData: KoloBoxIcons.dropDownArrow,
                );
              }),
          const SizedBox(
            height: 15,
          ),
          Text(
            'Personal Bank Account Number',
            style:
                AppStyle.b9Medium.copyWith(color: ColorList.blackSecondColor),
          ),
          const SizedBox(
            height: 7,
          ),
          CustomTextField(
            'Enter your personal bank account number',
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.next,
            textCapitalization: TextCapitalization.none,
            inputFormatter: [FilteringTextInputFormatter.digitsOnly],
            controller: numberTextEditingController,
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            'Account Name',
            style:
                AppStyle.b9Medium.copyWith(color: ColorList.blackSecondColor),
          ),
          const SizedBox(
            height: 7,
          ),
          CustomTextField(
            'Enter your account name',
            keyboardType: TextInputType.name,
            textInputAction: TextInputAction.done,
            textCapitalization: TextCapitalization.words,
            controller: nameTextEditingController,
          ),
          const SizedBox(
            height: 40,
          ),
          Button(
            'Save',
            backgroundColor: ColorList.primaryColor,
            textColor: ColorList.white,
            overlayColor: ColorList.blueColor,
            borderRadius: 32,
            onPressed: () => onClickSave(),
          ),
        ],
      ),
    );
  }

  onClickSave() {
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
    if (numberTextEditingController.text.isEmpty) {
      Utils.showToast(
          context,
          ToastWidget(
            'Enter your account number',
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
    if (nameTextEditingController.text.isEmpty) {
      Utils.showToast(
          context,
          ToastWidget(
            'Enter your account name',
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
    widget.onSave(selectedBankData!, numberTextEditingController.text,
        nameTextEditingController.text);
    goBack(context);
  }

  showDialogSelectBanks() {
    showCustomBottomSheet(SelectBankWidget(
      selectedBankData: selectedBankData,
      banks: banks,
      onPop: (bankData) {
        selectedBankData = bankData;
        bankStreamController.add(true);
      },
    ));
  }

  @override
  void dispose() {
    super.dispose();
    numberTextEditingController.dispose();
    nameTextEditingController.dispose();
    bankStreamController.close();
  }
}
