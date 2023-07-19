import 'package:flutter/material.dart';
import 'package:kolobox_new_app/core/colors/color_list.dart';
import 'package:kolobox_new_app/core/constants/image_constants.dart';
import 'package:kolobox_new_app/core/ui/style/app_style.dart';
import 'package:kolobox_new_app/feature/dashboard/data/models/get_family_user_list_response_model.dart';

import '../../../../../core/base/base_bloc_widget.dart';
import '../../../../core/enums/kolobox_fund_enum.dart';
import '../../../../core/ui/widgets/no_app_bar.dart';
import '../../../../core/ui/widgets/no_overflow_scrollbar_behaviour.dart';
import '../../../dashboard/data/models/group_users_data_model.dart';
import '../../../widgets/home_app_bar_widget.dart';
import '../widgets/family_contributors_widget.dart';

class FamilyContributorsScreen extends BaseBlocWidget {
  final KoloboxFundEnum koloboxFundEnum;
  final List<GroupUsers>? groupUsers;
  final List<FamilyUserModel>? familyUsers;

  const FamilyContributorsScreen({
    Key? key,
    required this.koloboxFundEnum,
    this.groupUsers,
    this.familyUsers,
  }) : super(key: key);

  @override
  FamilyContributorsState createState() => FamilyContributorsState();
}

class FamilyContributorsState
    extends BaseBlocWidgetState<FamilyContributorsScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget getCustomBloc() {
    return Scaffold(
      backgroundColor: ColorList.white,
      appBar: const NoAppBar(),
      body: ScrollConfiguration(
        behavior: NoOverFlowScrollbarBehaviour(),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const HomeAppBarWidget(leftIcon: imageBackArrowIcon),
              Padding(
                padding: const EdgeInsets.only(
                    left: 28, right: 28, top: 15, bottom: 28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.koloboxFundEnum == KoloboxFundEnum.koloFamily
                          ? 'Family Contributors'
                          : 'Contributors',
                      style: AppStyle.b4Bold
                          .copyWith(color: ColorList.blackSecondColor),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      'These are your investment partners',
                      style: AppStyle.b9Regular
                          .copyWith(color: ColorList.blackThirdColor),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    if (widget.groupUsers != null) ...[
                      GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 14,
                          mainAxisSpacing: 14,
                          childAspectRatio: 1.2,
                        ),
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: widget.groupUsers?.length,
                        itemBuilder: (_, index) => FamilyContributorsWidget(
                          groupUser: widget.groupUsers![index],
                          koloboxFundEnum: widget.koloboxFundEnum,
                        ),
                      ),
                    ] else if (widget.familyUsers != null) ...[
                      GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 14,
                          mainAxisSpacing: 14,
                          childAspectRatio: 1.2,
                        ),
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: widget.familyUsers?.length,
                        itemBuilder: (_, index) => FamilyContributorsWidget(
                          familyUserModel: widget.familyUsers![index],
                          koloboxFundEnum: widget.koloboxFundEnum,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
