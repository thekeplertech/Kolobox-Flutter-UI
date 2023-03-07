import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kolobox_new_app/core/colors/color_list.dart';
import 'package:kolobox_new_app/core/ui/widgets/button.dart';
import 'package:kolobox_new_app/feature/auth/login/presentation/login_page.dart';
import 'package:kolobox_new_app/feature/on_boarding/on_boarding/presentation/on_boarding_page.dart';

import '../../../../../core/base/base_bloc_widget.dart';
import '../../../../../core/constants/image_constants.dart';
import '../../../../../routes/routes.dart';

class SplashLoadedScreen extends BaseBlocWidget {
  const SplashLoadedScreen({Key? key}) : super(key: key);

  @override
  SplashLoadedScreenState createState() => SplashLoadedScreenState();
}

class SplashLoadedScreenState extends BaseBlocWidgetState<SplashLoadedScreen> {
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
          width: MediaQuery.of(context).size.width,
          color: ColorList.primaryColor,
          child: Column(
            children: [
              Expanded(
                child: Image.asset(
                  imageLogoMain,
                  width: 204,
                  height: 126,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 28, right: 28, bottom: 32),
                child: Column(
                  children: [
                    Button(
                      'Login',
                      borderRadius: 25,
                      onPressed: () {
                        navigatePush(context, const LoginPage());
                      },
                    ),
                    const SizedBox(
                      height: 28,
                    ),
                    Button(
                      'Get Started',
                      borderRadius: 25,
                      backgroundColor: ColorList.white,
                      overlayColor: ColorList.blueLightColor,
                      textColor: ColorList.primaryColor,
                      onPressed: () {
                        navigatePush(context, const OnBoardingPage());
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}
