import 'package:flutter/material.dart';
import 'package:kolobox_new_app/core/colors/color_list.dart';
import 'package:kolobox_new_app/core/constants/image_constants.dart';
import 'package:kolobox_new_app/core/ui/style/app_style.dart';

import '../../../../../core/base/base_bloc_widget.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/ui/widgets/button.dart';
import '../../../../core/ui/widgets/no_app_bar.dart';
import '../../../../core/ui/widgets/no_overflow_scrollbar_behaviour.dart';
import '../../../../routes/routes.dart';
import '../../../settings/presentation/settings_page.dart';
import '../../../widgets/home_app_bar_widget.dart';

class AccountScreen extends BaseBlocWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  AccountScreenState createState() => AccountScreenState();
}

class AccountScreenState extends BaseBlocWidgetState<AccountScreen> {
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
                leftIcon: imageDashboardIcon,
                rightIcon: imageSettingIcon,
                onLeftPressed: () => comingSoon(),
                onRightPressed: () =>
                    navigatePush(context, const SettingsPage()),
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
                            height: 40,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: ColorList.lightBlue6Color,
                              shape: BoxShape.circle,
                            ),
                            padding: const EdgeInsets.all(10),
                            child: Image.asset(imageUserPlaceHolder),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Dami Anoreq',
                            style: AppStyle.b4SemiBold
                                .copyWith(color: ColorList.blackSecondColor),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            '@DamiANQ',
                            style: AppStyle.b8Medium
                                .copyWith(color: ColorList.primaryColor),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          getShareIdWidget(),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Date Of Birth',
                                style: AppStyle.b8Medium.copyWith(
                                    color: ColorList.blackSecondColor),
                              ),
                              Text(
                                'Feb 19, 1992',
                                style: AppStyle.b8Bold.copyWith(
                                    color: ColorList.blackSecondColor),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Divider(
                              color: ColorList.greyDisableCircleColor,
                              height: 1,
                              thickness: 1),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Occupation',
                                style: AppStyle.b8Medium.copyWith(
                                    color: ColorList.blackSecondColor),
                              ),
                              Text(
                                'Product Manager',
                                style: AppStyle.b8Bold.copyWith(
                                    color: ColorList.blackSecondColor),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Divider(
                              color: ColorList.greyDisableCircleColor,
                              height: 1,
                              thickness: 1),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: [
                              Text(
                                'Email',
                                style: AppStyle.b8Medium.copyWith(
                                    color: ColorList.blackSecondColor),
                              ),
                              const Spacer(),
                              Text(
                                'dami_anoreq07@gmail.com',
                                style: AppStyle.b8Bold
                                    .copyWith(color: ColorList.greyLight2Color),
                              ),
                              const SizedBox(
                                width: 9.5,
                              ),
                              Image.asset(imageSecurityShieldIcon),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Divider(
                              color: ColorList.greyDisableCircleColor,
                              height: 1,
                              thickness: 1),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: [
                              Text(
                                'Phone',
                                style: AppStyle.b8Medium.copyWith(
                                    color: ColorList.blackSecondColor),
                              ),
                              const Spacer(),
                              Text(
                                '09083092849',
                                style: AppStyle.b8Bold
                                    .copyWith(color: ColorList.greyLight2Color),
                              ),
                              const SizedBox(
                                width: 9.5,
                              ),
                              Image.asset(imageSecurityShieldIcon),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
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
                  'Edit',
                  backgroundColor: ColorList.lightBlue3Color,
                  textColor: ColorList.primaryColor,
                  overlayColor: ColorList.blueColor,
                  borderRadius: 32,
                  onPressed: () {
                    comingSoon();
                  },
                ),
              ),
            ],
          ),
        ),
      );

  Widget getShareIdWidget() => GestureDetector(
        onTap: () => comingSoon(),
        child: Container(
          decoration: BoxDecoration(
            color: ColorList.primaryColor,
            borderRadius: BorderRadius.circular(12),
          ),
          width: double.maxFinite,
          padding: const EdgeInsets.all(17),
          child: Row(
            children: [
              Image.asset(imageShareIdIcon),
              const SizedBox(
                width: 12,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Share my ID',
                      style: AppStyle.b6Bold.copyWith(color: ColorList.white),
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    Text(
                      'Kolobox.ng/@DamiANQ',
                      style: AppStyle.b9Medium.copyWith(color: ColorList.white),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );

  @override
  void dispose() {
    super.dispose();
  }
}
