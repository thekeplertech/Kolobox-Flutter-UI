import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kolobox_new_app/core/base/base_screen.dart';
import 'package:kolobox_new_app/core/constants/image_constants.dart';
import 'package:kolobox_new_app/core/ui/extension.dart';
import 'package:kolobox_new_app/core/ui/style/app_style.dart';

import '../../../core/colors/color_list.dart';
import '../../../core/ui/widgets/button.dart';
import '../../dashboard/presentation/bloc/dashboard_bloc.dart';
import '../../dashboard/presentation/bloc/dashboard_event.dart';
import '../inherited_state_container.dart';

class CancelInvestmentSuccessfullyWidget extends BaseScreen {
  const CancelInvestmentSuccessfullyWidget({Key? key}) : super(key: key);

  @override
  State<CancelInvestmentSuccessfullyWidget> createState() =>
      _CancelInvestmentSuccessfullyWidgetState();
}

class _CancelInvestmentSuccessfullyWidgetState
    extends BaseScreenState<CancelInvestmentSuccessfullyWidget> {
  @override
  Widget body(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 45, left: 28, right: 28, bottom: 31),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(child: Image.asset(imageConfirm)),
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 35),
            child: Text(
              'Investment cancellation request sent successfully',
              style:
                  AppStyle.b5Bold.copyWith(color: ColorList.blackSecondColor),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 55),
            child: Text(
              'We have received your request and would be attended to soonest',
              style:
                  AppStyle.b9Medium.copyWith(color: ColorList.blackThirdColor),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          Button(
            'Next',
            backgroundColor: ColorList.primaryColor,
            textColor: ColorList.white,
            overlayColor: ColorList.blueColor,
            borderRadius: 32,
            onPressed: () {
              BlocProvider.of<DashboardBloc>(context).add(
                ClearBackStackEvent(
                  until: StateContainer.of(context).isFromFundMyKoloBox
                      ? '/'
                      : StateContainer.of(context)
                          .koloboxFundEnum
                          .getFundPageValue,
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
