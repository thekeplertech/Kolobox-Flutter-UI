import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kolobox_new_app/core/colors/color_list.dart';
import 'package:kolobox_new_app/core/constants/image_constants.dart';
import 'package:kolobox_new_app/core/ui/style/app_style.dart';
import 'package:kolobox_new_app/feature/account/bank_details/presentation/bank_details_page.dart';
import 'package:kolobox_new_app/feature/account/history/presentation/history_page.dart';
import 'package:kolobox_new_app/feature/account/next_of_kin/presentation/next_of_kin_page.dart';
import 'package:kolobox_new_app/feature/account/notification/presentation/notification_settings_page.dart';
import 'package:kolobox_new_app/feature/account/security/presentation/security_page.dart';
import 'package:kolobox_new_app/routes/routes.dart';

import '../../../../../core/base/base_bloc_widget.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/ui/widgets/button.dart';
import '../../../../core/ui/widgets/no_app_bar.dart';
import '../../../../core/ui/widgets/no_overflow_scrollbar_behaviour.dart';
import '../../../dashboard/presentation/bloc/dashboard_bloc.dart';
import '../../../dashboard/presentation/bloc/dashboard_event.dart';
import '../../../widgets/home_app_bar_widget.dart';

class SettingsScreen extends BaseBlocWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  SettingsScreenState createState() => SettingsScreenState();
}

class SettingsScreenState extends BaseBlocWidgetState<SettingsScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget getCustomBloc() => Scaffold(
        backgroundColor: ColorList.white,
        appBar: const NoAppBar(),
        body: Padding(
          padding: const EdgeInsets.only(bottom: dashboardTabHeight),
          child: Column(
            children: [
              HomeAppBarWidget(
                leftIcon: imageBackArrowIcon,
                onLeftPressed: () => goBack(context),
                title: 'Settings',
              ),
              Expanded(
                child: ScrollConfiguration(
                  behavior: NoOverFlowScrollbarBehaviour(),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 28, right: 28),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          getSupportCenterWidget(),
                          InkWell(
                              onTap: () {
                                BlocProvider.of<DashboardBloc>(context)
                                    .add(HideDisableBottomScreenEvent());
                                navigatePush(context, const HistoryPage())
                                    .then((value) {
                                  BlocProvider.of<DashboardBloc>(context)
                                      .add(ShowEnableBottomScreenEvent());
                                });
                              },
                              child: getSelectionOptionWidget(
                                  'History', imageHistoryIcon)),
                          Divider(
                              color: ColorList.greyDisableCircleColor,
                              height: 1,
                              thickness: 1),
                          getSelectionOptionWidget('Account Verification',
                              imageAccountVerificationIcon),
                          Divider(
                              color: ColorList.greyDisableCircleColor,
                              height: 1,
                              thickness: 1),
                          InkWell(
                            onTap: () {
                              navigatePush(context, const BankDetailsPage());
                            },
                            child: getSelectionOptionWidget(
                                'Bank Details', imageBankDetailsIcon),
                          ),
                          Divider(
                              color: ColorList.greyDisableCircleColor,
                              height: 1,
                              thickness: 1),
                          InkWell(
                            onTap: () {
                              BlocProvider.of<DashboardBloc>(context)
                                  .add(HideDisableBottomScreenEvent());
                              navigatePush(
                                      context, const NotificationSettingsPage())
                                  .then((value) {
                                BlocProvider.of<DashboardBloc>(context)
                                    .add(ShowEnableBottomScreenEvent());
                              });
                            },
                            child: getSelectionOptionWidget(
                                'Notification', imageNotificationIcon),
                          ),
                          Divider(
                              color: ColorList.greyDisableCircleColor,
                              height: 1,
                              thickness: 1),
                          InkWell(
                            onTap: () {
                              navigatePush(context, const NextOfKinPage());
                            },
                            child: getSelectionOptionWidget(
                                'Next Of Kin', imageNextOfKinIcon),
                          ),
                          Divider(
                              color: ColorList.greyDisableCircleColor,
                              height: 1,
                              thickness: 1),
                          InkWell(
                            onTap: () {
                              navigatePush(context, const SecurityPage());
                            },
                            child: getSelectionOptionWidget(
                                'Security', imageSecurityIcon),
                          ),
                          Divider(
                              color: ColorList.greyDisableCircleColor,
                              height: 1,
                              thickness: 1),
                          getSelectionOptionWidget('About', imageAboutIcon),
                          Divider(
                              color: ColorList.greyDisableCircleColor,
                              height: 1,
                              thickness: 1),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(28),
                child: Button(
                  'Log Out',
                  backgroundColor: ColorList.lightRed2Color,
                  textColor: ColorList.redDarkColor,
                  overlayColor: ColorList.blueColor,
                  borderRadius: 32,
                  onPressed: () => logout(),
                ),
              ),
            ],
          ),
        ),
      );

  Widget getSelectionOptionWidget(String title, String icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Row(
        children: [
          Image.asset(icon),
          const SizedBox(
            width: 8,
          ),
          Text(
            title,
            style:
                AppStyle.b7Medium.copyWith(color: ColorList.blackSecondColor),
          ),
          const Spacer(),
          Image.asset(imageRightArrowIcon),
        ],
      ),
    );
  }

  Widget getSupportCenterWidget() => GestureDetector(
        onTap: () => comingSoon(),
        child: Container(
          decoration: BoxDecoration(
            color: ColorList.primaryColor,
            borderRadius: BorderRadius.circular(12),
          ),
          width: double.maxFinite,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 22),
          child: Row(
            children: [
              Image.asset(imageSupportCenterIcon),
              const SizedBox(
                width: 12,
              ),
              Text(
                'Support Center',
                style: AppStyle.b6Medium.copyWith(color: ColorList.white),
              ),
              const Spacer(),
              Image.asset(imageRightTriangleArrowIcon),
            ],
          ),
        ),
      );

  @override
  void dispose() {
    super.dispose();
  }
}
