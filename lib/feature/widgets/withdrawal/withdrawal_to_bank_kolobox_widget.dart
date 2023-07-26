import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kolobox_new_app/core/base/base_bloc_widget.dart';
import 'package:kolobox_new_app/core/constants/image_constants.dart';
import 'package:kolobox_new_app/core/constants/kolo_box_icon.dart';
import 'package:kolobox_new_app/core/ui/style/app_style.dart';
import 'package:kolobox_new_app/routes/routes.dart';

import '../../../core/colors/color_list.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/enums/kolobox_fund_enum.dart';
import '../../../core/ui/widgets/button.dart';
import '../../../core/ui/widgets/currency_text_input_formatter.dart';
import '../../../core/ui/widgets/custom_text_field.dart';
import '../../../core/ui/widgets/toast_widget.dart';
import '../../../core/utils/utils.dart';
import '../../account/bank_details/presentation/bank_details_page.dart';
import '../../account/bank_details/presentation/bloc/bank_detail_bloc.dart';
import '../../account/bank_details/presentation/bloc/bank_detail_event.dart';
import '../../account/bank_details/presentation/bloc/bank_detail_state.dart';
import '../../dashboard/data/models/get_all_my_banks_response_model.dart';
import '../select_group/select_my_bank_widget.dart';
import 'withdrawal_summary_kolobox_widget_page.dart';

class WithdrawalToBankKoloboxWidget extends BaseBlocWidget {
  final KoloboxFundEnum koloboxFundEnum;
  final String popUntil;

  const WithdrawalToBankKoloboxWidget({
    Key? key,
    required this.koloboxFundEnum,
    required this.popUntil,
  }) : super(key: key);

  @override
  State<WithdrawalToBankKoloboxWidget> createState() =>
      _WithdrawalToBankKoloboxWidgetState();
}

class _WithdrawalToBankKoloboxWidgetState
    extends BaseBlocWidgetState<WithdrawalToBankKoloboxWidget> {
  StreamController<bool> bankStreamController =
      StreamController<bool>.broadcast();

  TextEditingController amountTextEditingController = TextEditingController();

  List<MyBankData> myBanks = [];

  MyBankData? selectBankData;

  @override
  void initState() {
    super.initState();
    callGetAllBanks();
  }

  callGetAllBanks() =>
      BlocProvider.of<BankDetailBloc>(context).add(GetAllMyBanksEvent());

  @override
  Widget getCustomBloc() {
    return BlocListener<BankDetailBloc, BankDetailState>(
      listener: (_, state) {
        if (state is GetAllMyBanksState) {
          myBanks = state.model.banks ?? [];
          if (myBanks.isNotEmpty) {
            selectBankData = myBanks[0];
          }
          bankStreamController.add(true);
        }
      },
      child: getChild(),
    );
  }

  SingleChildScrollView getChild() {
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
            const SizedBox(height: 5),
            Text(
              'Withdraw to my bank account',
              style:
                  AppStyle.b9Regular.copyWith(color: ColorList.blackThirdColor),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Enter Amount',
                  style: AppStyle.b9Regular
                      .copyWith(color: ColorList.blackThirdColor),
                ),
                Text(
                  'Withdrawable Amount : ${CurrencyTextInputFormatter.formatAmountDouble(prefHelper?.getProfileDataModel().wallet?.withDrawableFunds)}',
                  style: AppStyle.b9Regular
                      .copyWith(color: ColorList.blackThirdColor),
                ),
              ],
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
              controller: amountTextEditingController,
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
            StreamBuilder<bool>(
                stream: bankStreamController.stream,
                builder: (context, snapshot) {
                  return myBanks.isEmpty
                      ? getAddBankAccountWidget()
                      : Column(
                          children: [
                            CustomTextField(
                              selectBankData?.accountName ?? 'Select bank',
                              keyboardType: TextInputType.name,
                              textInputAction: TextInputAction.next,
                              textCapitalization: TextCapitalization.words,
                              onPressed: () {
                                hideKeyboard();
                                if (myBanks.isNotEmpty) {
                                  showMyBankDialog();
                                } else {
                                  callGetAllBanks();
                                }
                              },
                              iconData: KoloBoxIcons.dropDownArrow,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            if (selectBankData != null) ...[
                              Container(
                                width: double.maxFinite,
                                decoration: BoxDecoration(
                                  color: ColorList.lightBlue3Color,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        const Icon(
                                          KoloBoxIcons.bank,
                                          size: 18,
                                          color: ColorList.primaryColor,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                          child: Text(
                                            selectBankData?.bankName ?? '',
                                            style: AppStyle.b8SemiBold.copyWith(
                                                color:
                                                    ColorList.blackSecondColor),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      selectBankData?.accountNumber ?? '',
                                      style: AppStyle.b6Bold.copyWith(
                                          color: ColorList.blackSecondColor),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      selectBankData?.accountName ?? '',
                                      style: AppStyle.b8Medium.copyWith(
                                          color: ColorList.blackSecondColor),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                            const SizedBox(
                              height: 10,
                            ),
                            getAddBankAccountWidget(),
                          ],
                        );
                }),
            const SizedBox(
              height: 15,
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
                if (amountTextEditingController.text.isEmpty) {
                  Utils.showToast(
                      context,
                      ToastWidget(
                        'Enter amount',
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
                if (double.parse(
                        getOnlyAmount(amountTextEditingController.text)) >
                    (prefHelper
                            ?.getProfileDataModel()
                            .wallet
                            ?.withDrawableFunds ??
                        0)) {
                  Utils.showToast(
                      context,
                      ToastWidget(
                        'Amount should be less than or equal to the withdrawable amount',
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
                if (selectBankData == null) {
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
                showCustomBottomSheet(WithdrawalSummaryKoloboxWidgetPage(
                  koloboxFundEnum: widget.koloboxFundEnum,
                  amount: getOnlyAmount(amountTextEditingController.text),
                  myBankData: selectBankData!,
                  popUntil: widget.popUntil,
                ));
              },
            ),
          ],
        ),
      ),
    );
  }

  Center getAddBankAccountWidget() {
    return Center(
      child: GestureDetector(
        onTap: () async {
          await navigatePush(
              context,
              const BankDetailsPage(
                isFromWithdrawPopUp: true,
              ));
          callGetAllBanks();
        },
        child: Container(
          decoration: BoxDecoration(
              color: ColorList.lightBlue3Color,
              borderRadius: BorderRadius.circular(32)),
          padding: const EdgeInsets.symmetric(horizontal: 27, vertical: 17),
          child: IntrinsicWidth(
            child: Row(
              children: [
                Text(
                  'Add Bank Account',
                  style: AppStyle.b7SemiBold
                      .copyWith(color: ColorList.primaryColor),
                ),
                const SizedBox(
                  width: 10,
                ),
                const Icon(
                  KoloBoxIcons.bank,
                  size: 18,
                  color: ColorList.primaryColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  showMyBankDialog() {
    showCustomBottomSheet(SelectMyBankWidget(
      selectedBankData: selectBankData,
      bankModels: myBanks,
      onPop: (model) {
        selectBankData = model;
        bankStreamController.add(true);
      },
    ));
  }

  @override
  void dispose() {
    super.dispose();
    amountTextEditingController.dispose();
    bankStreamController.close();
  }
}
