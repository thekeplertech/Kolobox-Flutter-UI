import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kolobox_new_app/core/colors/color_list.dart';
import 'package:kolobox_new_app/core/constants/image_constants.dart';
import 'package:kolobox_new_app/core/ui/style/app_style.dart';

import '../../../../../core/base/base_bloc_widget.dart';
import '../../../../../core/ui/widgets/button.dart';
import '../../../../../core/ui/widgets/no_app_bar.dart';
import '../../../../../core/ui/widgets/no_overflow_scrollbar_behaviour.dart';
import '../../../../../core/utils/date_helper.dart';
import '../../../../widgets/home_app_bar_widget.dart';
import '../../../../widgets/next_ok_kin/edit_next_of_kin_page.dart';

class ProfileScreen extends BaseBlocWidget {
  const ProfileScreen({
    Key? key,
  }) : super(key: key);

  @override
  ProfileScreenState createState() => ProfileScreenState();
}

class ProfileScreenState extends BaseBlocWidgetState<ProfileScreen> {
  StreamController<bool> dataStreamController =
      StreamController<bool>.broadcast();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget getCustomBloc() {
    return Scaffold(
      backgroundColor: ColorList.white,
      appBar: const NoAppBar(),
      body: Column(
        children: [
          Expanded(
            child: ScrollConfiguration(
              behavior: NoOverFlowScrollbarBehaviour(),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const HomeAppBarWidget(
                        leftIcon: imageBackArrowIcon, title: 'Profile'),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 28, right: 28, top: 15, bottom: 28),
                      child: StreamBuilder<bool>(
                          stream: dataStreamController.stream,
                          builder: (context, snapshot) {
                            return getDataWidget();
                          }),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(top: 28, bottom: 50, left: 28, right: 28),
            child: Button(
              'Edit',
              backgroundColor: ColorList.lightBlue3Color,
              textColor: ColorList.primaryColor,
              overlayColor: ColorList.blueColor,
              borderRadius: 32,
              onPressed: () {
                showCustomBottomSheet(const EditNextOfKinPage()).then((value) {
                  dataStreamController.add(true);
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget getDataWidget() {
    return Column(
      children: [
        const SizedBox(
          height: 50,
        ),
        Image.asset(
          imageUserPlaceHolderNextOfKin,
        ),
        const SizedBox(
          height: 50,
        ),
        Row(
          children: [
            Text(
              'First Name',
              style:
                  AppStyle.b9Medium.copyWith(color: ColorList.blackSecondColor),
            ),
            Expanded(
              child: Text(
                prefHelper?.getLoginResponseModel().firstname ?? '',
                style:
                    AppStyle.b9Bold.copyWith(color: ColorList.blackSecondColor),
                textAlign: TextAlign.end,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        Divider(
            color: ColorList.greyDisableCircleColor, height: 1, thickness: 1),
        const SizedBox(
          height: 25,
        ),
        Row(
          children: [
            Text(
              'Last Name',
              style:
                  AppStyle.b9Medium.copyWith(color: ColorList.blackSecondColor),
            ),
            Expanded(
              child: Text(
                prefHelper?.getLoginResponseModel().lastname ?? '',
                style:
                    AppStyle.b9Bold.copyWith(color: ColorList.blackSecondColor),
                textAlign: TextAlign.end,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        Divider(
            color: ColorList.greyDisableCircleColor, height: 1, thickness: 1),
        const SizedBox(
          height: 25,
        ),
        Row(
          children: [
            Text(
              'Date Of Birth',
              style:
                  AppStyle.b9Medium.copyWith(color: ColorList.blackSecondColor),
            ),
            Expanded(
              child: Text(
                DateHelper.getDateFromDateTime(
                    prefHelper?.getLoginResponseModel().dob, 'MMM dd, yyyy'),
                style:
                    AppStyle.b9Bold.copyWith(color: ColorList.blackSecondColor),
                textAlign: TextAlign.end,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        Divider(
            color: ColorList.greyDisableCircleColor, height: 1, thickness: 1),
        const SizedBox(
          height: 25,
        ),
        Row(
          children: [
            Text(
              'Next of Kin',
              style:
                  AppStyle.b9Medium.copyWith(color: ColorList.blackSecondColor),
            ),
            Expanded(
              child: Text(
                prefHelper?.getLoginResponseModel().nextOfKin ?? '',
                style:
                    AppStyle.b9Bold.copyWith(color: ColorList.blackSecondColor),
                textAlign: TextAlign.end,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        Divider(
            color: ColorList.greyDisableCircleColor, height: 1, thickness: 1),
        const SizedBox(
          height: 25,
        ),
        Row(
          children: [
            Text(
              'Phone',
              style:
                  AppStyle.b9Medium.copyWith(color: ColorList.blackSecondColor),
            ),
            Expanded(
              child: Text(
                prefHelper?.getLoginResponseModel().phone ?? '',
                style:
                    AppStyle.b9Bold.copyWith(color: ColorList.blackSecondColor),
                textAlign: TextAlign.end,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        Divider(
            color: ColorList.greyDisableCircleColor, height: 1, thickness: 1),
        const SizedBox(
          height: 25,
        ),
        Row(
          children: [
            Text(
              'Occupation',
              style:
                  AppStyle.b9Medium.copyWith(color: ColorList.blackSecondColor),
            ),
            Expanded(
              child: Text(
                prefHelper?.getLoginResponseModel().occupation ?? '',
                style:
                    AppStyle.b9Bold.copyWith(color: ColorList.blackSecondColor),
                textAlign: TextAlign.end,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        Divider(
            color: ColorList.greyDisableCircleColor, height: 1, thickness: 1),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
    dataStreamController.close();
  }
}
