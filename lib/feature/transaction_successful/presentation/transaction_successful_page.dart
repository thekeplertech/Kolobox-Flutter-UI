import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kolobox_new_app/feature/transaction_successful/presentation/bloc/transaction_successful_bloc.dart';

import '../../../../core/base/base_page.dart';
import '../../../core/bloc/master_bloc.dart';
import 'screen/transaction_successful_screen.dart';

class TransactionSuccessfulPage extends BasePage {
  final String referenceCode;
  final String amount;
  final bool isDeposited;
  final bool isSuccess;
  final String errorMessage;

  const TransactionSuccessfulPage({
    Key? key,
    required this.referenceCode,
    required this.amount,
    this.isDeposited = true,
    this.isSuccess = true,
    this.errorMessage = '',
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => TransactionSuccessfulPageState();
}

class TransactionSuccessfulPageState
    extends BasePageState<TransactionSuccessfulPage> {
  @override
  Widget getChildBlocWidget(BuildContext context) =>
      BlocProvider<TransactionSuccessfulBloc>(
        create: (context) =>
            TransactionSuccessfulBloc(BlocProvider.of<MasterBloc>(context)),
        child: TransactionSuccessfulScreen(
          referenceCode: widget.referenceCode,
          amount: widget.amount,
          isDeposited: widget.isDeposited,
          isSuccess: widget.isSuccess,
          errorMessage: widget.errorMessage,
        ),
      );
}
