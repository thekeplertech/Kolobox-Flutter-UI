import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kolobox_new_app/feature/kolotarget/presentation/bloc/kolo_target_bloc.dart';

import '../../../core/base/base_page.dart';
import '../../../core/bloc/master_bloc.dart';
import '../../dashboard/data/models/earnings_data_model.dart';
import 'screen/kolo_target_screen.dart';

class KoloTargetPage extends BasePage {
  final EarningsDataModel earningsDataModel;

  const KoloTargetPage({
    Key? key,
    required this.earningsDataModel,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => KoloTargetPageState();
}

class KoloTargetPageState extends BasePageState<KoloTargetPage> {
  @override
  Widget getChildBlocWidget(BuildContext context) =>
      BlocProvider<KoloTargetBloc>(
        create: (context) =>
            KoloTargetBloc(BlocProvider.of<MasterBloc>(context)),
        child: KoloTargetScreen(earningsDataModel: widget.earningsDataModel),
      );
}
