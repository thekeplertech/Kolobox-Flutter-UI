import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kolobox_new_app/feature/auth/login/presentation/bloc/login_bloc.dart';
import 'package:kolobox_new_app/feature/auth/login/presentation/screen/login_screen.dart';

import '../../../../core/base/base_page.dart';
import '../../../../core/bloc/master_bloc.dart';

class LoginPage extends BasePage {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => LoginPageState();
}

class LoginPageState extends BasePageState<LoginPage> {
  @override
  Widget getChildBlocWidget(BuildContext context) => BlocProvider<LoginBloc>(
        create: (context) => LoginBloc(BlocProvider.of<MasterBloc>(context)),
        child: const LoginScreen(),
      );
}
