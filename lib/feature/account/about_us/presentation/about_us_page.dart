import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/base/base_page.dart';
import '../../../../core/bloc/master_bloc.dart';
import '../../../auth/login/presentation/bloc/login_bloc.dart';
import 'screen/about_us_screen.dart';

class AboutUsPage extends BasePage {
  const AboutUsPage({
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => AboutUsPageState();
}

class AboutUsPageState extends BasePageState<AboutUsPage> {
  @override
  Widget getChildBlocWidget(BuildContext context) => BlocProvider<LoginBloc>(
        create: (context) => LoginBloc(BlocProvider.of<MasterBloc>(context)),
        child: const AboutUsScreen(),
      );
}
