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
import '../../../../../core/ui/widgets/button.dart';
import '../../../../../core/ui/widgets/custom_text_field.dart';
import '../../../../../core/ui/widgets/toast_widget.dart';
import '../../../../../core/utils/utils.dart';
import '../../data/models/forget_password_request_model.dart';
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

  StreamController<int> pageIndicatorStreamController =
      StreamController<int>.broadcast();

  int pageIndicatorPosition = 0;
  int pageIndicatorCount = 4;

  PageController pageController = PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();
    if (FlavorConfig.isDev()) {
      emailTextEditingController.text = 'tulbadex@gmail.com';
    }
  }

  @override
  Widget getCustomBloc() => Scaffold(
        backgroundColor: ColorList.white,
        appBar: AppBar(
          backgroundColor: ColorList.transparentColor,
          bottomOpacity: 0,
          elevation: 0,
          systemOverlayStyle: SystemUiOverlayStyle(
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

                pageController.animateToPage(
                  ++pageIndicatorPosition,
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeIn,
                );
              });
            }
            if (state is ForgotPasswordValidateState) {}
            if (state is ChangePasswordState) {}
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
                          break;
                        case 2:
                          break;
                        case 3:
                          break;
                      }
                      return;
                      if (pageIndicatorPosition == pageIndicatorCount - 1) {
                        goBack(context);
                        return;
                      }
                      await Future.delayed(const Duration(milliseconds: 200));
                      pageController.animateToPage(
                        ++pageIndicatorPosition,
                        duration: const Duration(milliseconds: 200),
                        curve: Curves.easeIn,
                      );
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
              'We have sent a 6 digit OTP code to your email address. Kindly input to reset your password',
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
              length: 6,
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
                Text(
                  'Resend in 0:30 Sec',
                  style: TextStyle(
                    color: ColorList.blackThirdColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget stepThreeEnterPassword() {
    return Column(
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
          style: TextStyle(
            color: ColorList.blackSecondColor,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(
          height: 7,
        ),
        const CustomTextField('Create secure password'),
        const SizedBox(
          height: 24,
        ),
        Text(
          'Confirm password',
          style: TextStyle(
            color: ColorList.blackSecondColor,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(
          height: 7,
        ),
        const CustomTextField('Confirm created password'),
        const SizedBox(
          height: 20,
        ),
        Stack(
          children: [
            Container(
              width: double.maxFinite,
              height: 8,
              decoration: BoxDecoration(
                color: ColorList.greyVeryLightColor,
                borderRadius: BorderRadius.circular(100),
              ),
            ),
            Container(
              width: 100,
              height: 8,
              decoration: BoxDecoration(
                color: ColorList.yellowDarkColor,
                borderRadius: BorderRadius.circular(100),
              ),
            ),
          ],
        ),
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
    );
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

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
    emailTextEditingController.dispose();
    pageIndicatorStreamController.close();
  }
}
