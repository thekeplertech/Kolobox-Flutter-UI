import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kolobox_new_app/core/colors/color_list.dart';
import 'package:kolobox_new_app/core/constants/app_constants.dart';
import 'package:kolobox_new_app/core/constants/image_constants.dart';
import 'package:kolobox_new_app/core/ui/style/app_style.dart';
import 'package:kolobox_new_app/feature/dashboard/data/models/get_family_user_request_model.dart';
import 'package:kolobox_new_app/feature/dashboard/data/models/get_group_list_response_model.dart';
import 'package:kolobox_new_app/feature/dashboard/data/models/group_users_request_model.dart';

import '../../../../../core/base/base_bloc_widget.dart';
import '../../../../core/enums/kolobox_fund_enum.dart';
import '../../../../core/ui/widgets/button.dart';
import '../../../../core/ui/widgets/currency_text_input_formatter.dart';
import '../../../../core/ui/widgets/no_app_bar.dart';
import '../../../../core/ui/widgets/no_overflow_scrollbar_behaviour.dart';
import '../../../../core/utils/date_helper.dart';
import '../../../../routes/routes.dart';
import '../../../dashboard/data/models/get_family_user_list_response_model.dart';
import '../../../dashboard/data/models/group_transactions_data_model.dart';
import '../../../dashboard/data/models/group_transactions_request_model.dart';
import '../../../dashboard/data/models/group_users_data_model.dart';
import '../../../dashboard/data/models/investment_goal_response_model.dart';
import '../../../dashboard/data/models/transactions_data_model.dart';
import '../../../dashboard/data/models/transactions_request_model.dart';
import '../../../dashboard/presentation/bloc/dashboard_bloc.dart';
import '../../../dashboard/presentation/bloc/dashboard_event.dart';
import '../../../family_contributors/presentation/family_contributors_page.dart';
import '../../../family_contributors/presentation/widgets/family_contributors_widget.dart';
import '../../../koloflex/presentation/bloc/kolo_flex_bloc.dart';
import '../../../koloflex/presentation/bloc/kolo_flex_event.dart';
import '../../../koloflex/presentation/bloc/kolo_flex_state.dart';
import '../../../koloflex/presentation/widgets/transactions_item_widget.dart';
import '../../../widgets/deposit/deposit_your_kolobox_widget_page.dart';
import '../../../widgets/deposited_withdrawal_info/deposited_withdrawal_info_kolobox_widget.dart';
import '../../../widgets/home_app_bar_widget.dart';
import '../../../widgets/inherited_state_container.dart';
import '../../../widgets/invite_user/invite_family_member.dart';

class KoloTransactionDetailScreen extends BaseBlocWidget {
  final InvestmentGoalModel? investmentGoalModel;
  final GroupModel? groupModel;
  final double interestAmount;
  final bool isPaid;
  final KoloboxFundEnum koloboxFundEnum;

  const KoloTransactionDetailScreen({
    Key? key,
    required this.isPaid,
    required this.interestAmount,
    required this.investmentGoalModel,
    required this.groupModel,
    required this.koloboxFundEnum,
  }) : super(key: key);

  @override
  KoloTransactionDetailState createState() => KoloTransactionDetailState();
}

