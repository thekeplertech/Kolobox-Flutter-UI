import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kolobox_new_app/config/flavor_config.dart';
import 'package:kolobox_new_app/core/colors/color_list.dart';
import 'package:kolobox_new_app/core/constants/image_constants.dart';
import 'package:kolobox_new_app/core/ui/widgets/no_overflow_scrollbar_behaviour.dart';
import 'package:kolobox_new_app/feature/auth/forget_password/presentation/bloc/forgot_password_bloc.dart';
import 'package:kolobox_new_app/feature/auth/forget_password/presentation/bloc/forgot_password_state.dart';
import 'package:kolobox_new_app/routes/routes.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../../../core/base/base_bloc_widget.dart';
import '../../../../../core/ui/style/app_style.dart';
import '../../../../../core/ui/widgets/button.dart';
import '../../../../../core/ui/widgets/custom_text_field.dart';
import '../../../../../core/ui/widgets/toast_widget.dart';
import '../../../../../core/utils/utils.dart';
import '../../data/models/change_password_request_model.dart';
import '../../data/models/forget_password_request_model.dart';
import '../../data/models/validate_request_model.dart';
import '../bloc/forgot_password_event.dart';

class ForgotPasswordScreen extends BaseBlocWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  ForgotPasswordScreenState createState() => ForgotPasswordScreenState();
}

