import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kolobox_new_app/feature/auth/forget_password/presentation/bloc/forgot_password_bloc.dart';

import '../../../../core/base/base_page.dart';
import '../../../../core/bloc/master_bloc.dart';
import 'screen/forgot_password_screen.dart';

class ForgotPasswordPage extends BasePage {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => ForgotPasswordPageState();
}

class ForgotPasswordPageState extends BasePageState<ForgotPasswordPage> {
  @override
  Widget getChildBlocWidget(BuildContext context) =>
      BlocProvider<ForgotPasswordBloc>(
        create: (context) =>
            ForgotPasswordBloc(BlocProvider.of<MasterBloc>(context)),
        child: const ForgotPasswordScreen(),
      );
}
