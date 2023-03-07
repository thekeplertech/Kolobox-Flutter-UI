import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kolobox_new_app/core/colors/color_list.dart';
import 'package:kolobox_new_app/core/constants/image_constants.dart';
import 'package:kolobox_new_app/core/ui/widgets/button.dart';
import 'package:kolobox_new_app/core/ui/widgets/custom_text_field.dart';
import 'package:kolobox_new_app/routes/routes.dart';

import '../../../../../core/base/base_bloc_widget.dart';
import '../../../../../core/ui/widgets/no_overflow_scrollbar_behaviour.dart';

class LoginScreen extends BaseBlocWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends BaseBlocWidgetState<LoginScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget getCustomBloc() => Scaffold(
        backgroundColor: ColorList.primaryColor,
        appBar: AppBar(
          backgroundColor: ColorList.transparentColor,
          bottomOpacity: 0,
          elevation: 0,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: ColorList.primaryColor,
            statusBarIconBrightness: Brightness.light,
            statusBarBrightness: Brightness.dark,
          ),
        ),
        body: Container(
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
                        const CustomTextField(
                          'Enter email address',
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
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
                        const CustomTextField(
                          'Enter password',
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.done,
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
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 10, top: 10, bottom: 10),
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
                          onPressed: () {
                            navigateAndRemoveAll(
                                context, Routes.dashboard, Routes.dashboard);
                          },
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
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}
