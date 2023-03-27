import 'package:flutter/material.dart';

import '../../../core/base/base_page.dart';
import 'screen/family_contributors_screen.dart';

class FamilyContributorsPage extends BasePage {
  const FamilyContributorsPage({
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => FamilyContributorsPageState();
}

class FamilyContributorsPageState
    extends BasePageState<FamilyContributorsPage> {
  @override
  Widget getChildBlocWidget(BuildContext context) =>
      const FamilyContributorsScreen();
}
