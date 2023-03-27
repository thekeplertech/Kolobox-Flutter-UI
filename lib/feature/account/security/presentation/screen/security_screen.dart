import 'package:flutter/material.dart';
import 'package:kolobox_new_app/core/colors/color_list.dart';
import 'package:kolobox_new_app/core/constants/image_constants.dart';
import 'package:kolobox_new_app/core/constants/kolo_box_icon.dart';
import 'package:kolobox_new_app/core/ui/style/app_style.dart';

import '../../../../../core/base/base_bloc_widget.dart';
import '../../../../../core/ui/widgets/no_app_bar.dart';
import '../../../../../core/ui/widgets/no_overflow_scrollbar_behaviour.dart';
import '../../../../widgets/home_app_bar_widget.dart';

class SecurityScreen extends BaseBlocWidget {
  const SecurityScreen({
    Key? key,
  }) : super(key: key);

  @override
  SecurityState createState() => SecurityState();
}

class SecurityState extends BaseBlocWidgetState<SecurityScreen> {
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
                  leftIcon: imageBackArrowIcon, title: 'History'),
              Padding(
                padding: const EdgeInsets.only(
                    left: 28, right: 28, top: 5, bottom: 28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {},
                      child: AbsorbPointer(
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Update Transaction PIN',
                                style: AppStyle.b8Medium.copyWith(
                                    color: ColorList.blackSecondColor),
                              ),
                              Icon(
                                KoloBoxIcons.forwardArrow,
                                size: 12,
                                color: ColorList.greyLight2Color,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Divider(
                        color: ColorList.greyDisableCircleColor,
                        height: 10,
                        thickness: 1),
                    InkWell(
                      onTap: () {},
                      child: AbsorbPointer(
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Update Password',
                                style: AppStyle.b8Medium.copyWith(
                                    color: ColorList.blackSecondColor),
                              ),
                              Icon(
                                KoloBoxIcons.forwardArrow,
                                size: 12,
                                color: ColorList.greyLight2Color,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Divider(
                        color: ColorList.greyDisableCircleColor,
                        height: 10,
                        thickness: 1),
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
