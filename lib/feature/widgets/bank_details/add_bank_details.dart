import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kolobox_new_app/core/base/base_bloc_widget.dart';
import 'package:kolobox_new_app/core/constants/image_constants.dart';
import 'package:kolobox_new_app/core/enums/bank_detail_enum.dart';
import 'package:kolobox_new_app/core/ui/style/app_style.dart';
import 'package:kolobox_new_app/feature/account/bank_details/presentation/bloc/bank_detail_event.dart';
import 'package:kolobox_new_app/feature/account/bank_details/presentation/bloc/bank_detail_state.dart';
import 'package:kolobox_new_app/feature/dashboard/data/models/add_bank_request_model.dart';
import 'package:kolobox_new_app/feature/dashboard/data/models/get_all_my_banks_response_model.dart';
import 'package:kolobox_new_app/feature/dashboard/data/models/update_bank_request_model.dart';
import 'package:kolobox_new_app/feature/widgets/bank_details/select_bank_widget.dart';

import '../../../core/colors/color_list.dart';
import '../../../core/constants/kolo_box_icon.dart';
import '../../../core/ui/widgets/button.dart';
import '../../../core/ui/widgets/custom_text_field.dart';
import '../../../core/ui/widgets/toast_widget.dart';
import '../../../core/utils/utils.dart';
import '../../../routes/routes.dart';
import '../../account/bank_details/presentation/bloc/bank_detail_bloc.dart';
import '../../dashboard/data/models/get_banks_response_model.dart';

class AddBankDetailsWidget extends BaseBlocWidget {
  final List<BankData> banks;
  final Function() onSave;
  final BankDetailEnum bankDetailEnum;
  final MyBankData? selectedBankData;

  const AddBankDetailsWidget({
    Key? key,
    required this.banks,
    required this.onSave,
    this.bankDetailEnum = BankDetailEnum.addBank,
    this.selectedBankData,
  }) : super(key: key);

  @override
  State<AddBankDetailsWidget> createState() => _AddBankDetailsWidgetState();
}

class _AddBankDetailsWidgetState
    extends BaseBlocWidgetState<AddBankDetailsWidget> {
  final TextEditingController numberTextEditingController =
  TextEditingController();
  final TextEditingController nameTextEditingController =
  TextEditingController();

  StreamController<bool> bankStreamController =
  StreamController<bool>.broadcast();

  List<BankData> banks = [];
  BankData? selectedBankData;

  BankDetailEnum bankDetailEnum = BankDetailEnum.addBank;

  @override
  void initState() {
    bankDetailEnum = widget.bankDetailEnum;
    banks = widget.banks;

    if (bankDetailEnum == BankDetailEnum.updateBank &&
        widget.selectedBankData != null) {
      int pos = banks.indexWhere((element) =>
      element.name == (widget.selectedBankData?.bankName ?? ''));
      if (pos != -1) {
        selectedBankData = banks[pos];
      }

      numberTextEditingController.text =
          widget.selectedBankData?.accountNumber ?? '';
      nameTextEditingController.text =
          widget.selectedBankData?.accountName ?? '';
    }
    super.initState();
  }

  @override
  Widget getCustomBloc() {
    return BlocListener<BankDetailBloc, BankDetailState>(
      listener: (_, state) {
        if (state is AddMyBanksState) {
          Future.delayed(const Duration(milliseconds: 300), () {
            widget.onSave();
            goBack(context);
          });
        } else if (state is UpdateMyBanksState) {
          Future.delayed(const Duration(milliseconds: 300), () {
            widget.onSave();
            goBack(context);
          });
        }
      },
      child: getChild(),
    );
  }

  Widget getChild() =>
      Padding(
        padding:
        const EdgeInsets.only(top: 17, left: 28, right: 28, bottom: 31),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    bankDetailEnum == BankDetailEnum.addBank
                        ? 'Add Bank Account'
                        : 'Edit Bank Details',
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

  onClickSave() {
    hideKeyboard();
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


    callSubmit();
  }

  callSubmit() {
    if (bankDetailEnum == BankDetailEnum.addBank) {
      BlocProvider.of<BankDetailBloc>(context).add(
        AddMyBanksEvent(
          model: AddBankRequestModel(
            bankName: selectedBankData?.name ?? '',
            accountNumber: numberTextEditingController.text,
            accountName: nameTextEditingController.text,
            bankCode: selectedBankData?.code ?? '',
            payWithBank: selectedBankData?.payWithBank?.toString() ?? '',
          ),
        ),
      );
    } else {
      BlocProvider.of<BankDetailBloc>(context).add(
        UpdateMyBanksEvent(
          model: UpdateBankRequestModel(
            bankName: selectedBankData?.name ?? '',
            accountNumber: numberTextEditingController.text,
            accountName: nameTextEditingController.text,
            code: selectedBankData?.code ?? '',
            payWithBank: selectedBankData?.payWithBank?.toString() ?? '',
            pin: '5987',
          ),
          bankId: widget.selectedBankData?.id ?? '',
        ),
      );
    }
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
