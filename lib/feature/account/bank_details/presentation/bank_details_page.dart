import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kolobox_new_app/feature/account/bank_details/presentation/bloc/bank_detail_bloc.dart';

import '../../../../core/base/base_page.dart';
import '../../../../core/bloc/master_bloc.dart';
import 'screen/bank_details_screen.dart';

class BankDetailsPage extends BasePage {
  final bool isFromWithdrawPopUp;

  const BankDetailsPage({
    Key? key,
    this.isFromWithdrawPopUp = false,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => BankDetailsPageState();
}

class BankDetailsPageState extends BasePageState<BankDetailsPage> {
  @override
  Widget getChildBlocWidget(BuildContext context) =>
      BlocProvider<BankDetailBloc>(
        create: (context) =>
            BankDetailBloc(BlocProvider.of<MasterBloc>(context)),
        child:
            BankDetailsScreen(isFromWithdrawPopUp: widget.isFromWithdrawPopUp),
      );
}
