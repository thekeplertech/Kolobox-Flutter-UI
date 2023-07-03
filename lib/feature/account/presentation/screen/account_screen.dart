import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kolobox_new_app/core/colors/color_list.dart';
import 'package:kolobox_new_app/core/constants/image_constants.dart';
import 'package:kolobox_new_app/core/ui/style/app_style.dart';

import '../../../../../core/base/base_bloc_widget.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/ui/widgets/button.dart';
import '../../../../core/ui/widgets/no_app_bar.dart';
import '../../../../core/ui/widgets/no_overflow_scrollbar_behaviour.dart';
import '../../../../core/utils/date_helper.dart';
import '../../../../routes/routes.dart';
import '../../../dashboard/presentation/bloc/dashboard_bloc.dart';
import '../../../dashboard/presentation/bloc/dashboard_event.dart';
import '../../../settings/presentation/settings_page.dart';
import '../../../widgets/home_app_bar_widget.dart';
import '../../profile/presentation/profile_page.dart';

class AccountScreen extends BaseBlocWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  AccountScreenState createState() => AccountScreenState();
}

class AccountScreenState extends BaseBlocWidgetState<AccountScreen> {
  StreamController<bool> profileStreamController =
      StreamController<bool>.broadcast();

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
                // leftIcon: imageDashboardIcon,
                rightIcon: imageSettingIcon,
                // onLeftPressed: () => comingSoon(),
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
                          StreamBuilder<bool>(
                              stream: profileStreamController.stream,
                              builder: (context, snapshot) {
                                return getDataWidget();
                              }),
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
                    BlocProvider.of<DashboardBloc>(context)
                        .add(HideDisableBottomScreenEvent());
                    navigatePush(context, const ProfilePage()).then((value) {
                      BlocProvider.of<DashboardBloc>(context)
                          .add(ShowEnableBottomScreenEvent());
                      profileStreamController.add(true);
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      );

  Column getDataWidget() {
    return Column(
      children: [
        Text(
          '${prefHelper?.getLoginResponseModel().firstname} ${prefHelper?.getLoginResponseModel().lastname}',
          style:
              AppStyle.b4SemiBold.copyWith(color: ColorList.blackSecondColor),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          '@${prefHelper?.getLoginResponseModel().id}',
          style: AppStyle.b8Medium.copyWith(color: ColorList.primaryColor),
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
              style:
                  AppStyle.b8Medium.copyWith(color: ColorList.blackSecondColor),
            ),
            Expanded(
              child: Text(
                DateHelper.getDateFromDateTime(
                    prefHelper?.getLoginResponseModel().dob, 'MMM dd, yyyy'),
                style:
                    AppStyle.b8Bold.copyWith(color: ColorList.blackSecondColor),
                textAlign: TextAlign.end,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Divider(
            color: ColorList.greyDisableCircleColor, height: 1, thickness: 1),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Occupation',
              style:
                  AppStyle.b8Medium.copyWith(color: ColorList.blackSecondColor),
            ),
            Expanded(
              child: Text(
                prefHelper?.getLoginResponseModel().occupation ?? '',
                style:
                    AppStyle.b8Bold.copyWith(color: ColorList.blackSecondColor),
                textAlign: TextAlign.end,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Divider(
            color: ColorList.greyDisableCircleColor, height: 1, thickness: 1),
        const SizedBox(
          height: 15,
        ),
        Row(
          children: [
            Text(
              'Email',
              style:
                  AppStyle.b8Medium.copyWith(color: ColorList.blackSecondColor),
            ),
            Expanded(
              child: Text(
                prefHelper?.getLoginResponseModel().email ?? '',
                style:
                    AppStyle.b8Bold.copyWith(color: ColorList.greyLight2Color),
                textAlign: TextAlign.end,
              ),
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
            color: ColorList.greyDisableCircleColor, height: 1, thickness: 1),
        const SizedBox(
          height: 15,
        ),
        Row(
          children: [
            Text(
              'Phone',
              style:
                  AppStyle.b8Medium.copyWith(color: ColorList.blackSecondColor),
            ),
            Expanded(
              child: Text(
                prefHelper?.getLoginResponseModel().phone ?? '',
                style:
                    AppStyle.b8Bold.copyWith(color: ColorList.greyLight2Color),
                textAlign: TextAlign.end,
              ),
            ),
            const SizedBox(
              width: 9.5,
            ),
            Image.asset(imageSecurityShieldIcon),
          ],
        ),
      ],
    );
  }

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
                      'Kolobox.ng/@${prefHelper?.getLoginResponseModel().id}',
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
    profileStreamController.close();
  }
}
