import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kolobox_new_app/core/colors/color_list.dart';
import 'package:kolobox_new_app/core/constants/image_constants.dart';
import 'package:kolobox_new_app/core/enums/kolobox_fund_enum.dart';
import 'package:kolobox_new_app/core/ui/style/app_style.dart';
import 'package:kolobox_new_app/feature/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:kolobox_new_app/feature/dashboard/presentation/bloc/dashboard_event.dart';
import 'package:kolobox_new_app/feature/kolotarget/presentation/bloc/kolo_target_event.dart';
import 'package:kolobox_new_app/feature/widgets/create_kolo_target/create_kolo_target_widget.dart';
import 'package:kolobox_new_app/feature/widgets/kolo_info_widget.dart';

import '../../../../../core/base/base_bloc_widget.dart';
import '../../../../core/ui/widgets/button.dart';
import '../../../../core/ui/widgets/currency_text_input_formatter.dart';
import '../../../../core/ui/widgets/no_app_bar.dart';
import '../../../../core/ui/widgets/no_overflow_scrollbar_behaviour.dart';
import '../../../../routes/routes.dart';
import '../../../dashboard/data/models/earnings_data_model.dart';
import '../../../dashboard/data/models/transactions_data_model.dart';
import '../../../dashboard/data/models/transactions_request_model.dart';
import '../../../kolo_transaction_detail/presentation/kolo_transaction_detail_page.dart';
import '../../../widgets/home_app_bar_widget.dart';
import '../bloc/kolo_target_bloc.dart';
import '../bloc/kolo_target_state.dart';
import '../widgets/kolo_target_item_widget.dart';

class KoloTargetScreen extends BaseBlocWidget {
  final EarningsDataModel earningsDataModel;

  const KoloTargetScreen({
    Key? key,
    required this.earningsDataModel,
  }) : super(key: key);

  @override
  KoloTargetScreenState createState() => KoloTargetScreenState();
}

class KoloTargetScreenState extends BaseBlocWidgetState<KoloTargetScreen> {
  StreamController<bool> leftRightStreamController =
      StreamController<bool>.broadcast();
  bool isLeft = true;

  bool isActiveEmpty = true;
  bool isPaidEmpty = true;

  List<Transactions> transactions = [];
  EarningsDataModel? earningsDataModel;
  double interestAmount = 0;

  @override
  void initState() {
    earningsDataModel = widget.earningsDataModel;
    checkEarningsData();
    super.initState();
    callTransactions();
  }

  checkEarningsData() {
    interestAmount = 0;
    if (!(earningsDataModel?.products?.isEmpty ?? true)) {
      for (var element in earningsDataModel!.products!) {
        interestAmount += double.parse(element.earning?.toString() ?? '0');
      }
    }
  }

  callTransactions() =>
      BlocProvider.of<KoloTargetBloc>(context).add(GetTransactionsEvent(
        model: TransactionsRequestModel(
            productId: KoloboxFundEnum.koloTarget.getProductId),
      ));

