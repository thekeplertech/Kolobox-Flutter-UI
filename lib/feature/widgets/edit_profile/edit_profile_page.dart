import 'package:flutter/material.dart';
import 'package:kolobox_new_app/feature/widgets/edit_profile/edit_profile.dart';

import '../../../../core/base/base_page.dart';

class EditProfilePage extends BasePage {
  const EditProfilePage({
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => EditProfilePageState();
}

class EditProfilePageState extends BasePageState<EditProfilePage> {
  @override
  Widget getChildBlocWidget(BuildContext context) => const EditProfileWidget();
}
