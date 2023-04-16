import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kolobox_new_app/core/colors/color_list.dart';
import 'package:kolobox_new_app/core/constants/image_constants.dart';
import 'package:kolobox_new_app/core/ui/style/app_style.dart';

import '../../../../../core/base/base_bloc_widget.dart';
import '../../../../../core/ui/widgets/button.dart';
import '../../../../../core/ui/widgets/no_app_bar.dart';
import '../../../../../core/ui/widgets/no_overflow_scrollbar_behaviour.dart';
import '../../../../dashboard/presentation/bloc/dashboard_bloc.dart';
import '../../../../dashboard/presentation/bloc/dashboard_event.dart';
import '../../../../widgets/bank_details/delete_bank_details.dart';
import '../../../../widgets/home_app_bar_widget.dart';

class BankDetailsScreen extends BaseBlocWidget {
  const BankDetailsScreen({
    Key? key,
  }) : super(key: key);

  @override
  BankDetailsState createState() => BankDetailsState();
}

class BankDetailsState extends BaseBlocWidgetState<BankDetailsScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget getCustomBloc() {
    return Scaffold(
      backgroundColor: ColorList.white,
      appBar: const NoAppBar(),
      body: ScrollConfiguration(
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
                    Container(
                      decoration: BoxDecoration(
                          color: ColorList.primaryColor,
                          borderRadius: BorderRadius.circular(14)),
                      // padding: const EdgeInsets.symmetric(
                      //     vertical: 20, horizontal: 16),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 20, bottom: 20, left: 16, right: 10),
                                child: Image.asset(
                                  imageBankDetailsIcon,
                                  color: ColorList.white,
                                  height: 24,
                                  width: 24,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  'Zenith Bank',
                                  style: AppStyle.b7Medium
                                      .copyWith(color: ColorList.white),
                                ),
                              ),
                              GestureDetector(
                                onTap: () => comingSoon(),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 20, bottom: 20, left: 16, right: 8),
                                  child: Image.asset(
                                    deleteIcon,
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () => comingSoon(),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 20, bottom: 20, left: 8, right: 16),
                                  child: Image.asset(
                                    editIcon,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 20, horizontal: 16),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '0949830020004',
                                        style: AppStyle.b7Medium
                                            .copyWith(color: ColorList.white),
                                      ),
                                      Text(
                                        'Dami Anoreq',
                                        style: AppStyle.b7Medium
                                            .copyWith(color: ColorList.white),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () => comingSoon(),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 20, horizontal: 16),
                                  child: Image.asset(
                                    copyIcon,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
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
                            BlocProvider.of<DashboardBloc>(context)
                                .add(HideDisableBottomScreenEvent());
                            showCustomBottomSheet(
                                    const DeleteBankDetailsWidget())
                                .then((value) {
                              BlocProvider.of<DashboardBloc>(context)
                                  .add(ShowEnableBottomScreenEvent());
                            });
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
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
