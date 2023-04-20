import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kolobox_new_app/core/colors/color_list.dart';
import 'package:kolobox_new_app/core/constants/image_constants.dart';
import 'package:kolobox_new_app/core/constants/kolo_box_icon.dart';
import 'package:kolobox_new_app/core/ui/style/app_style.dart';
import 'package:kolobox_new_app/feature/auth/login/presentation/bloc/login_bloc.dart';
import 'package:kolobox_new_app/feature/widgets/confirm_pin_and_pay/confirm_pin_and_pay_page.dart';

import '../../../../../core/base/base_bloc_widget.dart';
import '../../../../../core/ui/widgets/no_app_bar.dart';
import '../../../../../core/ui/widgets/no_overflow_scrollbar_behaviour.dart';
import '../../../../../core/ui/widgets/toast_widget.dart';
import '../../../../../core/utils/utils.dart';
import '../../../../auth/login/data/models/create_pin_request_model.dart';
import '../../../../auth/login/presentation/bloc/login_event.dart';
import '../../../../auth/login/presentation/bloc/login_state.dart';
import '../../../../dashboard/presentation/bloc/dashboard_bloc.dart';
import '../../../../dashboard/presentation/bloc/dashboard_event.dart';
import '../../../../widgets/create_pin_widget.dart';
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
      body: BlocListener<LoginBloc, LoginState>(
        listener: (_, state) {
          if (state is CallLoginState) {
            logger?.d("updated");
          }
        },
        child: getChild(),
      ),
    );
  }

  ScrollConfiguration getChild() {
    return ScrollConfiguration(
      behavior: NoOverFlowScrollbarBehaviour(),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const HomeAppBarWidget(
                leftIcon: imageBackArrowIcon, title: 'Security'),
            Padding(
              padding: const EdgeInsets.only(
                  left: 28, right: 28, top: 5, bottom: 28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      onClickUpdateTransactionPin();
                    },
                    child: AbsorbPointer(
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Update Transaction PIN',
                              style: AppStyle.b8Medium
                                  .copyWith(color: ColorList.blackSecondColor),
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
                              style: AppStyle.b8Medium
                                  .copyWith(color: ColorList.blackSecondColor),
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
    );
  }

  onClickUpdateTransactionPin() {
    BlocProvider.of<DashboardBloc>(context).add(HideDisableBottomScreenEvent());
    showCustomBottomSheet(ConfirmPinAndPayPage(
      onSuccess: () {
        logger?.d("verification success");
        showDialogForCreatePin();
      },
    )).then((value) {
      BlocProvider.of<DashboardBloc>(context)
          .add(ShowEnableBottomScreenEvent());
    });
  }

  void showDialogForCreatePin() {
    showCustomBottomSheet(CreatePinWidget(
      onBack: (value1) {
        Future.delayed(const Duration(milliseconds: 200), () {
          showCustomBottomSheet(CreatePinWidget(
            isConfirmPin: true,
            onBack: (value2) {
              Future.delayed(const Duration(milliseconds: 200), () {
                if (value1 == value2) {
                  BlocProvider.of<LoginBloc>(context).add(CallCreatePinEvent(
                    loginResponseModel: prefHelper!.getLoginResponseModel(),
                    createPinRequestModel: CreatePinRequestModel(pin: value2),
                  ));
                } else {
                  Utils.showToast(
                      context,
                      ToastWidget(
                        'Create PIN and confirm PIN does not match.',
                        borderColor: ColorList.redDarkColor,
                        backgroundColor: ColorList.white,
                        textColor: ColorList.black,
                        messageIcon: imageCloseRed,
                        closeWidget: Image.asset(
                          imageClose,
                          color: ColorList.black,
                        ),
                      ));
                  showDialogForCreatePin();
                }
              });
            },
          ));
        });
      },
    ));
  }

  @override
  void dispose() {
    super.dispose();
  }
}
