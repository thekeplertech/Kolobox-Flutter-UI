import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kolobox_new_app/core/colors/color_list.dart';
import 'package:kolobox_new_app/core/constants/image_constants.dart';
import 'package:kolobox_new_app/feature/auth/login/presentation/bloc/login_bloc.dart';
import 'package:kolobox_new_app/feature/auth/login/presentation/bloc/login_event.dart';
import 'package:kolobox_new_app/feature/dashboard/data/models/update_password_request_model.dart';
import 'package:kolobox_new_app/routes/routes.dart';

import '../../../../../core/base/base_bloc_widget.dart';
import '../../../../../core/ui/style/app_style.dart';
import '../../../../../core/ui/widgets/button.dart';
import '../../../../../core/ui/widgets/custom_text_field.dart';
import '../../../../../core/ui/widgets/no_app_bar.dart';
import '../../../../../core/ui/widgets/no_overflow_scrollbar_behaviour.dart';
import '../../../../../core/ui/widgets/toast_widget.dart';
import '../../../../../core/utils/utils.dart';
import '../../../../auth/login/presentation/bloc/login_state.dart';
import '../../../../widgets/home_app_bar_widget.dart';

class UpdatePasswordScreen extends BaseBlocWidget {
  const UpdatePasswordScreen({
    Key? key,
  }) : super(key: key);

  @override
  UpdatePasswordScreenState createState() => UpdatePasswordScreenState();
}

class UpdatePasswordScreenState
    extends BaseBlocWidgetState<UpdatePasswordScreen> {
  final TextEditingController currentPasswordTextEditingController =
      TextEditingController();
  final TextEditingController newPasswordTextEditingController =
      TextEditingController();
  final TextEditingController confirmPasswordTextEditingController =
      TextEditingController();

  StreamController<int> passwordStrengthStreamController =
      StreamController<int>.broadcast();

  static const int maxPasswordStrength = 4;
  int passwordStrength = 0;

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
          if (state is UpdatePasswordState) {
            logger?.d("updated");
            Utils.showToast(
                context,
                ToastWidget(
                  state.message,
                  closeWidget: Image.asset(
                    imageClose,
                    color: ColorList.white,
                  ),
                ),
                isTab: true);
            Future.delayed(const Duration(milliseconds: 300)).then((value) {
              goBack(context);
            });
          }
        },
        child: getChild(),
      ),
    );
  }

  Widget getChild() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const HomeAppBarWidget(
            leftIcon: imageBackArrowIcon, title: 'Update Password'),
        Expanded(
          child: Padding(
            padding:
                const EdgeInsets.only(left: 28, right: 28, top: 30, bottom: 28),
            child: ScrollConfiguration(
              behavior: NoOverFlowScrollbarBehaviour(),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Current Password',
                      style: AppStyle.b9Medium
                          .copyWith(color: ColorList.blackSecondColor),
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    CustomTextField(
                      'Enter your current password',
                      controller: currentPasswordTextEditingController,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      obscureText: true,
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Text(
                      'New password',
                      style: AppStyle.b9Medium
                          .copyWith(color: ColorList.blackSecondColor),
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    CustomTextField(
                      'Create new password',
                      controller: newPasswordTextEditingController,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      obscureText: true,
                      onChanged: (value) => changePasswordUpdated(),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Text(
                      'Confirm password',
                      style: AppStyle.b9Medium
                          .copyWith(color: ColorList.blackSecondColor),
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    CustomTextField(
                      'Confirm new password',
                      controller: confirmPasswordTextEditingController,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.done,
                      obscureText: true,
                      onChanged: (value) => changePasswordUpdated(),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    LayoutBuilder(builder: (_, constraint) {
                      return Stack(
                        children: [
                          Container(
                            width: double.maxFinite,
                            height: 8,
                            decoration: BoxDecoration(
                              color: ColorList.greyVeryLightColor,
                              borderRadius: BorderRadius.circular(100),
                            ),
                          ),
                          StreamBuilder<int>(
                              initialData: passwordStrength,
                              stream: passwordStrengthStreamController.stream,
                              builder: (context, snapshot) {
                                return Container(
                                  width: constraint.maxWidth *
                                      passwordStrength /
                                      maxPasswordStrength,
                                  height: 8,
                                  decoration: BoxDecoration(
                                    color: ColorList.yellowDarkColor,
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                );
                              }),
                        ],
                      );
                    }),
                  ],
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding:
              const EdgeInsets.only(left: 28, right: 28, top: 10, bottom: 28),
          child: Button(
            'Update Password',
            borderRadius: 32,
            onPressed: () {
              onClickUpdatePassword();
            },
          ),
        ),
      ],
    );
  }

  onClickUpdatePassword() {
    hideKeyboard();
    if (currentPasswordTextEditingController.text.isEmpty) {
      Utils.showToast(
          context,
          ToastWidget(
            'Enter current password',
            borderColor: ColorList.redDarkColor,
            backgroundColor: ColorList.white,
            textColor: ColorList.black,
            messageIcon: imageCloseRed,
            closeWidget: Image.asset(
              imageClose,
              color: ColorList.black,
            ),
          ));
      return;
    }

    if (newPasswordTextEditingController.text.isEmpty) {
      Utils.showToast(
          context,
          ToastWidget(
            'Enter new password',
            borderColor: ColorList.redDarkColor,
            backgroundColor: ColorList.white,
            textColor: ColorList.black,
            messageIcon: imageCloseRed,
            closeWidget: Image.asset(
              imageClose,
              color: ColorList.black,
            ),
          ));
      return;
    }
    if (confirmPasswordTextEditingController.text.isEmpty) {
      Utils.showToast(
          context,
          ToastWidget(
            'Enter confirm password',
            borderColor: ColorList.redDarkColor,
            backgroundColor: ColorList.white,
            textColor: ColorList.black,
            messageIcon: imageCloseRed,
            closeWidget: Image.asset(
              imageClose,
              color: ColorList.black,
            ),
          ));
      return;
    }
    if (newPasswordTextEditingController.text !=
        confirmPasswordTextEditingController.text) {
      Utils.showToast(
          context,
          ToastWidget(
            'New password & confirm new password must be same.',
            borderColor: ColorList.redDarkColor,
            backgroundColor: ColorList.white,
            textColor: ColorList.black,
            messageIcon: imageCloseRed,
            closeWidget: Image.asset(
              imageClose,
              color: ColorList.black,
            ),
          ));
      return;
    }
    BlocProvider.of<LoginBloc>(context).add(UpdatePasswordEvent(
        model: UpdatePasswordRequestModel(
      oldPassword: currentPasswordTextEditingController.text,
      newPassword: newPasswordTextEditingController.text,
      newCPassword: confirmPasswordTextEditingController.text,
    )));
  }

  void changePasswordUpdated() {
    passwordStrength = 0;

    if (newPasswordTextEditingController.text.isEmpty) {
      passwordStrength = 0;
    } else if (newPasswordTextEditingController.text.length < 6) {
      passwordStrength = 1;
    } else if (newPasswordTextEditingController.text.length < 8) {
      passwordStrength = 2;
    } else {
      if (!Utils.isLetter(newPasswordTextEditingController.text) ||
          !Utils.isNumber(newPasswordTextEditingController.text)) {
        passwordStrength = 3;
      } else {
        passwordStrength = 4;
      }
    }
    passwordStrengthStreamController.add(passwordStrength);
  }

  @override
  void dispose() {
    super.dispose();
    currentPasswordTextEditingController.dispose();
    newPasswordTextEditingController.dispose();
    confirmPasswordTextEditingController.dispose();
    passwordStrengthStreamController.close();
  }
}
