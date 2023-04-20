import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kolobox_new_app/feature/widgets/edit_profile/bloc/edit_profile_bloc.dart';

import '../../../../core/base/base_page.dart';
import '../../../core/bloc/master_bloc.dart';
import 'edit_next_of_kin.dart';

class EditNextOfKinPage extends BasePage {
  const EditNextOfKinPage({
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => EditNextOfKinPageState();
}

class EditNextOfKinPageState extends BasePageState<EditNextOfKinPage> {
  @override
  Widget getChildBlocWidget(BuildContext context) =>
      BlocProvider<EditProfileBloc>(
        create: (context) =>
            EditProfileBloc(BlocProvider.of<MasterBloc>(context)),
        child: const EditNextOfKinWidget(),
      );
}
