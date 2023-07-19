import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kolobox_new_app/feature/koloflex/presentation/bloc/kolo_flex_bloc.dart';

import '../../../core/base/base_page.dart';
import '../../../core/bloc/master_bloc.dart';
import '../../../core/enums/kolobox_fund_enum.dart';
import '../../dashboard/data/models/get_group_list_response_model.dart';
import 'invite_family_member_summary_screen.dart';

class InviteFamilyMemberSummaryWidgetPage extends BasePage {
  final String emailAddress;
  final GroupModel groupModel;
  final KoloboxFundEnum koloboxFundEnum;
  final String relation;

  const InviteFamilyMemberSummaryWidgetPage({
    Key? key,
    required this.emailAddress,
    required this.groupModel,
    required this.koloboxFundEnum,
    required this.relation,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() =>
      InviteFamilyMemberSummaryWidgetPageState();
}

class InviteFamilyMemberSummaryWidgetPageState
    extends BasePageState<InviteFamilyMemberSummaryWidgetPage> {
  @override
  Widget getChildBlocWidget(BuildContext context) => BlocProvider<KoloFlexBloc>(
        create: (context) => KoloFlexBloc(BlocProvider.of<MasterBloc>(context)),
        child: InviteFamilyMemberSummaryWidget(
          emailAddress: widget.emailAddress,
          groupModel: widget.groupModel,
          koloboxFundEnum: widget.koloboxFundEnum,
          relation: widget.relation,
        ),
      );
}
