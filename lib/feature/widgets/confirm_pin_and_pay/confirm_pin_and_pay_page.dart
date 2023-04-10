import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kolobox_new_app/core/base/base_page.dart';
import 'package:kolobox_new_app/feature/widgets/confirm_pin_and_pay/confirm_pin_and_pay_screen.dart';

import '../../../core/bloc/master_bloc.dart';
import 'bloc/confirm_pin_and_pay_bloc.dart';

class ConfirmPinAndPayPage extends BasePage {
  const ConfirmPinAndPayPage({
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => ConfirmPinAndPayPageState();
}

class ConfirmPinAndPayPageState extends BasePageState<ConfirmPinAndPayPage> {
  @override
  Widget getChildBlocWidget(BuildContext context) =>
      BlocProvider<ConfirmPinAndPayBloc>(
        create: (context) =>
            ConfirmPinAndPayBloc(BlocProvider.of<MasterBloc>(context)),
        child: const ConfirmPinAndPayScreen(),
      );
}
