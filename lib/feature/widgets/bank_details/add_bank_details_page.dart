import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kolobox_new_app/core/base/base_page.dart';

import '../../../core/bloc/master_bloc.dart';
import '../../../core/enums/bank_detail_enum.dart';
import '../../account/bank_details/presentation/bloc/bank_detail_bloc.dart';
import '../../dashboard/data/models/get_all_my_banks_response_model.dart';
import '../../dashboard/data/models/get_banks_response_model.dart';
import 'add_bank_details.dart';

class AddBankDetailsPage extends BasePage {
  final List<BankData> banks;
  final Function() onSave;
  final BankDetailEnum bankDetailEnum;
  final MyBankData? selectedBankData;

  const AddBankDetailsPage({
    Key? key,
    required this.banks,
    required this.onSave,
    this.bankDetailEnum = BankDetailEnum.addBank,
    this.selectedBankData,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => AddBankDetailsPageState();
}

class AddBankDetailsPageState extends BasePageState<AddBankDetailsPage> {
  @override
  Widget getChildBlocWidget(BuildContext context) =>
      BlocProvider<BankDetailBloc>(
        create: (context) =>
            BankDetailBloc(BlocProvider.of<MasterBloc>(context)),
        child: AddBankDetailsWidget(
          banks: widget.banks,
          onSave: widget.onSave,
          bankDetailEnum: widget.bankDetailEnum,
          selectedBankData: widget.selectedBankData,
        ),
      );
}
