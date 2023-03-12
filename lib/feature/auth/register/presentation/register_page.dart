import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/base/base_page.dart';
import '../../../../core/bloc/master_bloc.dart';
import 'bloc/register_bloc.dart';
import 'screen/register_screen.dart';

class RegisterPage extends BasePage {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => RegisterPageState();
}

class RegisterPageState extends BasePageState<RegisterPage> {
  @override
  Widget getChildBlocWidget(BuildContext context) => BlocProvider<RegisterBloc>(
        create: (context) => RegisterBloc(BlocProvider.of<MasterBloc>(context)),
        child: const RegisterScreen(),
      );
}
