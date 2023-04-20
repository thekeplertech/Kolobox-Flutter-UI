import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/base/base_page.dart';
import '../../../../core/bloc/master_bloc.dart';
import '../../../auth/login/presentation/bloc/login_bloc.dart';
import 'screen/update_password_screen.dart';

class UpdatePasswordPage extends BasePage {
  const UpdatePasswordPage({
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => UpdatePasswordPageState();
}

class UpdatePasswordPageState extends BasePageState<UpdatePasswordPage> {
  @override
  Widget getChildBlocWidget(BuildContext context) => BlocProvider<LoginBloc>(
        create: (context) => LoginBloc(BlocProvider.of<MasterBloc>(context)),
        child: const UpdatePasswordScreen(),
      );
}
