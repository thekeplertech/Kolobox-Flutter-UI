import 'package:flutter/material.dart';
import 'package:kolobox_new_app/core/colors/color_list.dart';
import 'package:kolobox_new_app/core/constants/image_constants.dart';
import 'package:kolobox_new_app/core/ui/style/app_style.dart';

import '../../../../../core/base/base_bloc_widget.dart';
import '../../../../core/ui/widgets/no_app_bar.dart';
import '../../../../core/ui/widgets/no_overflow_scrollbar_behaviour.dart';
import '../../../widgets/home_app_bar_widget.dart';

class NotificationsScreen extends BaseBlocWidget {
  const NotificationsScreen({
    Key? key,
  }) : super(key: key);

  @override
  NotificationsScreenState createState() => NotificationsScreenState();
}

class NotificationsScreenState
    extends BaseBlocWidgetState<NotificationsScreen> {
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
                  leftIcon: imageBackArrowIcon,
                  rightIcon: imageNotificationMenuIcon,
                  title: 'Notifications'),
              if (true) ...[
                const SizedBox(
                  height: 200,
                ),
                Center(
                  child: Column(
                    children: [
                      Image.asset(imageNoNotificationIcon),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        'You don’t have any notification yet',
                        style: AppStyle.b9Medium
                            .copyWith(color: ColorList.blackThirdColor),
                      ),
                    ],
                  ),
                ),
              ] else
                ...[],
              // if (false) ...[
              //   Padding(
              //     padding: const EdgeInsets.only(
              //         left: 28, right: 28, top: 15, bottom: 28),
              //     child: Column(
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       children: [
              //         Text(
              //           'Family Contributors',
              //           style: AppStyle.b4Bold
              //               .copyWith(color: ColorList.blackSecondColor),
              //         ),
              //         const SizedBox(
              //           height: 5,
              //         ),
              //         Text(
              //           'These are your investment partners',
              //           style: AppStyle.b9Regular
              //               .copyWith(color: ColorList.blackThirdColor),
              //         ),
              //         const SizedBox(
              //           height: 25,
              //         ),
              //         GridView.builder(
              //           gridDelegate:
              //               const SliverGridDelegateWithFixedCrossAxisCount(
              //             crossAxisCount: 2,
              //             crossAxisSpacing: 14,
              //             mainAxisSpacing: 14,
              //             childAspectRatio: 1.2,
              //           ),
              //           physics: const NeverScrollableScrollPhysics(),
              //           shrinkWrap: true,
              //           itemCount: 12,
              //           itemBuilder: (_, index) =>
              //               const FamilyContributorsWidget(),
              //         ),
              //       ],
              //     ),
              //   ),
              // ],
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
