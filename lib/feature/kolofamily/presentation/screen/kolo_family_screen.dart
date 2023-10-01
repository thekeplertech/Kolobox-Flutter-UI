import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kolobox_new_app/core/colors/color_list.dart';
import 'package:kolobox_new_app/core/constants/image_constants.dart';
import 'package:kolobox_new_app/core/enums/kolobox_fund_enum.dart';
import 'package:kolobox_new_app/core/ui/style/app_style.dart';
import 'package:kolobox_new_app/feature/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:kolobox_new_app/feature/dashboard/presentation/bloc/dashboard_event.dart';
import 'package:kolobox_new_app/feature/widgets/kolo_info_widget.dart';

import '../../../../../core/base/base_bloc_widget.dart';
import '../../../../core/ui/widgets/button.dart';
import '../../../../core/ui/widgets/currency_text_input_formatter.dart';
import '../../../../core/ui/widgets/no_app_bar.dart';
import '../../../../core/ui/widgets/no_overflow_scrollbar_behaviour.dart';
import '../../../../routes/routes.dart';
import '../../../dashboard/data/models/get_group_list_response_model.dart';
import '../../../kolo_transaction_detail/presentation/kolo_transaction_detail_page.dart';
import '../../../kologroup/presentation/widgets/kolo_group_item_widget.dart';
import '../../../widgets/deposit/deposit_your_kolobox_widget_page.dart';
import '../../../widgets/home_app_bar_widget.dart';
import '../../../widgets/inherited_state_container.dart';
import '../bloc/kolo_family_bloc.dart';
import '../bloc/kolo_family_event.dart';
import '../bloc/kolo_family_state.dart';

class KoloFamilyScreen extends BaseBlocWidget {
  const KoloFamilyScreen({
    Key? key,
  }) : super(key: key);

  @override
  KoloFamilyScreenState createState() => KoloFamilyScreenState();
}

class KoloFamilyScreenState extends BaseBlocWidgetState<KoloFamilyScreen> {
  StreamController<bool> leftRightStreamController =
      StreamController<bool>.broadcast();
  bool isLeft = true;

  List<GroupModel> activeGroupModels = [];
  List<GroupModel> paidGroupModels = [];

  // bool isActiveEmpty = true;
  // bool isPaidEmpty = true;

  // KoloboxFundEnum koloboxFundEnum = KoloboxFundEnum.koloFlex;

  @override
  void initState() {
    super.initState();
    callFamily();
  }

  callFamily() =>
      BlocProvider.of<KoloFamilyBloc>(context).add(GetFamilyEvent());

