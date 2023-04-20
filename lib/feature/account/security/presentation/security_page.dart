import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/base/base_page.dart';
import '../../../../core/bloc/master_bloc.dart';
import '../../../auth/login/presentation/bloc/login_bloc.dart';
import 'screen/security_screen.dart';

class SecurityPage extends BasePage {
  const SecurityPage({
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => SecurityPageState();
}

class SecurityPageState extends BasePageState<SecurityPage> {
  @override
  Widget getChildBlocWidget(BuildContext context) => BlocProvider<LoginBloc>(
        create: (context) => LoginBloc(BlocProvider.of<MasterBloc>(context)),
        child: const SecurityScreen(),
      );
}
