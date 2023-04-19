import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kolobox_new_app/core/colors/color_list.dart';
import 'package:kolobox_new_app/core/constants/image_constants.dart';
import 'package:kolobox_new_app/core/enums/bank_detail_enum.dart';
import 'package:kolobox_new_app/feature/account/bank_details/presentation/bloc/bank_detail_event.dart';
import 'package:kolobox_new_app/feature/account/bank_details/presentation/widgets/bank_item_widget.dart';
import 'package:kolobox_new_app/feature/dashboard/data/models/delete_bank_request_model.dart';
import 'package:kolobox_new_app/feature/dashboard/data/models/get_banks_response_model.dart';
import 'package:kolobox_new_app/feature/widgets/bank_details/add_bank_details_page.dart';

import '../../../../../core/base/base_bloc_widget.dart';
import '../../../../../core/ui/widgets/button.dart';
import '../../../../../core/ui/widgets/no_app_bar.dart';
import '../../../../../core/ui/widgets/no_overflow_scrollbar_behaviour.dart';
import '../../../../dashboard/data/models/get_all_my_banks_response_model.dart';
import '../../../../dashboard/presentation/bloc/dashboard_bloc.dart';
import '../../../../dashboard/presentation/bloc/dashboard_event.dart';
import '../../../../widgets/home_app_bar_widget.dart';
import '../bloc/bank_detail_bloc.dart';
import '../bloc/bank_detail_state.dart';

class BankDetailsScreen extends BaseBlocWidget {
  const BankDetailsScreen({
    Key? key,
  }) : super(key: key);

  @override
  BankDetailsState createState() => BankDetailsState();
}

class BankDetailsState extends BaseBlocWidgetState<BankDetailsScreen> {
  StreamController<bool> myBankStreamController =
      StreamController<bool>.broadcast();
  List<MyBankData> myBanks = [];

  List<BankData> allBankData = [];

  BankDetailEnum selectedBankDetailEnum = BankDetailEnum.addBank;
  MyBankData? selectedBankData;

  @override
  void initState() {
    super.initState();
    callGetAllMyBanks();
  }

  callGetAllMyBanks() =>
      BlocProvider.of<BankDetailBloc>(context).add(GetAllMyBanksEvent());

  @override
  Widget getCustomBloc() {
    return Scaffold(
      backgroundColor: ColorList.white,
      appBar: const NoAppBar(),
      body: BlocListener<BankDetailBloc, BankDetailState>(
        listener: (_, state) {
          if (state is GetAllBanksState) {
            allBankData = state.model.data ?? [];
            onClickAddBankAccount();
          } else if (state is GetAllMyBanksState) {
            myBanks = state.model.banks ?? [];
            myBankStreamController.add(true);
          } else if (state is DeleteMyBanksState) {
            Future.delayed(const Duration(milliseconds: 300), () {
              callGetAllMyBanks();
            });
          }
        },
        child: getChild(),
      ),
    );
  }

  ScrollConfiguration getChild() {
    return ScrollConfiguration(
      behavior: NoOverFlowScrollbarBehaviour(),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const HomeAppBarWidget(
                leftIcon: imageBackArrowIcon, title: 'Bank Details'),
            Padding(
              padding: const EdgeInsets.only(
                  left: 28, right: 28, top: 15, bottom: 28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  StreamBuilder<bool>(
                    stream: myBankStreamController.stream,
                    builder: (context, snapshot) => (myBanks.isEmpty)
                        ? const SizedBox()
                        : Column(
                            children: [
                              ListView.builder(
                                  itemCount: myBanks.length,
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemBuilder: (_, index) => Padding(
                                        padding: EdgeInsets.only(
                                            top: (index == 0) ? 0 : 15),
                                        child: BankItemWidget(
                                          myBankData: myBanks[index],
                                          onDelete: () {
                                            BlocProvider.of<BankDetailBloc>(
                                                    context)
                                                .add(
                                              DeleteMyBanksEvent(
                                                bankId: myBanks[index].id ?? '',
                                                model: DeleteBankRequestModel(
                                                  pin: '4561',
                                                ),
                                              ),
                                            );
                                          },
                                          onUpdate: () {
                                            comingSoon();
                                            return;
                                            selectedBankDetailEnum =
                                                BankDetailEnum.updateBank;
                                            selectedBankData = myBanks[index];
                                            if (allBankData.isEmpty) {
                                              BlocProvider.of<BankDetailBloc>(
                                                      context)
                                                  .add(GetAllBanksEvent());
                                            } else {
                                              onClickAddBankAccount();
                                            }
                                          },
                                        ),
                                      )),
                              const SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                  ),
                  Center(
                    child: SizedBox(
                      width: 220,
                      child: Button(
                        'Add Bank Account',
                        backgroundColor: ColorList.lightBlue3Color,
                        textColor: ColorList.primaryColor,
                        overlayColor: ColorList.blueColor,
                        borderRadius: 24,
                        verticalPadding: 10,
                        onPressed: () {
                          selectedBankDetailEnum = BankDetailEnum.addBank;
                          selectedBankData = null;
                          if (allBankData.isEmpty) {
                            BlocProvider.of<BankDetailBloc>(context)
                                .add(GetAllBanksEvent());
                          } else {
                            onClickAddBankAccount();
                          }
                        },
                        postIcon: bankDetailsIcon,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  onClickAddBankAccount() {
    BlocProvider.of<DashboardBloc>(context).add(HideDisableBottomScreenEvent());
    showCustomBottomSheet(AddBankDetailsPage(
      banks: allBankData,
      bankDetailEnum: selectedBankDetailEnum,
      bankName: selectedBankData?.bankName ?? '',
      accountNumber: selectedBankData?.accountNumber ?? '',
      accountName: selectedBankData?.accountName ?? '',
      onSave: () {
        Future.delayed(
          const Duration(milliseconds: 300),
          () {
            callGetAllMyBanks();
          },
        );
      },
    )).then((value) {
      BlocProvider.of<DashboardBloc>(context)
          .add(ShowEnableBottomScreenEvent());
    });
  }

  @override
  void dispose() {
    super.dispose();
    myBankStreamController.close();
  }
}
