import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kolobox_new_app/core/colors/color_list.dart';

import '../../../../core/base/base_bloc_widget.dart';
import '../../../../core/constants/image_constants.dart';
import '../../../../routes/routes.dart';
import '../bloc/splash_bloc.dart';
import '../bloc/splash_event.dart';
import '../bloc/splash_state.dart';

class SplashScreen extends BaseBlocWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends BaseBlocWidgetState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    wait();
  }

  wait() => BlocProvider.of<SplashBloc>(context).add(WaitEvent());

  @override
  Widget getCustomBloc() => BlocListener<SplashBloc, SplashState>(
        listener: (_, state) {
          if (state is WaitState) {
            navigateAndRemoveAll(
                context, Routes.splashLoaded, Routes.splashLoaded);
          }
        },
        child: Scaffold(
          body: Container(
            width: MediaQuery.of(context).size.width,
            color: ColorList.primaryColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  imageLogoMain,
                  width: 204,
                  height: 126,
                ),
              ],
            ),
          ),
        ),
      );
}