class ForgotPasswordScreenState
    extends BaseBlocWidgetState<ForgotPasswordScreen> {
  final TextEditingController emailTextEditingController =
      TextEditingController();
  final TextEditingController otpTextEditingController =
      TextEditingController();

  final TextEditingController passwordTextEditingController =
      TextEditingController();
  final TextEditingController cPasswordTextEditingController =
      TextEditingController();

  StreamController<int> pageIndicatorStreamController =
      StreamController<int>.broadcast();

  StreamController<int> passwordStrengthStreamController =
      StreamController<int>.broadcast();

  int pageIndicatorPosition = 0;
  int pageIndicatorCount = 4;

  static const int maxPasswordStrength = 4;
  int passwordStrength = 0;

  StreamController<int> resendStreamController =
      StreamController<int>.broadcast();

  Timer? _timer;
  int _timeLeft = 0;

  PageController pageController = PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();
    if (FlavorConfig.isDev()) {
      emailTextEditingController.text = 'parth123456789@mailinator.com';
      // emailTextEditingController.text = 'tulbadex@gmail.com';
    }
  }

  startResendTimer() {
    _timeLeft = 30;
    resendStreamController.add(_timeLeft);
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timeLeft > 0) {
        _timeLeft--;
      } else {
        _timer?.cancel();
      }
      resendStreamController.add(_timeLeft);
    });
  }

  stopResendTimer() {
    _timer?.cancel();
    _timeLeft = 0;
    resendStreamController.add(_timeLeft);
  }

  @override
  Widget getCustomBloc() => Scaffold(
        backgroundColor: ColorList.white,
        appBar: AppBar(
          backgroundColor: ColorList.transparentColor,
          bottomOpacity: 0,
          elevation: 0,
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: ColorList.white,
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.light,
          ),
        ),
        body: BlocListener<ForgotPasswordBloc, ForgotPasswordState>(
          listener: (_, state) {
            if (state is CallForgotPasswordState) {
              Future.delayed(const Duration(milliseconds: 200)).then((value) {
                Utils.showToast(
                    context,
                    ToastWidget(
                      state.model.message ?? '',
                      closeWidget: Image.asset(
                        imageClose,
                        color: ColorList.white,
                      ),
                    ));

                pageIndicatorPosition = 1;
                pageController.animateToPage(
                  pageIndicatorPosition,
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeIn,
                );
                startResendTimer();
              });
            }
            if (state is ForgotPasswordValidateState) {
              Future.delayed(const Duration(milliseconds: 200)).then((value) {
                pageController.animateToPage(
                  ++pageIndicatorPosition,
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeIn,
                );
              });
            }
            if (state is ChangePasswordState) {
              Future.delayed(const Duration(milliseconds: 200)).then((value) {
                pageController.animateToPage(
                  ++pageIndicatorPosition,
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeIn,
                );
              });
            }
          },
          child: getChildWidget(),
        ),
      );

  Widget getChildWidget() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          StreamBuilder<int>(
              initialData: pageIndicatorPosition,
              stream: pageIndicatorStreamController.stream,
              builder: (context, snapshot) {
                return (pageIndicatorPosition != pageIndicatorCount - 1)
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: _buildPageIndicator(),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 28,
                              right: 28,
                            ),
                            child: GestureDetector(
                              onTap: () => goBack(context),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  top: 10,
                                  bottom: 10,
                                  right: 10,
                                ),
                                child: Image.asset(imageClose),
                              ),
                            ),
                          ),
                        ],
                      )
                    : const SizedBox();
              }),
          const SizedBox(
            height: 15,
          ),
          Expanded(
              child: PageView.builder(
            physics: const NeverScrollableScrollPhysics(),
            controller: pageController,
            onPageChanged: (int page) {
              pageIndicatorPosition = page;
              pageIndicatorStreamController.add(pageIndicatorPosition);
            },
            itemCount: pageIndicatorCount,
            itemBuilder: (_, index) {
              Widget? page;
              if (index == 0) {
                page = stepOneEnterEmail();
              } else if (index == 1) {
                page = stepTwoEnterCode();
              } else if (index == 2) {
                page = stepThreeEnterPassword();
              } else if (index == 3) {
                page = stepFourSuccess();
              }

              if (page != null) {
                return Padding(
                  padding: const EdgeInsets.only(
                    left: 28,
                    right: 28,
                  ),
                  child: page,
                );
              } else {
                return const SizedBox();
              }
            },
          )),
          Padding(
            padding: const EdgeInsets.only(
              left: 28,
              right: 28,
              top: 20,
              bottom: 31,
            ),
            child: StreamBuilder<int>(
                initialData: pageIndicatorPosition,
                stream: pageIndicatorStreamController.stream,
                builder: (_, __) {
                  String text = 'Next';
                  switch (pageIndicatorPosition) {
                    case 2:
                      text = 'Create Password';
                      break;
                    case 3:
                      text = 'Sign In';
                      break;
                  }
                  return Button(
                    text,
                    borderRadius: 32,
                    onPressed: () async {
                      switch (pageIndicatorPosition) {
                        case 0:
                          onClickNext();
                          break;
                        case 1:
                          onClickValidateCode();
                          break;
                        case 2:
                          onClickCreatePassword();
                          break;
                        case 3:
                          goBack(context);
                          break;
                      }
                      return;
                    },
                  );
                }),
          ),
        ],
      );

  Widget stepOneEnterEmail() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Password reset',
            style: TextStyle(
              color: ColorList.blackSecondColor,
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            'Email',
            style: TextStyle(
              color: ColorList.blackSecondColor,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(
            height: 7,
          ),
          CustomTextField(
            'Enter email address',
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            controller: emailTextEditingController,
          ),
        ],
      );

  onClickNext() {
    hideKeyboard();
    if (emailTextEditingController.text.isEmpty) {
      Utils.showToast(
          context,
          ToastWidget(
            'Enter email address',
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
    if (!Utils.emailValid(emailTextEditingController.text)) {
      Utils.showToast(
          context,
          ToastWidget(
            'Enter valid email address',
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

    BlocProvider.of<ForgotPasswordBloc>(context).add(CallForgotPasswordEvent(
      model: ForgetPasswordRequestModel(
          emailPhone: emailTextEditingController.text),
    ));
  }

  Widget stepTwoEnterCode() {
    return ScrollConfiguration(
      behavior: NoOverFlowScrollbarBehaviour(),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Password reset code',
              style: TextStyle(
                color: ColorList.blackSecondColor,
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'We have sent a 4 digit OTP code to your email address. Kindly input to reset your password',
              style: TextStyle(
                color: ColorList.blackThirdColor,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            PinCodeTextField(
              appContext: context,
              controller: otpTextEditingController,
              length: 4,
              pinTheme: PinTheme(
                shape: PinCodeFieldShape.box,
                borderRadius: BorderRadius.circular(12),
                fieldHeight: 45,
                fieldWidth: 45,
                borderWidth: 1,
                inactiveColor: ColorList.greyLightColor,
                activeColor: ColorList.greyLightColor,
                selectedColor: ColorList.greyLightColor,
              ),
              textStyle: TextStyle(
                color: ColorList.blackThirdColor,
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              onChanged: (value) {},
            ),
            const SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    comingSoon();
                  },
                  child: Text(
                    'Didn’t recieve OTP?',
                    style: TextStyle(
                      color: ColorList.blackThirdColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                StreamBuilder<int>(
                    stream: resendStreamController.stream,
                    builder: (context, snapshot) {
                      logger?.d("Resend timer $_timeLeft");
                      return (_timeLeft == 0)
                          ? GestureDetector(
                              onTap: () => onClickNext(),
                              child: Text(
                                'Resend',
                                style: AppStyle.b8Bold
                                    .copyWith(color: ColorList.primaryColor),
                              ),
                            )
                          : Text(
                              'Resend in ${getFormattedTime()} Sec',
                              style: AppStyle.b9Medium
                                  .copyWith(color: ColorList.blackThirdColor),
                            );
                    }),
              ],
            ),
          ],
        ),
      ),
    );
  }

  onClickValidateCode() {
    hideKeyboard();
    if (otpTextEditingController.text.isEmpty) {
      Utils.showToast(
          context,
          ToastWidget(
            'Enter otp',
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
    if (otpTextEditingController.text.length != 4) {
      Utils.showToast(
          context,
          ToastWidget(
            'Enter valid otp',
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

    BlocProvider.of<ForgotPasswordBloc>(context)
        .add(ForgotPasswordValidateEvent(
      model: ValidateRequestModel(
        code: otpTextEditingController.text,
      ),
    ));
  }

  Widget stepThreeEnterPassword() {
    return ScrollConfiguration(
      behavior: NoOverFlowScrollbarBehaviour(),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Password setup',
              style: TextStyle(
                color: ColorList.blackSecondColor,
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Password',
              style:
                  AppStyle.b9Medium.copyWith(color: ColorList.blackSecondColor),
            ),
            const SizedBox(
              height: 7,
            ),
            CustomTextField(
              'Create secure password',
              controller: passwordTextEditingController,
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
              style:
                  AppStyle.b9Medium.copyWith(color: ColorList.blackSecondColor),
            ),
            const SizedBox(
              height: 7,
            ),
            CustomTextField(
              'Confirm created password',
              controller: cPasswordTextEditingController,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.done,
              obscureText: true,
              onChanged: (value) => changePasswordUpdated(),
            ),
            const SizedBox(
              height: 20,
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
            const SizedBox(
              height: 9,
            ),
            Text(
              'Password strength',
              style: TextStyle(
                color: ColorList.greyDarkColor,
                fontSize: 10,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  onClickCreatePassword() {
    hideKeyboard();
    if (passwordTextEditingController.text.isEmpty) {
      Utils.showToast(
          context,
          ToastWidget(
            'Enter password',
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
    if (cPasswordTextEditingController.text.isEmpty) {
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
    if (passwordTextEditingController.text !=
        cPasswordTextEditingController.text) {
      Utils.showToast(
          context,
          ToastWidget(
            'Password & confirm password must be same.',
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

    BlocProvider.of<ForgotPasswordBloc>(context).add(ChangePasswordEvent(
      model: ChangePasswordRequestModel(
        newPassword: passwordTextEditingController.text,
        newCPassword: passwordTextEditingController.text,
      ),
    ));
  }

  void changePasswordUpdated() {
    passwordStrength = 0;

    if (passwordTextEditingController.text.isEmpty) {
      passwordStrength = 0;
    } else if (passwordTextEditingController.text.length < 6) {
      passwordStrength = 1;
    } else if (passwordTextEditingController.text.length < 8) {
      passwordStrength = 2;
    } else {
      if (!Utils.isLetter(passwordTextEditingController.text) ||
          !Utils.isNumber(passwordTextEditingController.text)) {
        passwordStrength = 3;
      } else {
        passwordStrength = 4;
      }
    }
    passwordStrengthStreamController.add(passwordStrength);
  }

  Widget stepFourSuccess() {
    return Padding(
      padding: const EdgeInsets.only(left: 22, right: 22),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(imageConfirm),
          const SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Text(
              'Password Reset Successful',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: ColorList.blackSecondColor,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            'You have successfully reset your password. Proceed to Sign In',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: ColorList.blackThirdColor,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < pageIndicatorCount; i++) {
      list.add(
          i == pageIndicatorPosition ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) => AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        margin: const EdgeInsets.symmetric(horizontal: 8),
        height: 8,
        width: isActive ? 45 : 21,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: isActive ? ColorList.primaryColor : ColorList.greyShadowColor,
          borderRadius: const BorderRadius.all(Radius.circular(12)),
        ),
      );

  String getFormattedTime() {
    String seconds = _timeLeft.toString().padLeft(2, '0');
    return '00:$seconds';
  }

  @override
  void dispose() {
    stopResendTimer();
    emailTextEditingController.dispose();
    otpTextEditingController.dispose();
    passwordTextEditingController.dispose();
    cPasswordTextEditingController.dispose();
    super.dispose();
    pageController.dispose();
    resendStreamController.close();
    pageIndicatorStreamController.close();
  }
}
