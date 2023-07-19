import 'package:flutter/material.dart';
import 'package:kolobox_new_app/core/enums/kolobox_fund_enum.dart';
import 'package:kolobox_new_app/feature/dashboard/data/models/get_family_user_list_response_model.dart';

import '../../../core/base/base_page.dart';
import '../../dashboard/data/models/group_users_data_model.dart';
import 'screen/family_contributors_screen.dart';

class FamilyContributorsPage extends BasePage {
  final KoloboxFundEnum koloboxFundEnum;
  final List<GroupUsers>? groupUsers;
  final List<FamilyUserModel>? familyUsers;

  const FamilyContributorsPage({
    Key? key,
    required this.koloboxFundEnum,
    this.groupUsers,
    this.familyUsers,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => FamilyContributorsPageState();
}

class FamilyContributorsPageState
    extends BasePageState<FamilyContributorsPage> {
  @override
  Widget getChildBlocWidget(BuildContext context) => FamilyContributorsScreen(
        koloboxFundEnum: widget.koloboxFundEnum,
        groupUsers: widget.groupUsers,
        familyUsers: widget.familyUsers,
      );
}
