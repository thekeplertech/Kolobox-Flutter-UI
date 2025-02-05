import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kolobox_new_app/core/colors/color_list.dart';
import 'package:kolobox_new_app/core/constants/image_constants.dart';
import 'package:kolobox_new_app/core/ui/style/app_style.dart';
import 'package:kolobox_new_app/core/ui/widgets/no_overflow_scrollbar_behaviour.dart';
import 'package:kolobox_new_app/core/ui/widgets/toast_widget.dart';
import 'package:kolobox_new_app/core/utils/date_helper.dart';
import 'package:kolobox_new_app/core/utils/utils.dart';
import 'package:kolobox_new_app/feature/auth/register/data/models/verify_user_request_model.dart';
import 'package:kolobox_new_app/feature/auth/register/presentation/bloc/register_bloc.dart';
import 'package:kolobox_new_app/routes/routes.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../config/flavor_config.dart';
import '../../../../../core/base/base_bloc_widget.dart';
import '../../../../../core/ui/widgets/button.dart';
import '../../../../../core/ui/widgets/custom_text_field.dart';
import '../../data/models/register_request_model.dart';
import '../bloc/register_event.dart';
import '../bloc/register_state.dart';

class RegisterScreen extends BaseBlocWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  RegisterScreenState createState() => RegisterScreenState();
}

class RegisterScreenState extends BaseBlocWidgetState<RegisterScreen> {
  final TextEditingController firstNameTextEditingController =
      TextEditingController();
  final TextEditingController lastNameTextEditingController =
      TextEditingController();
  final TextEditingController emailAddressTextEditingController =
      TextEditingController();
  final TextEditingController phoneNumberTextEditingController =
      TextEditingController();
  final TextEditingController nextOfKinTextEditingController =
      TextEditingController();
  final TextEditingController occupationTextEditingController =
      TextEditingController();
  final TextEditingController passwordTextEditingController =
      TextEditingController();
  final TextEditingController cPasswordTextEditingController =
      TextEditingController();

  final TextEditingController otpTextEditingController =
      TextEditingController();

  StreamController<int> pageIndicatorStreamController =
      StreamController<int>.broadcast();
  StreamController<bool> termsAndConditionStreamController =
      StreamController<bool>.broadcast();

  StreamController<int> passwordStrengthStreamController =
      StreamController<int>.broadcast();
  StreamController<bool> dateOfBirthStreamController =
      StreamController<bool>.broadcast();

  DateTime? dateOfBirth;

  bool isTermsAndCondition = true;

  int pageIndicatorPosition = 0;
  int pageIndicatorCount = 3;

  static const int maxPasswordStrength = 4;
  int passwordStrength = 0;

  PageController pageController = PageController(initialPage: 0);
  StreamController<bool> passwordStreamController =
      StreamController<bool>.broadcast();
  StreamController<bool> confirmPasswordStreamController =
      StreamController<bool>.broadcast();

  bool isPasswordObscure = true;
  bool isConfirmPasswordObscure = true;

