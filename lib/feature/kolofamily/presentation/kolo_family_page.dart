import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/base/base_page.dart';
import '../../../core/bloc/master_bloc.dart';
import 'bloc/kolo_family_bloc.dart';
import 'screen/kolo_family_screen.dart';

class KoloFamilyPage extends BasePage {
  const KoloFamilyPage({
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => KoloFamilyPageState();
}

class KoloFamilyPageState extends BasePageState<KoloFamilyPage> {
  @override
  Widget getChildBlocWidget(BuildContext context) =>
      BlocProvider<KoloFamilyBloc>(
        create: (context) =>
            KoloFamilyBloc(BlocProvider.of<MasterBloc>(context)),
        child: const KoloFamilyScreen(),
      );
}
