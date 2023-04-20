import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kolobox_new_app/core/base/base_page.dart';
import 'package:kolobox_new_app/feature/auth/login/presentation/bloc/login_bloc.dart';
import 'package:kolobox_new_app/feature/widgets/confirm_pin_and_pay/confirm_pin_and_pay_screen.dart';

import '../../../core/bloc/master_bloc.dart';
import '../../../core/enums/confirm_pin_and_pay_action_enum.dart';
import 'bloc/confirm_pin_and_pay_bloc.dart';

class ConfirmPinAndPayPage extends BasePage {
  final ConfirmPinAndPayActionEnum actionEnum;
  final Function()? onSuccess;

  const ConfirmPinAndPayPage({
    Key? key,
    this.actionEnum = ConfirmPinAndPayActionEnum.verifyPin,
    this.onSuccess,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => ConfirmPinAndPayPageState();
}

class ConfirmPinAndPayPageState extends BasePageState<ConfirmPinAndPayPage> {
  @override
  Widget getChildBlocWidget(BuildContext context) => MultiBlocProvider(
        providers: [
          BlocProvider<ConfirmPinAndPayBloc>(
            create: (context) =>
                ConfirmPinAndPayBloc(BlocProvider.of<MasterBloc>(context)),
          ),
          BlocProvider<LoginBloc>(
            create: (context) =>
                LoginBloc(BlocProvider.of<MasterBloc>(context)),
          ),
        ],
        child: ConfirmPinAndPayScreen(
          actionEnum: widget.actionEnum,
          onSuccess: widget.onSuccess,
        ),
      );
}
