import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kolobox_new_app/core/base/base_page.dart';

import '../../../core/bloc/master_bloc.dart';
import '../confirm_pin_and_pay/bloc/confirm_pin_and_pay_bloc.dart';
import 'deposit_your_kolobox_widget.dart';

class DepositYourKoloboxWidgetPage extends BasePage {
  final bool isCreateGroup;

  const DepositYourKoloboxWidgetPage({
    Key? key,
    this.isCreateGroup = false,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => DepositYourKoloboxWidgetPageState();
}

class DepositYourKoloboxWidgetPageState
    extends BasePageState<DepositYourKoloboxWidgetPage> {
  @override
  Widget getChildBlocWidget(BuildContext context) =>
      BlocProvider<ConfirmPinAndPayBloc>(
        create: (context) =>
            ConfirmPinAndPayBloc(BlocProvider.of<MasterBloc>(context)),
        child: DepositYourKoloboxWidget(
          isCreateGroup: widget.isCreateGroup,
        ),
      );
}
