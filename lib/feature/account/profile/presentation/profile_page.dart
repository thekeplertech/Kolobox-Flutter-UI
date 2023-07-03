import 'package:flutter/material.dart';

import '../../../../core/base/base_page.dart';
import 'screen/profile_screen.dart';

class ProfilePage extends BasePage {
  const ProfilePage({
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => ProfilePageState();
}

class ProfilePageState extends BasePageState<ProfilePage> {
  @override
  Widget getChildBlocWidget(BuildContext context) => const ProfileScreen();
}
