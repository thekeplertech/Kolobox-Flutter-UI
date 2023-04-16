import 'package:flutter/material.dart';
import 'package:kolobox_new_app/core/colors/color_list.dart';
import 'package:kolobox_new_app/core/constants/image_constants.dart';
import 'package:kolobox_new_app/core/ui/style/app_style.dart';

import '../../../../../core/base/base_bloc_widget.dart';
import '../../../../../core/ui/widgets/button.dart';
import '../../../../../core/ui/widgets/no_app_bar.dart';
import '../../../../../core/ui/widgets/no_overflow_scrollbar_behaviour.dart';
import '../../../../widgets/home_app_bar_widget.dart';

class NextOfKinScreen extends BaseBlocWidget {
  const NextOfKinScreen({
    Key? key,
  }) : super(key: key);

  @override
  NextOfKinScreenState createState() => NextOfKinScreenState();
}

class NextOfKinScreenState extends BaseBlocWidgetState<NextOfKinScreen> {
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
                  leftIcon: imageBackArrowIcon, title: 'Next Of Kin'),
              Padding(
                padding: const EdgeInsets.only(
                    left: 28, right: 28, top: 15, bottom: 28),
                child: Center(child: getEmptyWidget()),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getEmptyWidget() {
    return Column(
      children: [
        const SizedBox(
          height: 150,
        ),
        Image.asset(
          imageUserPlaceHolder,
          width: 48,
          height: 48,
        ),
        const SizedBox(
          height: 15,
        ),
        Text(
          'You don’t have a next of kin',
          style: AppStyle.b9Medium.copyWith(color: ColorList.blackThirdColor),
        ),
        const SizedBox(
          height: 25,
        ),
        SizedBox(
          width: 150,
          child: Button(
            'Add',
            backgroundColor: ColorList.lightBlue3Color,
            textColor: ColorList.primaryColor,
            overlayColor: ColorList.blueColor,
            borderRadius: 24,
            verticalPadding: 10,
            onPressed: () => comingSoon(),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
