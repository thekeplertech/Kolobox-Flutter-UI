import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kolobox_new_app/config/flavor_config.dart';
import 'package:kolobox_new_app/core/colors/color_list.dart';
import 'package:kolobox_new_app/core/constants/image_constants.dart';
import 'package:kolobox_new_app/core/ui/style/app_style.dart';
import 'package:kolobox_new_app/core/ui/widgets/button.dart';
import 'package:kolobox_new_app/core/ui/widgets/custom_text_field.dart';
import 'package:kolobox_new_app/core/utils/utils.dart';
import 'package:kolobox_new_app/feature/auth/login/data/models/login_response_model.dart';
import 'package:kolobox_new_app/feature/auth/login/presentation/bloc/login_bloc.dart';
import 'package:kolobox_new_app/feature/widgets/pin_created_widget.dart';
import 'package:kolobox_new_app/routes/routes.dart';

import '../../../../../core/base/base_bloc_widget.dart';
import '../../../../../core/ui/widgets/no_overflow_scrollbar_behaviour.dart';
import '../../../../../core/ui/widgets/toast_widget.dart';
import '../../../../widgets/create_pin_widget.dart';
import '../../data/models/create_pin_request_model.dart';
import '../../data/models/login_request_model.dart';
import '../bloc/login_event.dart';
import '../bloc/login_state.dart';

class LoginScreen extends BaseBlocWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends BaseBlocWidgetState<LoginScreen> {
  final TextEditingController emailTextEditingController =
      TextEditingController();
  final TextEditingController passwordTextEditingController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    if (FlavorConfig.isDev()) {
      emailTextEditingController.text = 'parth12345678931@mailinator.com';
      passwordTextEditingController.text = 'kolobox@123';
      // emailTextEditingController.text = 'tulbadex@gmail.com';
      // passwordTextEditingController.text = 'password';
    }
  }

  @override
  Widget getCustomBloc() => Scaffold(
        backgroundColor: ColorList.primaryColor,
        appBar: AppBar(
          backgroundColor: ColorList.transparentColor,
          bottomOpacity: 0,
          elevation: 0,
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: ColorList.primaryColor,
            statusBarIconBrightness: Brightness.light,
            statusBarBrightness: Brightness.dark,
          ),
        ),
        body: BlocListener<LoginBloc, LoginState>(
          listener: (_, state) {
            if (state is CallLoginState) {
              Future.delayed(const Duration(milliseconds: 200), () {
                if (state.isPinSet) {
                  showCustomBottomSheet(
                    PinCreatedWidget(
                      onBack: () {
                        Future.delayed(const Duration(milliseconds: 200), () {
                          saveDataAndGoToDashboard();
                        });
                      },
                    ),
                  );
                } else {
                  saveDataAndGoToDashboard();
                }
              });
            } else if (state is CreatePinState) {
              Future.delayed(const Duration(milliseconds: 200), () {
                showDialogForCreatePin(state.model);
              });
            }
          },
          child: getChildWidget(),
        ),
      );

  Widget getChildWidget() {
    return Container(
      height: double.maxFinite,
      color: ColorList.white,
      child: ScrollConfiguration(
        behavior: NoOverFlowScrollbarBehaviour(),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                color: ColorList.primaryColor,
                padding: const EdgeInsets.only(top: 60, bottom: 60),
                child: Center(
                  child: Image.asset(
                    imageLogoMain,
                    width: 204,
                    height: 126,
                  ),
                ),
              ),
              Container(
                color: ColorList.white,
                padding: const EdgeInsets.only(
                  left: 28,
                  right: 28,
                  top: 25,
                  bottom: 28,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Sign In to KoloBox',
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
                    CustomTextField(
                      'Enter password',
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.done,
                      controller: passwordTextEditingController,
                      obscureText: true,
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () {
                          navigateTo(context, Routes.forgotPassword);
                        },
                        child: const Padding(
                          padding:
                              EdgeInsets.only(left: 10, top: 10, bottom: 10),
                          child: Text(
                            'Forgot password?',
                            style: TextStyle(
                              color: ColorList.primaryColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Button(
                      'Login',
                      borderRadius: 32,
                      onPressed: () => onClickLogin(),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: RichText(
                        text: TextSpan(children: [
                          TextSpan(
                            text: 'User Agreement',
                            style: AppStyle.b8Medium
                                .copyWith(color: ColorList.primaryColor),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => comingSoon(),
                          ),
                          TextSpan(
                            text: ' & ',
                            style: AppStyle.b8Medium
                                .copyWith(color: ColorList.blackThirdColor),
                          ),
                          TextSpan(
                            text: 'Privacy Policy',
                            style: AppStyle.b8Medium
                                .copyWith(color: ColorList.primaryColor),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => comingSoon(),
                          ),
                        ]),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showDialogForCreatePin(LoginResponseModel model) {
    showCustomBottomSheet(CreatePinWidget(
      onBack: (value1) {
        Future.delayed(const Duration(milliseconds: 200), () {
          showCustomBottomSheet(CreatePinWidget(
            isConfirmPin: true,
            onBack: (value2) {
              Future.delayed(const Duration(milliseconds: 200), () {
                if (value1 == value2) {
                  BlocProvider.of<LoginBloc>(context).add(CallCreatePinEvent(
                    loginResponseModel: model,
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
                  showDialogForCreatePin(model);
                }
              });
            },
          ));
        });
      },
    ));
  }

  void onClickLogin() {
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

    BlocProvider.of<LoginBloc>(context).add(CallLoginEvent(
        model: LoginRequestModel(
      username: emailTextEditingController.text,
      password: passwordTextEditingController.text,
    )));
  }

  void saveDataAndGoToDashboard() {
    Utils.showToast(
        context,
        ToastWidget(
          'Login successful',
          closeWidget: Image.asset(
            imageClose,
            color: ColorList.white,
          ),
        ));

    goToDashboard();
  }

  @override
  void dispose() {
    emailTextEditingController.dispose();
    passwordTextEditingController.dispose();
    super.dispose();
  }
}