  @override
  Widget getCustomBloc() {
    // koloboxFundEnum = StateContainer.of(context).koloboxFundEnum;
    return Scaffold(
      backgroundColor: ColorList.white,
      appBar: const NoAppBar(),
      body: BlocListener<KoloFamilyBloc, KoloFamilyState>(
        listener: (_, state) {
          if (state is GetFamilyState) {
            activeGroupModels = state.model.types
                    ?.where((element) => element.isActive)
                    .toList() ??
                [];
            paidGroupModels = state.model.types
                    ?.where((element) => !element.isActive)
                    .toList() ??
                [];
            leftRightStreamController.add(true);
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
                  koloboxFundEnum: KoloboxFundEnum.koloFamily,
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
                    'Kolofamily Investment',
                    style: AppStyle.b7SemiBold
                        .copyWith(color: ColorList.blackSecondColor),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    CurrencyTextInputFormatter.formatAmount(
                        KoloboxFundEnum.koloFamily.getEarningsAmountValue()),
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
                          'Total Interest (${CurrencyTextInputFormatter.formatAmount(KoloboxFundEnum.koloFamily.getInterestRate(), isSymbol: false)}% p.a)',
                          style: AppStyle.b8SemiBold
                              .copyWith(color: ColorList.blackSecondColor),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              CurrencyTextInputFormatter.formatAmountDouble(
                                  KoloboxFundEnum.koloFamily.getInterest()),
                              style: AppStyle.b7Bold
                                  .copyWith(color: ColorList.primaryColor),
                            ),
                            const SizedBox(
                              height: 3,
                            ),
                            Text(
                              'Interest in ${KoloboxFundEnum.koloFamily.getTenor()} days',
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
                        if (activeGroupModels.isNotEmpty ||
                            paidGroupModels.isNotEmpty) ...[
                          Button(
                            'Create New',
                            backgroundColor: ColorList.lightBlue3Color,
                            textColor: ColorList.primaryColor,
                            overlayColor: ColorList.blueColor,
                            borderRadius: 32,
                            onPressed: () {
                              onClickCreateNew();
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
                          if (activeGroupModels.isEmpty)
                            getEmptyWidget(true)
                          else
                            getActiveWidget(),
                        ] else ...[
                          if (paidGroupModels.isEmpty)
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
          Icon(
            KoloboxFundEnum.koloFamily.getFundIconValue,
            size: 60,
            color: KoloboxFundEnum.koloFamily.getFundIconColorValue,
          ),
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
                  onClickCreateNew();
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ],
      );

  void onClickCreateNew() {
    StateContainer.of(context).openFundMyKoloBox(
        fundEnum: KoloboxFundEnum.koloFamily,
        popUntil: KoloboxFundEnum.koloFamily.getFundPageValue(false));
    BlocProvider.of<DashboardBloc>(context).add(HideDisableBottomScreenEvent());
    showCustomBottomSheet(
      DepositYourKoloboxWidgetPage(
        key: Key(
            'deposit_your_kolobox_${DateTime.now().millisecondsSinceEpoch}'),
        isCreateGroup: true,
      ),
    ).then((value) {
      BlocProvider.of<DashboardBloc>(context)
          .add(ShowEnableBottomScreenEvent());
      if (StateContainer.of(context).isSuccessful) {
        Future.delayed(const Duration(milliseconds: 300), () {
          callFamily();
        });
      }
      StateContainer.of(context).clearData();
    });
    // BlocProvider.of<DashboardBloc>(context).add(HideDisableBottomScreenEvent());
    // showCustomBottomSheet(const CreateKoloTargetWidget()).then((value) {
    //   BlocProvider.of<DashboardBloc>(context)
    //       .add(ShowEnableBottomScreenEvent());
    //   isActiveEmpty = false;
    //   isPaidEmpty = false;
    //   leftRightStreamController.add(true);
    // });
    // isActiveEmpty = false;
    // isPaidEmpty = false;
    // leftRightStreamController.add(true);
    // BlocProvider.of<DashboardBloc>(context).add(HideDisableBottomScreenEvent());
    // showCustomBottomSheet(const DepositYourKoloboxWidget(), height: 0.9)
    //     .then((value) {
    //   BlocProvider.of<DashboardBloc>(context)
    //       .add(ShowEnableBottomScreenEvent());
    //   isEmpty = false;
    //   emptyStreamController.add(isEmpty);
    // });
  }

  Widget getActiveWidget() {
    return Column(
      children: [
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: activeGroupModels.length,
          itemBuilder: (_, index) => Padding(
            padding: const EdgeInsets.only(top: 15),
            child: KoloGroupItemWidget(
              model: activeGroupModels[index],
              onPressed: () {
                StateContainer.of(context)
                    .openFundMyKoloBox(fundEnum: KoloboxFundEnum.koloFamily);
                navigatePush(
                  context,
                  KoloTransactionDetailPage(
                    groupModel: activeGroupModels[index],
                    interestAmount: KoloboxFundEnum.koloFamily.getInterest(),
                    isPaid: isLeft,
                    koloboxFundEnum: KoloboxFundEnum.koloFamily,
                  ),
                  routeName: koloTransactionDetailPageValue,
                );
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
          itemCount: paidGroupModels.length,
          itemBuilder: (_, index) => Padding(
            padding: const EdgeInsets.only(top: 15),
            child: KoloGroupItemWidget(
              model: paidGroupModels[index],
              isPaid: true,
              onPressed: () {
                // navigatePush(
                //     context,
                //     const KoloTransactionDetailPage(
                //       isPaid: false,
                //     ));
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
