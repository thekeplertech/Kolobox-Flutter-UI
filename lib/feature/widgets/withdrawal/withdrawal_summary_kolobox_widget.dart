import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kolobox_new_app/core/base/base_bloc_widget.dart';
import 'package:kolobox_new_app/core/constants/image_constants.dart';
import 'package:kolobox_new_app/core/ui/style/app_style.dart';
import 'package:kolobox_new_app/core/utils/utils.dart';
import 'package:kolobox_new_app/feature/dashboard/data/models/account_transfer_request_model.dart';
import 'package:kolobox_new_app/routes/routes.dart';

import '../../../core/colors/color_list.dart';
import '../../../core/constants/kolo_box_icon.dart';
import '../../../core/enums/kolobox_fund_enum.dart';
import '../../../core/ui/widgets/button.dart';
import '../../../core/ui/widgets/currency_text_input_formatter.dart';
import '../../../core/ui/widgets/toast_widget.dart';
import '../../account/bank_details/presentation/bloc/bank_detail_bloc.dart';
import '../../account/bank_details/presentation/bloc/bank_detail_event.dart';
import '../../account/bank_details/presentation/bloc/bank_detail_state.dart';
import '../../dashboard/data/models/get_all_my_banks_response_model.dart';
import '../../dashboard/presentation/bloc/dashboard_bloc.dart';
import '../../dashboard/presentation/bloc/dashboard_event.dart';
import '../confirm_with_pin_widget.dart';

class WithdrawalSummaryKoloboxWidget extends BaseBlocWidget {
  final KoloboxFundEnum koloboxFundEnum;
  final String amount;
  final MyBankData myBankData;
  final String popUntil;

  const WithdrawalSummaryKoloboxWidget({
    Key? key,
    required this.koloboxFundEnum,
    required this.amount,
    required this.myBankData,
    required this.popUntil,
  }) : super(key: key);

  @override
  State<WithdrawalSummaryKoloboxWidget> createState() =>
      _WithdrawalSummaryKoloboxWidgetState();
}

class _WithdrawalSummaryKoloboxWidgetState
    extends BaseBlocWidgetState<WithdrawalSummaryKoloboxWidget> {
  @override
  Widget getCustomBloc() {
    return BlocListener<BankDetailBloc, BankDetailState>(
      listener: (_, state) {
        if (state is AccountTransferState) {
          Utils.showToast(
              context,
              ToastWidget(
                state.responseModel.duration ?? '',
                closeWidget: Image.asset(
                  imageClose,
                  color: ColorList.white,
                ),
              ),
              isTab: true);
          Future.delayed(const Duration(milliseconds: 300), () {
            BlocProvider.of<DashboardBloc>(context).add(ClearBackStackEvent(
              until: widget.popUntil,
            ));
          });
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
              'Withdrawal Summary',
              style:
                  AppStyle.b4Bold.copyWith(color: ColorList.blackSecondColor),
            ),
            const SizedBox(height: 5),
            Text(
              'Withdraw to your bank account',
              style:
                  AppStyle.b9Regular.copyWith(color: ColorList.blackThirdColor),
            ),
            const SizedBox(height: 20),
            Button(
              'Edit',
              backgroundColor: ColorList.lightBlue3Color,
              textColor: ColorList.primaryColor,
              overlayColor: ColorList.blueColor,
              borderRadius: 32,
              onPressed: () {},
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              decoration: BoxDecoration(
                color: ColorList.primaryColor,
                borderRadius: BorderRadius.circular(12),
              ),
              width: double.maxFinite,
              padding: const EdgeInsets.all(20),
              child: Center(
                child: Column(
                  children: [
                    Text(
                      'Deposit Amount',
                      style:
                          AppStyle.b9Regular.copyWith(color: ColorList.white),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      CurrencyTextInputFormatter.formatAmount(widget.amount),
                      style: AppStyle.b4Bold.copyWith(color: ColorList.white),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 25,
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
              width: double.maxFinite,
              decoration: BoxDecoration(
                color: ColorList.lightBlue3Color,
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
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
                          widget.myBankData.bankName ?? '',
                          style: AppStyle.b8SemiBold
                              .copyWith(color: ColorList.blackSecondColor),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    widget.myBankData.accountNumber ?? '',
                    style: AppStyle.b6Bold
                        .copyWith(color: ColorList.blackSecondColor),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    widget.myBankData.accountName ?? '',
                    style: AppStyle.b8Medium
                        .copyWith(color: ColorList.blackSecondColor),
                  ),
                ],
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
              onPressed: () async {
                showCustomBottomSheet(ConfirmWithPinWidget(
                  onPopUp: (pin) {
                    Future.delayed(const Duration(milliseconds: 300), () {
                      BlocProvider.of<BankDetailBloc>(context)
                          .add(AccountTransferEvent(
                              model: AccountTransferRequestModel(
                        amount: widget.amount,
                        pin: pin,
                        id: widget.myBankData.id ?? '',
                        productId: widget.koloboxFundEnum.getActiveId,
                      )));
                    });
                  },
                ));
              },
            ),
          ],
        ),
      ),
    );
  }
}
