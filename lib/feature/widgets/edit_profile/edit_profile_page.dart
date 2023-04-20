import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kolobox_new_app/feature/widgets/edit_profile/bloc/edit_profile_bloc.dart';
import 'package:kolobox_new_app/feature/widgets/edit_profile/edit_profile.dart';

import '../../../../core/base/base_page.dart';
import '../../../core/bloc/master_bloc.dart';

class EditProfilePage extends BasePage {
  const EditProfilePage({
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => EditProfilePageState();
}

class EditProfilePageState extends BasePageState<EditProfilePage> {
  @override
  Widget getChildBlocWidget(BuildContext context) =>
      BlocProvider<EditProfileBloc>(
        create: (context) =>
            EditProfileBloc(BlocProvider.of<MasterBloc>(context)),
        child: const EditProfileWidget(),
      );
}
