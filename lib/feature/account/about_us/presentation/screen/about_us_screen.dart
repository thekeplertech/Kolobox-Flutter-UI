import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kolobox_new_app/core/colors/color_list.dart';
import 'package:kolobox_new_app/core/constants/image_constants.dart';
import 'package:kolobox_new_app/core/enums/confirm_pin_and_pay_action_enum.dart';
import 'package:kolobox_new_app/core/ui/style/app_style.dart';
import 'package:kolobox_new_app/feature/auth/login/presentation/bloc/login_bloc.dart';
import 'package:kolobox_new_app/feature/widgets/confirm_pin_and_pay/confirm_pin_and_pay_page.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../core/base/base_bloc_widget.dart';
import '../../../../../core/ui/widgets/no_app_bar.dart';
import '../../../../auth/login/presentation/bloc/login_state.dart';
import '../../../../dashboard/presentation/bloc/dashboard_bloc.dart';
import '../../../../dashboard/presentation/bloc/dashboard_event.dart';
import '../../../../widgets/home_app_bar_widget.dart';

class AboutUsScreen extends BaseBlocWidget {
  const AboutUsScreen({
    Key? key,
  }) : super(key: key);

  @override
  AboutUsState createState() => AboutUsState();
}

class AboutUsState extends BaseBlocWidgetState<AboutUsScreen> {
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
        listener: (_, state) {},
        child: getChild(),
      ),
    );
  }

  Widget getChild() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const HomeAppBarWidget(leftIcon: imageBackArrowIcon),
        const SizedBox(
          height: 30,
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 28,
            right: 28,
            bottom: 50,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Image.asset(imageLogoOnBoarding),
              ),
              const SizedBox(
                height: 50,
              ),
              Center(
                child: Text(
                  'About Us',
                  style: AppStyle.b2Bold
                      .copyWith(color: ColorList.greyLight15Color),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: 28,
              ),
              Center(
                child: Text(
                  'Our mission is to empower our customers with tools that enable them take charge of their personal finances.',
                  style: AppStyle.b8SemiBold
                      .copyWith(color: ColorList.blackSecondColor),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Center(
                child: Text(
                  'Traditional financial institutions have made saving money and growing wealth costly and unattractive to individuals who are outside their high net worth bracket. We want to make saving worthwhile again for everyone by making it simple to do and highly rewarding. We invite you to join us on this wonderful journey.',
                  style: AppStyle.b8Regular
                      .copyWith(color: ColorList.blackSecondColor),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Container(
            width: double.maxFinite,
            decoration: const BoxDecoration(
              color: ColorList.primaryColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(31),
                topRight: Radius.circular(31),
              ),
            ),
            padding:
                const EdgeInsets.only(left: 28, right: 28, top: 31, bottom: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'App version 1.2',
                  style: AppStyle.b6Bold.copyWith(color: ColorList.white),
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: ColorList.blueDarkColor,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 7,
                  ),
                  child: Text(
                    'We are social',
                    style: AppStyle.b8Medium.copyWith(color: ColorList.white),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                        onTap: () async {
                          await launchUrl(
                            Uri.parse('https://www.facebook.com/Kolobox.ng/'),
                            mode: LaunchMode.externalApplication,
                          );
                        },
                        child: Image.asset(imageFacebook)),
                    const SizedBox(
                      width: 10,
                    ),
                    InkWell(
                        onTap: () async {
                          await launchUrl(
                            Uri.parse('https://twitter.com/kolobox_ng'),
                            mode: LaunchMode.externalApplication,
                          );
                        },
                        child: Image.asset(imageTwitter)),
                    const SizedBox(
                      width: 10,
                    ),
                    InkWell(
                        onTap: () async {
                          await launchUrl(
                            Uri.parse(
                                'https://www.linkedin.com/in/kolobox-ng-769245167/'),
                            mode: LaunchMode.externalApplication,
                          );
                        },
                        child: Image.asset(imageLinkedIn)),
                    const SizedBox(
                      width: 10,
                    ),
                    InkWell(
                        onTap: () async {
                          await launchUrl(
                            Uri.parse('https://www.instagram.com/kolobox.ng/'),
                            mode: LaunchMode.externalApplication,
                          );
                        },
                        child: Image.asset(imageInstagram)),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  onClickUpdateTransactionPin() {
    BlocProvider.of<DashboardBloc>(context).add(HideDisableBottomScreenEvent());
    showCustomBottomSheet(const ConfirmPinAndPayPage(
      actionEnum: ConfirmPinAndPayActionEnum.updatePin,
    )).then((value) {
      BlocProvider.of<DashboardBloc>(context)
          .add(ShowEnableBottomScreenEvent());
    });
  }

  @override
  void dispose() {
    super.dispose();
  }
}
