import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kolobox_new_app/feature/dashboard/data/models/earnings_data_model.dart';
import 'package:kolobox_new_app/feature/koloflex/presentation/bloc/kolo_flex_bloc.dart';

import '../../../core/base/base_page.dart';
import '../../../core/bloc/master_bloc.dart';
import 'screen/kolo_flex_screen.dart';

class KoloFlexPage extends BasePage {
  final EarningsDataModel earningsDataModel;

  const KoloFlexPage({
    Key? key,
    required this.earningsDataModel,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => KoloFlexPageState();
}

class KoloFlexPageState extends BasePageState<KoloFlexPage> {
  @override
  Widget getChildBlocWidget(BuildContext context) => BlocProvider<KoloFlexBloc>(
        create: (context) => KoloFlexBloc(BlocProvider.of<MasterBloc>(context)),
        child: KoloFlexScreen(earningsDataModel: widget.earningsDataModel),
      );
}