  @override
  Widget getCustomBloc() {
    return Scaffold(
      backgroundColor: ColorList.white,
      appBar: const NoAppBar(),
      body: BlocListener<KoloTargetBloc, KoloTargetState>(
        listener: (_, state) {
          if (state is GetTransactionsState) {
            transactions = state.model.transactions ?? [];
            isActiveEmpty = transactions.isEmpty;
            // emptyStreamController.add(isActiveEmpty);
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
            HomeAppBarWidget(
              leftIcon: imageBackArrowIcon,
              rightIcon: imageInfoIcon,
              onRightPressed: () {
                BlocProvider.of<DashboardBloc>(context)
                    .add(HideDisableBottomScreenEvent());
                showCustomBottomSheet(const KoloInfoWidget(
                  koloboxFundEnum: KoloboxFundEnum.koloTarget,
                )).then((value) {
                  BlocProvider.of<DashboardBloc>(context)
                      .add(ShowEnableBottomScreenEvent());
                });
              },
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 28, vertical: 18.52),
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Kolotarget Investment',
                    style: AppStyle.b7SemiBold
                        .copyWith(color: ColorList.blackSecondColor),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    CurrencyTextInputFormatter.formatAmount(
                        KoloboxFundEnum.koloTarget.getDepositAmountValue()),
                    style:
                        AppStyle.b2Bold.copyWith(color: ColorList.primaryColor),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: ColorList.lightBlue7Color,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 13, vertical: 18),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Total Interest (${CurrencyTextInputFormatter.formatAmount(KoloboxFundEnum.koloTarget.getInterestRate(), isSymbol: false)}% p.a)',
                          style: AppStyle.b8SemiBold
                              .copyWith(color: ColorList.blackSecondColor),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              CurrencyTextInputFormatter.formatAmountDouble(
                                  interestAmount),
                              style: AppStyle.b7Bold
                                  .copyWith(color: ColorList.primaryColor),
                            ),
                            const SizedBox(
                              height: 3,
                            ),
                            Text(
                              'Interest in ${KoloboxFundEnum.koloTarget.getTenor()} days',
                              style: AppStyle.b9Medium
                                  .copyWith(color: ColorList.blackThirdColor),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  StreamBuilder<bool>(
                    initialData: isLeft,
                    stream: leftRightStreamController.stream,
                    builder: (_, snapshot) => Column(
                      children: [
                        if (!isActiveEmpty) ...[
                          Button(
                            'Create new target',
                            backgroundColor: ColorList.lightBlue3Color,
                            textColor: ColorList.primaryColor,
                            overlayColor: ColorList.blueColor,
                            borderRadius: 32,
                            onPressed: () {
                              onClickCreateTarget();
                            },
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                        ],
                        Container(
                          width: double.maxFinite,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: ColorList.greyLight6Color, width: 1),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          padding: const EdgeInsets.all(5),
                          child: Row(
                            children: [
                              Expanded(
                                child: Button(
                                  'Active',
                                  borderRadius: 12,
                                  verticalPadding: 10,
                                  height: 31,
                                  backgroundColor:
                                      isLeft ? null : ColorList.white,
                                  overlayColor: ColorList.blueColor,
                                  textStyle: AppStyle.b9SemiBold.copyWith(
                                      color: isLeft
                                          ? ColorList.white
                                          : ColorList.blackThirdColor),
                                  onPressed: () {
                                    isLeft = true;
                                    leftRightStreamController.add(isLeft);
                                  },
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Expanded(
                                child: Button(
                                  'Paid',
                                  borderRadius: 12,
                                  verticalPadding: 10,
                                  height: 31,
                                  backgroundColor:
                                      !isLeft ? null : ColorList.white,
                                  overlayColor: ColorList.blueColor,
                                  textStyle: AppStyle.b9SemiBold.copyWith(
                                      color: !isLeft
                                          ? ColorList.white
                                          : ColorList.blackThirdColor),
                                  onPressed: () {
                                    isLeft = false;
                                    leftRightStreamController.add(isLeft);
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Targets',
                            style: AppStyle.b7SemiBold
                                .copyWith(color: ColorList.blackSecondColor),
                          ),
                        ),
                        if (isLeft) ...[
                          if (isActiveEmpty)
                            getEmptyWidget(true)
                          else
                            getActiveWidget(),
                        ] else ...[
                          if (isPaidEmpty)
                            getEmptyWidget(false)
                          else
                            getPaidWidget(),
                        ],
                      ],
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

  Widget getEmptyWidget(bool isActive) => Column(
        children: [
          const SizedBox(
            height: 60,
          ),
          // Icon(
          //   koloboxFundEnum.getFundIconValue,
          //   size: 60,
          //   color: koloboxFundEnum.getFundIconColorValue,
          // ),
          const SizedBox(
            height: 20,
          ),
          Text(
            'You have not created any target yet',
            style: AppStyle.b8Medium.copyWith(color: ColorList.blackThirdColor),
          ),
          const SizedBox(
            height: 20,
          ),
          if (isActive) ...[
            SizedBox(
              width: 174,
              child: Button(
                'Create',
                backgroundColor: ColorList.lightBlue3Color,
                textColor: ColorList.primaryColor,
                overlayColor: ColorList.blueColor,
                borderRadius: 32,
                onPressed: () {
                  onClickCreateTarget();
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ],
      );

  void onClickCreateTarget() {
    BlocProvider.of<DashboardBloc>(context).add(HideDisableBottomScreenEvent());
    showCustomBottomSheet(const CreateKoloTargetWidget()).then((value) {
      BlocProvider.of<DashboardBloc>(context)
          .add(ShowEnableBottomScreenEvent());
      isActiveEmpty = false;
      isPaidEmpty = false;
      leftRightStreamController.add(true);
    });
  }

  Widget getActiveWidget() {
    return Column(
      children: [
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 5,
          itemBuilder: (_, index) => Padding(
            padding: const EdgeInsets.only(top: 15),
            child: KoloTargetItemWidget(
              onPressed: () {
                navigatePush(
                    context,
                    const KoloTransactionDetailPage(
                      isPaid: false,
                    ));
              },
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }

  Widget getPaidWidget() {
    return Column(
      children: [
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 5,
          itemBuilder: (_, index) => Padding(
            padding: const EdgeInsets.only(top: 15),
            child: KoloTargetItemWidget(
              isPaid: true,
              onPressed: () {
                navigatePush(
                    context,
                    const KoloTransactionDetailPage(
                      isPaid: true,
                    ));
              },
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
    leftRightStreamController.close();
  }
}
