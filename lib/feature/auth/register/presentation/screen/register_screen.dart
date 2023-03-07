import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kolobox_new_app/core/colors/color_list.dart';
import 'package:kolobox_new_app/core/constants/image_constants.dart';
import 'package:kolobox_new_app/core/ui/widgets/no_overflow_scrollbar_behaviour.dart';
import 'package:kolobox_new_app/core/ui/widgets/toast_widget.dart';
import 'package:kolobox_new_app/core/utils/utils.dart';
import 'package:kolobox_new_app/routes/routes.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../../../core/base/base_bloc_widget.dart';
import '../../../../../core/ui/widgets/button.dart';
import '../../../../../core/ui/widgets/custom_text_field.dart';

class RegisterScreen extends BaseBlocWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  RegisterScreenState createState() => RegisterScreenState();
}

class RegisterScreenState extends BaseBlocWidgetState<RegisterScreen> {
  StreamController<int> pageIndicatorStreamController =
      StreamController<int>.broadcast();
  StreamController<bool> termsAndConditionStreamController =
      StreamController<bool>.broadcast();

  bool isTermsAndCondition = false;

  int pageIndicatorPosition = 0;
  int pageIndicatorCount = 3;

  PageController pageController = PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();
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
        body: Column(
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
                  page = stepOneEnterDetails();
                } else if (index == 1) {
                  page = stepTwoEnterCode();
                } else if (index == 2) {
                  page = stepThreeSuccess();
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
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (pageIndicatorPosition == 0) ...[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              StreamBuilder<bool>(
                                  initialData: isTermsAndCondition,
                                  stream:
                                      termsAndConditionStreamController.stream,
                                  builder: (context, snapshot) => SizedBox(
                                        height: 24.0,
                                        width: 24.0,
                                        child: Checkbox(
                                          checkColor: ColorList.white,
                                          activeColor: ColorList.greyLightColor,
                                          fillColor: MaterialStateProperty.all(
                                              ColorList.primaryColor),
                                          value: isTermsAndCondition,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          side: MaterialStateBorderSide
                                              .resolveWith(
                                            (states) => BorderSide(
                                              width: 1.0,
                                              color:
                                                  ColorList.greyVeryLightColor,
                                            ),
                                          ),
                                          materialTapTargetSize:
                                              MaterialTapTargetSize.shrinkWrap,
                                          onChanged: (bool? value) {
                                            isTermsAndCondition =
                                                value ?? false;
                                            termsAndConditionStreamController
                                                .add(isTermsAndCondition);
                                          },
                                        ),
                                      )),
                              const SizedBox(
                                width: 7,
                              ),
                              RichText(
                                text: TextSpan(children: [
                                  TextSpan(
                                    text: 'I agree to the ',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: ColorList.blackThirdColor,
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'User Agreement',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: ColorList.primaryColor,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () => comingSoon(),
                                  ),
                                  TextSpan(
                                    text: ' & ',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: ColorList.blackThirdColor,
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'Privacy Policy',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: ColorList.primaryColor,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () => comingSoon(),
                                  ),
                                ]),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                        Button(
                          pageIndicatorPosition == 2
                              ? 'Start Investing'
                              : 'Next',
                          borderRadius: 32,
                          onPressed: () async {
                            if (pageIndicatorPosition ==
                                pageIndicatorCount - 1) {
                              navigateAndRemoveAll(
                                  context, Routes.dashboard, Routes.dashboard);
                              return;
                            }
                            if (pageIndicatorPosition == 0) {
                              Utils.showToast(
                                  context,
                                  ToastWidget(
                                    'Register successful',
                                    backgroundColor: ColorList.primaryColor,
                                    messageIcon: imageRightWhite,
                                    closeWidget: Image.asset(
                                      imageClose,
                                      color: ColorList.white,
                                    ),
                                  ));
                            }
                            await Future.delayed(
                                const Duration(milliseconds: 200));
                            pageController.animateToPage(
                              ++pageIndicatorPosition,
                              duration: const Duration(milliseconds: 200),
                              curve: Curves.easeIn,
                            );
                          },
                        ),
                      ],
                    );
                  }),
            ),
          ],
        ),
      );

  Widget stepOneEnterDetails() => ScrollConfiguration(
        behavior: NoOverFlowScrollbarBehaviour(),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Create your account',
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
                'First Name',
                style: TextStyle(
                  color: ColorList.blackSecondColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 7,
              ),
              const CustomTextField('Enter your first name'),
              const SizedBox(
                height: 24,
              ),
              Text(
                'Last Name',
                style: TextStyle(
                  color: ColorList.blackSecondColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 7,
              ),
              const CustomTextField('Enter your last name'),
              const SizedBox(
                height: 24,
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
              const CustomTextField('Enter your email address'),
              const SizedBox(
                height: 24,
              ),
              Text(
                'Phone Number',
                style: TextStyle(
                  color: ColorList.blackSecondColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 7,
              ),
              const CustomTextField('Enter phone number'),
              const SizedBox(
                height: 24,
              ),
              Text(
                'Date Of Birth',
                style: TextStyle(
                  color: ColorList.blackSecondColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 7,
              ),
              const CustomTextField('Select your date of birth'),
              const SizedBox(
                height: 24,
              ),
              Text(
                'Next of Kin',
                style: TextStyle(
                  color: ColorList.blackSecondColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 7,
              ),
              const CustomTextField('Enter your next of kin'),
              const SizedBox(
                height: 24,
              ),
              Text(
                'Occupation',
                style: TextStyle(
                  color: ColorList.blackSecondColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 7,
              ),
              const CustomTextField('Enter your occupation'),
              const SizedBox(
                height: 24,
              ),
              Text(
                'Referral',
                style: TextStyle(
                  color: ColorList.blackSecondColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 7,
              ),
              const CustomTextField('Enter referral code (Optional)'),
              const SizedBox(
                height: 24,
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
                height: 24,
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
          ),
        ),
      );

  Widget stepTwoEnterCode() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Verification',
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
          'We have sent a 6 digit OTP code to your email address and phone number. Kindly input to verify and proceed',
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
          onChanged: (value) {
            print("asd fa fds $value");
          },
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
    );
  }

  Widget stepThreeSuccess() {
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
              'Account Creation Successful',
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
            'You have successfully created your KoloBox account. Start investment journey',
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
    pageIndicatorStreamController.close();
    termsAndConditionStreamController.close();
  }
}