  @override
  void initState() {
    super.initState();
    if (FlavorConfig.isDev() && kDebugMode) {
      firstNameTextEditingController.text = 'Parth';
      lastNameTextEditingController.text = 'Suthar';
      emailAddressTextEditingController.text =
          'parth12345678912345678901234@mailinator.com';
      phoneNumberTextEditingController.text = '95586963451';
      nextOfKinTextEditingController.text = 'First Next of kin';
      occupationTextEditingController.text = 'First Occupation';
      passwordTextEditingController.text = 'kolobox@123';
      cPasswordTextEditingController.text = 'kolobox@123';
    }
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
        body: BlocListener<RegisterBloc, RegisterState>(
          listener: (_, state) {
            if (state is CallRegisterState) {
              Future.delayed(const Duration(milliseconds: 300)).then((value) {
                Utils.showToast(
                    context,
                    ToastWidget(
                      'Registration successful',
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
            } else if (state is VerifyUserState) {
              Future.delayed(const Duration(milliseconds: 200)).then((value) {
                pageController.animateToPage(
                  ++pageIndicatorPosition,
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeIn,
                );
              });
            } else if (state is SaveUserState) {
              Future.delayed(const Duration(milliseconds: 300), () {
                goToDashboard();
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
                                        side:
                                            MaterialStateBorderSide.resolveWith(
                                          (states) => BorderSide(
                                            width: 1.0,
                                            color: ColorList.greyVeryLightColor,
                                          ),
                                        ),
                                        materialTapTargetSize:
                                            MaterialTapTargetSize.shrinkWrap,
                                        onChanged: (bool? value) {
                                          isTermsAndCondition = value ?? false;
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
                                  style: AppStyle.b9Medium.copyWith(
                                      color: ColorList.blackThirdColor),
                                ),
                                TextSpan(
                                  text: 'User Agreement',
                                  style: AppStyle.b9Medium
                                      .copyWith(color: ColorList.primaryColor),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () async {
                                      await launchUrl(
                                        Uri.parse(
                                            'https://kolobox.ng/tnc.html'),
                                        mode: LaunchMode.externalApplication,
                                      );
                                    },
                                ),
                                TextSpan(
                                  text: ' & ',
                                  style: AppStyle.b9Medium.copyWith(
                                      color: ColorList.blackThirdColor),
                                ),
                                TextSpan(
                                  text: 'Privacy Policy',
                                  style: AppStyle.b9Medium
                                      .copyWith(color: ColorList.primaryColor),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () async {
                                      await launchUrl(
                                        Uri.parse(
                                            'https://www.kolobox.ng/privacy-policy.html'),
                                        mode: LaunchMode.externalApplication,
                                      );
                                    },
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
                        pageIndicatorPosition == 2 ? 'Start Investing' : 'Next',
                        borderRadius: 32,
                        onPressed: () async {
                          switch (pageIndicatorPosition) {
                            case 0:
                              onClickRegister();
                              break;
                            case 1:
                              onClickVerifyUser();
                              break;
                            case 2:
                              goBack(context);

                              /// Set For register, login and go to dashboard
                              // BlocProvider.of<RegisterBloc>(context)
                              //     .add(SaveUserEvent());
                              break;
                          }
                        },
                      ),
                    ],
                  );
                }),
          ),
        ],
      );

  Widget stepOneEnterDetails() => ScrollConfiguration(
        behavior: NoOverFlowScrollbarBehaviour(),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Create your account',
                style:
                    AppStyle.b5Bold.copyWith(color: ColorList.blackSecondColor),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'First Name',
                style: AppStyle.b9Medium
                    .copyWith(color: ColorList.blackSecondColor),
              ),
              const SizedBox(
                height: 7,
              ),
              CustomTextField(
                'Enter your first name',
                controller: firstNameTextEditingController,
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.next,
                textCapitalization: TextCapitalization.words,
              ),
              const SizedBox(
                height: 24,
              ),
              Text(
                'Last Name',
                style: AppStyle.b9Medium
                    .copyWith(color: ColorList.blackSecondColor),
              ),
              const SizedBox(
                height: 7,
              ),
              CustomTextField(
                'Enter your last name',
                controller: lastNameTextEditingController,
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.next,
                textCapitalization: TextCapitalization.words,
              ),
              const SizedBox(
                height: 24,
              ),
              Text(
                'Email',
                style: AppStyle.b9Medium
                    .copyWith(color: ColorList.blackSecondColor),
              ),
              const SizedBox(
                height: 7,
              ),
              CustomTextField(
                'Enter your email address',
                controller: emailAddressTextEditingController,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                textCapitalization: TextCapitalization.none,
              ),
              const SizedBox(
                height: 24,
              ),
              Text(
                'Phone Number',
                style: AppStyle.b9Medium
                    .copyWith(color: ColorList.blackSecondColor),
              ),
              const SizedBox(
                height: 7,
              ),
              CustomTextField(
                'Enter phone number',
                controller: phoneNumberTextEditingController,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                textCapitalization: TextCapitalization.none,
                inputFormatter: [FilteringTextInputFormatter.digitsOnly],
              ),
              const SizedBox(
                height: 24,
              ),
              Text(
                'Date Of Birth',
                style: AppStyle.b9Medium
                    .copyWith(color: ColorList.blackSecondColor),
              ),
              const SizedBox(
                height: 7,
              ),
              StreamBuilder<bool>(
                  stream: dateOfBirthStreamController.stream,
                  builder: (context, snapshot) {
                    return CustomTextField(
                      dateOfBirth == null
                          ? 'Select your date of birth'
                          : DateHelper.getTextFromDateTime(
                              dateOfBirth!, 'dd MMMM yyyy'),
                      postIcon: imageCalendar,
                      onPressed: () {
                        onClickDOB();
                      },
                    );
                  }),
              const SizedBox(
                height: 24,
              ),
              Text(
                'Next of Kin',
                style: AppStyle.b9Medium
                    .copyWith(color: ColorList.blackSecondColor),
              ),
              const SizedBox(
                height: 7,
              ),
              CustomTextField(
                'Enter your next of kin',
                controller: nextOfKinTextEditingController,
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.next,
                textCapitalization: TextCapitalization.words,
              ),
              const SizedBox(
                height: 24,
              ),
              Text(
                'Occupation',
                style: AppStyle.b9Medium
                    .copyWith(color: ColorList.blackSecondColor),
              ),
              const SizedBox(
                height: 7,
              ),
              CustomTextField(
                'Enter your occupation',
                controller: occupationTextEditingController,
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.next,
                textCapitalization: TextCapitalization.words,
              ),
              const SizedBox(
                height: 24,
              ),
              // Text(
              //   'Referral',
              //   style: TextStyle(
              //     color: ColorList.blackSecondColor,
              //     fontSize: 12,
              //     fontWeight: FontWeight.w500,
              //   ),
              // ),
              // const SizedBox(
              //   height: 7,
              // ),
              // const CustomTextField('Enter referral code (Optional)'),
              // const SizedBox(
              //   height: 24,
              // ),
              Text(
                'Password',
                style: AppStyle.b9Medium
                    .copyWith(color: ColorList.blackSecondColor),
              ),
              const SizedBox(
                height: 7,
              ),
              StreamBuilder<bool>(
                  stream: passwordStreamController.stream,
                  builder: (context, snapshot) {
                    return CustomTextField(
                      'Create secure password',
                      controller: passwordTextEditingController,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      onChanged: (value) => changePasswordUpdated(),
                      obscureText: isPasswordObscure,
                      postWidget: GestureDetector(
                        onTap: () {
                          isPasswordObscure = !isPasswordObscure;
                          passwordStreamController.add(true);
                        },
                        child: Icon(isPasswordObscure
                            ? Icons.visibility
                            : Icons.visibility_off),
                      ),
                    );
                  }),
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
              StreamBuilder<bool>(
                  stream: confirmPasswordStreamController.stream,
                  builder: (context, snapshot) {
                    return CustomTextField(
                      'Confirm created password',
                      controller: cPasswordTextEditingController,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.done,
                      onChanged: (value) => changePasswordUpdated(),
                      obscureText: isConfirmPasswordObscure,
                      postWidget: GestureDetector(
                        onTap: () {
                          isConfirmPasswordObscure = !isConfirmPasswordObscure;
                          confirmPasswordStreamController.add(true);
                        },
                        child: Icon(isConfirmPasswordObscure
                            ? Icons.visibility
                            : Icons.visibility_off),
                      ),
                    );
                  }),
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

  void onClickRegister() {
    hideKeyboard();
    if (firstNameTextEditingController.text.isEmpty) {
      Utils.showToast(
          context,
          ToastWidget(
            'Enter first name',
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
    if (lastNameTextEditingController.text.isEmpty) {
      Utils.showToast(
          context,
          ToastWidget(
            'Enter last name',
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
    if (emailAddressTextEditingController.text.isEmpty) {
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
    if (!Utils.emailValid(emailAddressTextEditingController.text)) {
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
    if (phoneNumberTextEditingController.text.isEmpty) {
      Utils.showToast(
          context,
          ToastWidget(
            'Enter phone number',
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
    if (phoneNumberTextEditingController.text.length != 11) {
      Utils.showToast(
          context,
          ToastWidget(
            'Enter valid phone number',
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
    if (dateOfBirth == null) {
      Utils.showToast(
          context,
          ToastWidget(
            'Select date of birth',
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
    if (nextOfKinTextEditingController.text.isEmpty) {
      Utils.showToast(
          context,
          ToastWidget(
            'Enter next of kin',
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
    if (occupationTextEditingController.text.isEmpty) {
      Utils.showToast(
          context,
          ToastWidget(
            'Enter occupation',
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

    BlocProvider.of<RegisterBloc>(context).add(CallRegisterEvent(
      model: RegisterRequestModel(
        firstname: firstNameTextEditingController.text,
        lastname: lastNameTextEditingController.text,
        email: emailAddressTextEditingController.text,
        phone: phoneNumberTextEditingController.text,
        dob: DateHelper.getTextFromDateTime(dateOfBirth!, 'yyyy-MM-dd'),
        nextOfKin: nextOfKinTextEditingController.text,
        occupation: occupationTextEditingController.text,
        password: passwordTextEditingController.text,
        cPassword: cPasswordTextEditingController.text,
        school: '',
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

  Future<void> onClickDOB() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1990, 1),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      dateOfBirth = picked;
      dateOfBirthStreamController.add(true);
    }
  }

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
          'We have sent a 4 digit OTP code to your email address and phone number. Kindly input to verify and proceed',
          style: TextStyle(
            color: ColorList.blackThirdColor,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: PinCodeTextField(
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
            onChanged: (value) {
              print("asd fa fds $value");
            },
          ),
        ),
        const SizedBox(
          height: 25,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // GestureDetector(
            //   onTap: () {
            //     comingSoon();
            //   },
            //   child: Text(
            //     'Didn’t recieve OTP?',
            //     style: TextStyle(
            //       color: ColorList.blackThirdColor,
            //       fontSize: 12,
            //       fontWeight: FontWeight.w500,
            //     ),
            //   ),
            // ),
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

  onClickVerifyUser() {
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

    BlocProvider.of<RegisterBloc>(context).add(VerifyUserEvent(
        model: VerifyUserRequestModel(
      code: otpTextEditingController.text,
      id: '',
    )));
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
    passwordStrengthStreamController.close();
    dateOfBirthStreamController.close();
    firstNameTextEditingController.dispose();
    lastNameTextEditingController.dispose();
    emailAddressTextEditingController.dispose();
    phoneNumberTextEditingController.dispose();
    nextOfKinTextEditingController.dispose();
    occupationTextEditingController.dispose();
    passwordTextEditingController.dispose();
    cPasswordTextEditingController.dispose();
    passwordStreamController.close();
    confirmPasswordStreamController.close();
  }
}