class KoloTransactionDetailState
    extends BaseBlocWidgetState<KoloTransactionDetailScreen> {
  // StreamController<bool> leftRightStreamController =
  //     StreamController<bool>.broadcast();
  // bool isLeft = true;
  //
  // bool isRecentEmpty = true;
  // bool isFailedEmpty = true;
  //
  // StreamController<bool> recurringDepositStreamController =
  //     StreamController<bool>.broadcast();
  // bool isRecurringDeposit = false;

  StreamController<bool> emptyStreamController =
      StreamController<bool>.broadcast();
  StreamController<bool> usersStreamController =
      StreamController<bool>.broadcast();
  bool isEmpty = true;

  List<Transactions> transactions = [];
  List<GroupTransactions> groupTransactions = [];
  List<GroupUsers> groupUsers = [];
  List<FamilyUserModel> familyUsers = [];

  KoloboxFundEnum koloboxFundEnum = KoloboxFundEnum.koloTarget;
  InvestmentGoalModel? investmentGoalModel;
  GroupModel? groupModel;
  double interestAmount = 0;

  @override
  void initState() {
    investmentGoalModel = widget.investmentGoalModel;
    groupModel = widget.groupModel;
    interestAmount = widget.interestAmount;
    koloboxFundEnum = widget.koloboxFundEnum;
    super.initState();
    if (koloboxFundEnum == KoloboxFundEnum.koloTarget) {
      callTransactions();
    } else {
      callGroupTransactions();
    }
  }

  callTransactions() =>
      BlocProvider.of<KoloFlexBloc>(context).add(GetTransactionsEvent(
        model:
            TransactionsRequestModel(productId: koloboxFundEnum.getProductId),
      ));

  callGroupTransactions() =>
      BlocProvider.of<KoloFlexBloc>(context).add(GetGroupTransactionsEvent(
        model:
            GroupTransactionsRequestModel(groupId: groupModel?.groupId ?? ''),
      ));

  callGroupUsers() =>
      BlocProvider.of<KoloFlexBloc>(context).add(GetGroupUsersEvent(
        model: GroupUsersRequestModel(groupId: groupModel?.groupId ?? ''),
      ));

  callFamilyUsers() =>
      BlocProvider.of<KoloFlexBloc>(context).add(GetFamilyUsersEvent(
        model: GetFamilyUserRequestModel(groupId: groupModel?.groupId ?? ''),
      ));

  @override
  Widget getCustomBloc() {
    return Scaffold(
      backgroundColor: ColorList.white,
      appBar: const NoAppBar(),
      body: BlocListener<KoloFlexBloc, KoloFlexState>(
        listener: (_, state) {
          if (state is GetTransactionsState) {
            transactions = state.model.transactions ?? [];
            isEmpty = transactions.isEmpty;
            emptyStreamController.add(isEmpty);
          }
          if (state is GetGroupTransactionsState) {
            groupTransactions = state.model.transactions ?? [];
            isEmpty = groupTransactions.isEmpty;
            emptyStreamController.add(isEmpty);
            Future.delayed(const Duration(milliseconds: 300), () {
              if (koloboxFundEnum == KoloboxFundEnum.koloGroup) {
                callGroupUsers();
              } else if (koloboxFundEnum == KoloboxFundEnum.koloFamily) {
                callFamilyUsers();
              }
            });
          }
          if (state is GetGroupUsersState) {
            groupUsers = state.model.users ?? [];
            usersStreamController.add(true);
          }
          if (state is GetFamilyUsersState) {
            familyUsers = state.model.users ?? [];
            usersStreamController.add(true);
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
            const HomeAppBarWidget(leftIcon: imageBackArrowIcon),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 28, vertical: 18.52),
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    '${koloboxFundEnum.getFundValue} Investment',
                    style: AppStyle.b7SemiBold
                        .copyWith(color: ColorList.blackSecondColor),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    CurrencyTextInputFormatter.formatAmount(
                        koloboxFundEnum.getEarningsAmountValueByGroup(
                            groupModel?.groupId ?? '')),
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
                          'Interest (${CurrencyTextInputFormatter.formatAmount(koloboxFundEnum.getInterestRate(), isSymbol: false)}% p.a)',
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
                              'Paid Interest',
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
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                            color: ColorList.greyLight11Color, width: 1)),
                    padding: const EdgeInsets.only(
                        left: 10, right: 10, top: 12, bottom: 10),
                    child: Column(
                      children: [
                        Text(
                          'Target',
                          style: AppStyle.b9Medium
                              .copyWith(color: ColorList.greyLight12Color),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          investmentGoalModel?.purpose ??
                              (groupModel?.name ?? ''),
                          style: AppStyle.b7Bold
                              .copyWith(color: ColorList.blackSecondColor),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          (investmentGoalModel?.goalAmount != null)
                              ? CurrencyTextInputFormatter.formatAmountDouble(
                                  investmentGoalModel?.goalAmount)
                              : CurrencyTextInputFormatter.formatAmountDouble(
                                  double.parse(
                                      groupModel?.minimumAmount ?? '0.0')),
                          style: AppStyle.b8SemiBold
                              .copyWith(color: ColorList.primaryColor),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: ColorList.lightBlue9Color,
                          ),
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 12),
                          child: Row(
                            children: [
                              Text(
                                'Start date',
                                style: AppStyle.b9Medium.copyWith(
                                    color: ColorList.greyLight12Color),
                              ),
                              const SizedBox(
                                width: 3,
                              ),
                              Text(
                                DateHelper.getDateFromDateTime(
                                    koloboxFundEnum
                                        .getStartDate(groupModel?.groupId),
                                    'dd MMM yyyy'),
                                style: AppStyle.b9SemiBold.copyWith(
                                    color: ColorList.blackSecondColor),
                              ),
                              const Spacer(),
                              Text(
                                'End date',
                                style: AppStyle.b9Medium.copyWith(
                                    color: ColorList.greyLight12Color),
                              ),
                              const SizedBox(
                                width: 3,
                              ),
                              Text(
                                DateHelper.getDateFromDateTime(
                                    koloboxFundEnum
                                        .getEndDate(groupModel?.groupId),
                                    'dd MMM yyyy'),
                                style: AppStyle.b9SemiBold.copyWith(
                                    color: widget.isPaid
                                        ? ColorList.redDarkColor
                                        : ColorList.blackSecondColor),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Button(
                          'Deposit',
                          backgroundColor: ColorList.lightBlue3Color,
                          textColor: ColorList.primaryColor,
                          overlayColor: ColorList.blueColor,
                          borderRadius: 24,
                          verticalPadding: 10,
                          onPressed: () {
                            onClickDeposit();
                          },
                          postIcon: imageDownload,
                        ),
                      ),
                      if (widget.koloboxFundEnum !=
                          KoloboxFundEnum.koloTarget) ...[
                        const SizedBox(width: 10),
                        Expanded(
                          child: Button(
                            'Invite',
                            backgroundColor: ColorList.lightBlue3Color,
                            textColor: ColorList.primaryColor,
                            overlayColor: ColorList.blueColor,
                            borderRadius: 24,
                            verticalPadding: 10,
                            onPressed: () {
                              onClickInvite();
                            },
                            postIcon: imageUserIcon,
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  StreamBuilder<bool>(
                      stream: usersStreamController.stream,
                      builder: (context, snapshot) {
                        if (koloboxFundEnum == KoloboxFundEnum.koloGroup) {
                          return getGroupUserListWidget();
                        } else if (koloboxFundEnum ==
                            KoloboxFundEnum.koloFamily) {
                          return getFamilyUserListWidget();
                        } else {
                          return const SizedBox();
                        }
                      }),
                  const SizedBox(
                    height: 15,
                  ),
                  StreamBuilder<bool>(
                      stream: emptyStreamController.stream,
                      builder: (context, snapshot) {
                        return (koloboxFundEnum == KoloboxFundEnum.koloTarget
                                ? transactions.isEmpty
                                : groupTransactions.isEmpty)
                            ? getEmptyWidget(true)
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Recent Transaction',
                                    style: AppStyle.b8SemiBold.copyWith(
                                        color: ColorList.blackSecondColor),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  ListView.builder(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: koloboxFundEnum ==
                                              KoloboxFundEnum.koloTarget
                                          ? transactions.length
                                          : groupTransactions.length,
                                      itemBuilder: (_, index) =>
                                          TransactionsItemWidget(
                                            transactions: koloboxFundEnum ==
                                                    KoloboxFundEnum.koloTarget
                                                ? transactions[index]
                                                : null,
                                            groupTransactions:
                                                koloboxFundEnum ==
                                                        KoloboxFundEnum
                                                            .koloTarget
                                                    ? null
                                                    : groupTransactions[index],
                                            onPressed: () {
                                              BlocProvider.of<DashboardBloc>(
                                                      context)
                                                  .add(
                                                      HideDisableBottomScreenEvent());
                                              showCustomBottomSheet(
                                                DepositedWithdrawalInfoKoloboxWidget(
                                                  transactions:
                                                      koloboxFundEnum ==
                                                              KoloboxFundEnum
                                                                  .koloTarget
                                                          ? transactions[index]
                                                          : null,
                                                  groupTransactions:
                                                      koloboxFundEnum ==
                                                              KoloboxFundEnum
                                                                  .koloTarget
                                                          ? null
                                                          : groupTransactions[
                                                              index],
                                                ),
                                                height: 0.75,
                                              ).then((value) {
                                                BlocProvider.of<DashboardBloc>(
                                                        context)
                                                    .add(
                                                        ShowEnableBottomScreenEvent());
                                              });
                                            },
                                          )),
                                  const SizedBox(
                                    height: 20 + dashboardTabHeight,
                                  ),
                                ],
                              );
                      }),
                  // if (!widget.isPaid) ...[
                  //   StreamBuilder<bool>(
                  //       initialData: isRecurringDeposit,
                  //       stream: recurringDepositStreamController.stream,
                  //       builder: (context, snapshot) {
                  //         return isRecurringDeposit
                  //             ? getRecurringDepositDetailWidget()
                  //             : GestureDetector(
                  //                 onTap: () {
                  //                   onClickRecurringDeposit();
                  //                 },
                  //                 child: Container(
                  //                   decoration: BoxDecoration(
                  //                       borderRadius:
                  //                           BorderRadius.circular(14),
                  //                       border: Border.all(
                  //                           color: ColorList.greyLight6Color,
                  //                           width: 1)),
                  //                   padding: const EdgeInsets.symmetric(
                  //                       vertical: 10, horizontal: 20),
                  //                   child: Row(
                  //                     mainAxisAlignment:
                  //                         MainAxisAlignment.spaceBetween,
                  //                     children: [
                  //                       Text(
                  //                         'Enable recurring deposit',
                  //                         style: AppStyle.b9Medium.copyWith(
                  //                             color: ColorList.primaryColor),
                  //                       ),
                  //                       Image.asset(
                  //                         imageSendIcon,
                  //                         width: 20,
                  //                         height: 20,
                  //                         color: ColorList.primaryColor,
                  //                       ),
                  //                     ],
                  //                   ),
                  //                 ),
                  //               );
                  //       }),
                  //   const SizedBox(
                  //     height: 15,
                  //   ),
                  // ],
                  // if (widget.isPaid) ...[
                  //   Button(
                  //     'View Payout',
                  //     backgroundColor: ColorList.lightBlue3Color,
                  //     textColor: ColorList.primaryColor,
                  //     overlayColor: ColorList.blueColor,
                  //     borderRadius: 32,
                  //     onPressed: () {
                  //       comingSoon();
                  //     },
                  //   ),
                  //   const SizedBox(
                  //     height: 15,
                  //   ),
                  // ],
                  // StreamBuilder<bool>(
                  //   initialData: isLeft,
                  //   stream: leftRightStreamController.stream,
                  //   builder: (_, snapshot) => Column(
                  //     children: [
                  //       if (!isRecentEmpty && !widget.isPaid) ...[
                  //         Row(
                  //           children: [
                  //             Expanded(
                  //               child: Button(
                  //                 'Deposit',
                  //                 backgroundColor: ColorList.lightBlue3Color,
                  //                 textColor: ColorList.primaryColor,
                  //                 overlayColor: ColorList.blueColor,
                  //                 borderRadius: 24,
                  //                 verticalPadding: 10,
                  //                 onPressed: () {
                  //                   onClickDeposit();
                  //                 },
                  //                 postIcon: imageDownload,
                  //               ),
                  //             ),
                  //             const SizedBox(width: 10),
                  //             Expanded(
                  //               child: Button(
                  //                 'Invite',
                  //                 backgroundColor: ColorList.lightBlue3Color,
                  //                 textColor: ColorList.primaryColor,
                  //                 overlayColor: ColorList.blueColor,
                  //                 borderRadius: 24,
                  //                 verticalPadding: 10,
                  //                 onPressed: () {
                  //                   onClickInvite();
                  //                 },
                  //                 postIcon: imageUserIcon,
                  //               ),
                  //             ),
                  //           ],
                  //         ),
                  //         const SizedBox(
                  //           height: 20,
                  //         ),
                  //       ],
                  //       // if (koloboxFundEnum == KoloboxFundEnum.koloFamily ||
                  //       //     koloboxFundEnum == KoloboxFundEnum.koloGroup) ...[
                  //       //   Row(
                  //       //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //       //     children: [
                  //       //       Text(
                  //       //         'Family Contributors',
                  //       //         style: AppStyle.b8Bold.copyWith(
                  //       //             color: ColorList.blackSecondColor),
                  //       //       ),
                  //       //       SizedBox(
                  //       //         width: 84,
                  //       //         child: Button(
                  //       //           'See all',
                  //       //           textColor: ColorList.white,
                  //       //           backgroundColor: ColorList.blackSecondColor,
                  //       //           overlayColor: ColorList.blueColor,
                  //       //           borderRadius: 12,
                  //       //           verticalPadding: 10,
                  //       //           height: 30,
                  //       //           textStyle: AppStyle.b10SemiBold
                  //       //               .copyWith(color: ColorList.white),
                  //       //           onPressed: () async {
                  //       //             BlocProvider.of<DashboardBloc>(context)
                  //       //                 .add(HideDisableBottomScreenEvent());
                  //       //             navigatePush(context,
                  //       //                     const FamilyContributorsPage())
                  //       //                 .then((value) {
                  //       //               BlocProvider.of<DashboardBloc>(context)
                  //       //                   .add(ShowEnableBottomScreenEvent());
                  //       //             });
                  //       //           },
                  //       //         ),
                  //       //       ),
                  //       //     ],
                  //       //   ),
                  //       //   const SizedBox(
                  //       //     height: 15,
                  //       //   ),
                  //       //   GridView.builder(
                  //       //       gridDelegate:
                  //       //           const SliverGridDelegateWithFixedCrossAxisCount(
                  //       //         crossAxisCount: 2,
                  //       //         crossAxisSpacing: 14,
                  //       //         mainAxisSpacing: 14,
                  //       //         childAspectRatio: 1.2,
                  //       //       ),
                  //       //       physics: const NeverScrollableScrollPhysics(),
                  //       //       shrinkWrap: true,
                  //       //       itemCount: 4,
                  //       //       itemBuilder: (_, index) =>
                  //       //           const FamilyContributorsWidget()),
                  //       //   const SizedBox(
                  //       //     height: 15,
                  //       //   ),
                  //       // ],
                  //       Container(
                  //         width: double.maxFinite,
                  //         decoration: BoxDecoration(
                  //           border: Border.all(
                  //               color: ColorList.greyLight6Color, width: 1),
                  //           borderRadius: BorderRadius.circular(14),
                  //         ),
                  //         padding: const EdgeInsets.all(5),
                  //         child: Row(
                  //           children: [
                  //             Expanded(
                  //               child: Button(
                  //                 'Recent Deposit',
                  //                 borderRadius: 12,
                  //                 verticalPadding: 10,
                  //                 height: 31,
                  //                 backgroundColor: isLeft
                  //                     ? ColorList.blackSecondColor
                  //                     : ColorList.white,
                  //                 overlayColor: ColorList.blueColor,
                  //                 textStyle: AppStyle.b9SemiBold.copyWith(
                  //                     color: isLeft
                  //                         ? ColorList.white
                  //                         : ColorList.blackThirdColor),
                  //                 onPressed: () {
                  //                   isLeft = true;
                  //                   leftRightStreamController.add(isLeft);
                  //                 },
                  //               ),
                  //             ),
                  //             const SizedBox(
                  //               width: 5,
                  //             ),
                  //             Expanded(
                  //               child: Button(
                  //                 'Failed Deposit',
                  //                 borderRadius: 12,
                  //                 verticalPadding: 10,
                  //                 height: 31,
                  //                 backgroundColor: !isLeft
                  //                     ? ColorList.blackSecondColor
                  //                     : ColorList.white,
                  //                 overlayColor: ColorList.blueColor,
                  //                 textStyle: AppStyle.b9SemiBold.copyWith(
                  //                     color: !isLeft
                  //                         ? ColorList.white
                  //                         : ColorList.blackThirdColor),
                  //                 onPressed: () {
                  //                   isLeft = false;
                  //                   leftRightStreamController.add(isLeft);
                  //                 },
                  //               ),
                  //             ),
                  //           ],
                  //         ),
                  //       ),
                  //       const SizedBox(
                  //         height: 20,
                  //       ),
                  //       if (isLeft) ...[
                  //         if (isRecentEmpty)
                  //           getEmptyWidget(true)
                  //         else
                  //           getRecentDepositWidget(),
                  //       ] else ...[
                  //         if (isFailedEmpty)
                  //           getEmptyWidget(false)
                  //         else
                  //           getFailedDepositWidget(),
                  //       ],
                  //     ],
                  //   ),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Column getGroupUserListWidget() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              koloboxFundEnum == KoloboxFundEnum.koloFamily
                  ? 'Family Contributors'
                  : 'Contributors',
              style:
                  AppStyle.b8Bold.copyWith(color: ColorList.blackSecondColor),
            ),
            if (groupUsers.length > 4) ...[
              SizedBox(
                width: 84,
                child: Button(
                  'See all',
                  textColor: ColorList.white,
                  backgroundColor: ColorList.blackSecondColor,
                  overlayColor: ColorList.blueColor,
                  borderRadius: 12,
                  verticalPadding: 10,
                  height: 30,
                  textStyle:
                      AppStyle.b10SemiBold.copyWith(color: ColorList.white),
                  onPressed: () async {
                    BlocProvider.of<DashboardBloc>(context)
                        .add(HideDisableBottomScreenEvent());
                    navigatePush(
                        context,
                        FamilyContributorsPage(
                          koloboxFundEnum: koloboxFundEnum,
                          groupUsers: groupUsers,
                        )).then((value) {
                      BlocProvider.of<DashboardBloc>(context)
                          .add(ShowEnableBottomScreenEvent());
                    });
                  },
                ),
              ),
            ],
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 14,
              mainAxisSpacing: 14,
              childAspectRatio: 1.2,
            ),
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: groupUsers.length > 4 ? 4 : groupUsers.length,
            itemBuilder: (_, index) => FamilyContributorsWidget(
                  groupUser: groupUsers[index],
                  koloboxFundEnum: widget.koloboxFundEnum,
                )),
      ],
    );
  }

  Column getFamilyUserListWidget() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Family Contributors',
              style:
                  AppStyle.b8Bold.copyWith(color: ColorList.blackSecondColor),
            ),
            if (familyUsers.length > 4) ...[
              SizedBox(
                width: 84,
                child: Button(
                  'See all',
                  textColor: ColorList.white,
                  backgroundColor: ColorList.blackSecondColor,
                  overlayColor: ColorList.blueColor,
                  borderRadius: 12,
                  verticalPadding: 10,
                  height: 30,
                  textStyle:
                      AppStyle.b10SemiBold.copyWith(color: ColorList.white),
                  onPressed: () async {
                    BlocProvider.of<DashboardBloc>(context)
                        .add(HideDisableBottomScreenEvent());
                    navigatePush(
                        context,
                        FamilyContributorsPage(
                          koloboxFundEnum: koloboxFundEnum,
                          familyUsers: familyUsers,
                        )).then((value) {
                      BlocProvider.of<DashboardBloc>(context)
                          .add(ShowEnableBottomScreenEvent());
                    });
                  },
                ),
              ),
            ],
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 14,
              mainAxisSpacing: 14,
              childAspectRatio: 1.2,
            ),
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: familyUsers.length > 4 ? 4 : familyUsers.length,
            itemBuilder: (_, index) => FamilyContributorsWidget(
                  familyUserModel: familyUsers[index],
                  koloboxFundEnum: widget.koloboxFundEnum,
                )),
      ],
    );
  }

  Widget getEmptyWidget(bool isRecent) => Column(
        children: [
          const SizedBox(
            height: 40,
          ),
          Image.asset(
            imageNoTransactionIcon,
            width: 48,
            height: 48,
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            isRecent
                ? 'You have no recent deposit'
                : 'You have no failed deposit',
            style: AppStyle.b8Medium.copyWith(color: ColorList.blackThirdColor),
          ),
          if (isRecent && !widget.isPaid) ...[
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: 180,
              child: Button(
                'Deposit',
                backgroundColor: ColorList.lightBlue3Color,
                textColor: ColorList.primaryColor,
                overlayColor: ColorList.blueColor,
                borderRadius: 24,
                verticalPadding: 10,
                onPressed: () {
                  onClickDeposit();
                },
                postIcon: imageDownload,
              ),
            ),
          ],
          const SizedBox(
            height: 50,
          ),
        ],
      );

  // void onClickRecurringDeposit() {
  //   comingSoon();
  // StateContainer.of(context).isFromDetail = true;
  // BlocProvider.of<DashboardBloc>(context).add(HideDisableBottomScreenEvent());
  // showCustomBottomSheet(const EnableRecurringDepositWidget()).then((value) {
  //   BlocProvider.of<DashboardBloc>(context)
  //       .add(ShowEnableBottomScreenEvent());
  //   StateContainer.of(context).isFromDetail = false;
  //   isRecentEmpty = false;
  //   isFailedEmpty = false;
  //   leftRightStreamController.add(true);
  //   isRecurringDeposit = true;
  //   recurringDepositStreamController.add(true);
  // });
  // }

  void onClickDeposit() {
    StateContainer.of(context).openFundMyKoloBox(
      fundEnum: koloboxFundEnum,
      popUntil: koloboxFundEnum.getFundPageValue(true),
    );
    BlocProvider.of<DashboardBloc>(context).add(HideDisableBottomScreenEvent());
    showCustomBottomSheet(DepositYourKoloboxWidgetPage(
      key: Key('deposit_your_kolobox_${DateTime.now().millisecondsSinceEpoch}'),
    )).then((value) {
      BlocProvider.of<DashboardBloc>(context)
          .add(ShowEnableBottomScreenEvent());
      if (StateContainer.of(context).isSuccessful) {
        StateContainer.of(context).clearData();
        callGroupTransactions();
      }
    });
  }

  void onClickInvite() {
    StateContainer.of(context).openFundMyKoloBox(
        popUntil: widget.koloboxFundEnum.getFundPageValue(true));
    BlocProvider.of<DashboardBloc>(context).add(HideDisableBottomScreenEvent());
    showCustomBottomSheet(InviteFamilyMemberWidget(
      groupModel: groupModel,
      koloboxFundEnum: koloboxFundEnum,
    )).then((value) {
      BlocProvider.of<DashboardBloc>(context)
          .add(ShowEnableBottomScreenEvent());
      if (StateContainer.of(context).isSuccessful) {
        StateContainer.of(context).clearData();
        if (widget.koloboxFundEnum == KoloboxFundEnum.koloGroup) {
          callGroupUsers();
        } else if (widget.koloboxFundEnum == KoloboxFundEnum.koloFamily) {
          callFamilyUsers();
        }
      }
      // StateContainer.of(context).isFromDetail = false;
      // isRecentEmpty = false;
      // isFailedEmpty = false;
      // leftRightStreamController.add(true);
    });
  }

  // Widget getRecentDepositWidget() {
  //   return Column(
  //     children: [
  // ListView.builder(
  //   shrinkWrap: true,
  //   physics: const NeverScrollableScrollPhysics(),
  //   itemCount: 5,
  //   itemBuilder: (_, index) => Padding(
  //     padding: const EdgeInsets.only(top: 5),
  //     child: TransactionsItemWidget(
  //       onPressed: () {
  //         onClickTransaction();
  //       },
  //     ),
  //   ),
  // ),
  // const SizedBox(
  //   height: 20,
  // ),
  // Button(
  //   'History',
  //   backgroundColor: ColorList.greyLight10Color,
  //   textColor: ColorList.blackSecondColor,
  //   overlayColor: ColorList.blueColor,
  //   borderRadius: 32,
  //   onPressed: () {
  //     comingSoon();
  //   },
  // ),
  // const SizedBox(
  //   height: 20,
  // ),
  // Divider(
  //     thickness: 1, height: 1, color: ColorList.greyDisableCircleColor),
  // const SizedBox(
  //   height: 20,
  // ),
  // Button(
  //   'Cancel Investment',
  //   backgroundColor: ColorList.white,
  //   textColor: ColorList.redDarkColor,
  //   overlayColor: ColorList.redDark2Color,
  //   borderRadius: 32,
  //   onPressed: () {
  //     comingSoon();
  // StateContainer.of(context).isFromDetail = true;
  // BlocProvider.of<DashboardBloc>(context)
  //     .add(HideDisableBottomScreenEvent());
  // showCustomBottomSheet(const CancelInvestmentWidget()).then((value) {
  //   BlocProvider.of<DashboardBloc>(context)
  //       .add(ShowEnableBottomScreenEvent());
  //   StateContainer.of(context).isFromDetail = false;
  // });
  //         },
  //       ),
  //     ],
  //   );
  // }

  // Widget getFailedDepositWidget() {
  //   return Column(
  //     children: [
  // ListView.builder(
  //   shrinkWrap: true,
  //   physics: const NeverScrollableScrollPhysics(),
  //   itemCount: 5,
  //   itemBuilder: (_, index) => Padding(
  //     padding: const EdgeInsets.only(top: 5),
  //     child: TransactionsItemWidget(
  //       onPressed: () {
  //         onClickTransaction();
  //       },
  //     ),
  //   ),
  // ),
  // const SizedBox(
  //   height: 20,
  // ),
  // ],
  // );
  // }

  void onClickTransaction() {
    // StateContainer.of(context).isFromDetail = true;
    // BlocProvider.of<DashboardBloc>(context).add(HideDisableBottomScreenEvent());
    // showCustomBottomSheet(
    //   DepositedWithdrawalInfoKoloboxWidget(
    //     koloboxFundEnum: koloboxFundEnum,
    //   ),
    //   height: 0.75,
    // ).then((value) {
    //   BlocProvider.of<DashboardBloc>(context)
    //       .add(ShowEnableBottomScreenEvent());
    //   StateContainer.of(context).isFromDetail = false;
    // });
  }

  Widget getRecurringDepositDetailWidget() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: ColorList.greyLight11Color, width: 1)),
      padding: const EdgeInsets.only(left: 10, right: 10, top: 12, bottom: 12),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: ColorList.lightBlue9Color,
            ),
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
            child: Row(
              children: [
                Text(
                  'Recurring deposit',
                  style: AppStyle.b9Medium
                      .copyWith(color: ColorList.greyLight12Color),
                ),
                const Spacer(),
                Text(
                  '₦ 80,000.00',
                  style: AppStyle.b9SemiBold
                      .copyWith(color: ColorList.blackSecondColor),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 9,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: ColorList.lightBlue9Color,
            ),
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
            child: Row(
              children: [
                Text(
                  'Upcoming recurring date',
                  style: AppStyle.b9Medium
                      .copyWith(color: ColorList.greyLight12Color),
                ),
                const Spacer(),
                Text(
                  '02 Aug 2022',
                  style: AppStyle.b9SemiBold
                      .copyWith(color: ColorList.blackSecondColor),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 9,
          ),
          Row(
            children: [
              Text(
                'Disable recurring deposit',
                style:
                    AppStyle.b9Medium.copyWith(color: ColorList.redDarkColor),
              ),
              const SizedBox(
                width: 8,
              ),
              Image.asset(
                imageSendIcon,
                color: ColorList.redDarkColor,
              ),
              const Spacer(),
              SizedBox(
                width: 100,
                child: Button(
                  'Update',
                  textColor: ColorList.white,
                  backgroundColor: ColorList.blackSecondColor,
                  overlayColor: ColorList.blueColor,
                  borderRadius: 12,
                  verticalPadding: 10,
                  height: 30,
                  textStyle:
                      AppStyle.b10SemiBold.copyWith(color: ColorList.white),
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    // leftRightStreamController.close();
    emptyStreamController.close();
  }
}
