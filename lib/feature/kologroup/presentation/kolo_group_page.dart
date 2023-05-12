import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/base/base_page.dart';
import '../../../core/bloc/master_bloc.dart';
import 'bloc/kolo_group_bloc.dart';
import 'screen/kolo_group_screen.dart';

class KoloGroupPage extends BasePage {
  const KoloGroupPage({
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => KoloGroupPageState();
}

class KoloGroupPageState extends BasePageState<KoloGroupPage> {
  @override
  Widget getChildBlocWidget(BuildContext context) =>
      BlocProvider<KoloGroupBloc>(
        create: (context) =>
            KoloGroupBloc(BlocProvider.of<MasterBloc>(context)),
        child: const KoloGroupScreen(),
      );
}
