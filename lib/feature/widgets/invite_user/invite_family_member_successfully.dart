import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kolobox_new_app/core/base/base_screen.dart';
import 'package:kolobox_new_app/core/constants/image_constants.dart';
import 'package:kolobox_new_app/core/ui/style/app_style.dart';

import '../../../core/colors/color_list.dart';
import '../../../core/ui/widgets/button.dart';
import '../../dashboard/presentation/bloc/dashboard_bloc.dart';
import '../../dashboard/presentation/bloc/dashboard_event.dart';
import '../inherited_state_container.dart';

class InviteFamilyMemberSuccessfullyWidget extends BaseScreen {
  const InviteFamilyMemberSuccessfullyWidget({Key? key}) : super(key: key);

  @override
  State<InviteFamilyMemberSuccessfullyWidget> createState() =>
      _InviteFamilyMemberSuccessfullyWidgetState();
}

class _InviteFamilyMemberSuccessfullyWidgetState
    extends BaseScreenState<InviteFamilyMemberSuccessfullyWidget> {
  @override
  Widget body(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 45, left: 28, right: 28, bottom: 31),
      child: Column(
        children: [
          Center(child: Image.asset(imageConfirm)),
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 35),
            child: Text(
              'Invitation Sent Successfully',
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
              'Your invitation has been sent',
              style:
                  AppStyle.b9Medium.copyWith(color: ColorList.blackThirdColor),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          Button(
            'Ok',
            backgroundColor: ColorList.primaryColor,
            textColor: ColorList.white,
            overlayColor: ColorList.blueColor,
            borderRadius: 32,
            onPressed: () {
              Future.delayed(const Duration(milliseconds: 300), () {
                StateContainer.of(context).isSuccessful = true;
                BlocProvider.of<DashboardBloc>(context).add(ClearBackStackEvent(
                  until: StateContainer.of(context).getPopUntil(),
                ));
              });
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
