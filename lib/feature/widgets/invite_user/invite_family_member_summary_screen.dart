import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kolobox_new_app/core/base/base_bloc_widget.dart';
import 'package:kolobox_new_app/core/constants/image_constants.dart';
import 'package:kolobox_new_app/core/ui/style/app_style.dart';
import 'package:kolobox_new_app/feature/dashboard/data/models/create_family_user_request_model.dart';
import 'package:kolobox_new_app/feature/dashboard/data/models/group_invite_request_model.dart';
import 'package:kolobox_new_app/feature/koloflex/presentation/bloc/kolo_flex_event.dart';
import 'package:kolobox_new_app/feature/koloflex/presentation/bloc/kolo_flex_state.dart';
import 'package:kolobox_new_app/routes/routes.dart';

import '../../../core/colors/color_list.dart';
import '../../../core/enums/kolobox_fund_enum.dart';
import '../../../core/ui/widgets/button.dart';
import '../../dashboard/data/models/get_group_list_response_model.dart';
import '../../koloflex/presentation/bloc/kolo_flex_bloc.dart';
import 'invite_family_member_successfully.dart';

class InviteFamilyMemberSummaryWidget extends BaseBlocWidget {
  final String emailAddress;
  final GroupModel groupModel;
  final KoloboxFundEnum koloboxFundEnum;
  final String relation;

  const InviteFamilyMemberSummaryWidget({
    Key? key,
    required this.emailAddress,
    required this.groupModel,
    required this.koloboxFundEnum,
    required this.relation,
  }) : super(key: key);

  @override
  State<InviteFamilyMemberSummaryWidget> createState() =>
      _InviteFamilyMemberSummaryWidgetState();
}

class _InviteFamilyMemberSummaryWidgetState
    extends BaseBlocWidgetState<InviteFamilyMemberSummaryWidget> {
  // TextEditingController nameTextEditingController = TextEditingController();

  // StreamController<bool> enableRecurringDepositStreamController =
  //     StreamController<bool>.broadcast();
  // bool isEnableRecurringDeposit = false;

  // KoloboxFundEnum koloboxFundEnum = KoloboxFundEnum.koloFlex;

  @override
  Widget getCustomBloc() {
    // koloboxFundEnum = StateContainer.of(context).koloboxFundEnum;
    return BlocListener<KoloFlexBloc, KoloFlexState>(
      listener: (_, state) {
        if (state is GroupInviteState) {
          Future.delayed(const Duration(milliseconds: 300), () {
            showCustomBottomSheet(const InviteFamilyMemberSuccessfullyWidget());
          });
        } else if (state is FamilyInviteState) {
          Future.delayed(const Duration(milliseconds: 300), () {
            showCustomBottomSheet(const InviteFamilyMemberSuccessfullyWidget());
          });
        }
      },
      child: Padding(
        padding:
            const EdgeInsets.only(top: 17, left: 28, right: 28, bottom: 31),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () {
                  goBack(context);
                },
                child: Image.asset(imageClose),
              ),
            ),
            Text(
              'Invitation summary',
              style:
                  AppStyle.b4Bold.copyWith(color: ColorList.blackSecondColor),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              'Tell a family member to join you on this target',
              style:
                  AppStyle.b9Regular.copyWith(color: ColorList.blackThirdColor),
            ),
            const SizedBox(
              height: 32,
            ),
            SizedBox(
              width: double.maxFinite,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      color: ColorList.lightBlue3Color,
                      shape: BoxShape.circle,
                    ),
                    padding: const EdgeInsets.all(10),
                    child: Image.asset(
                      imageUserPlaceHolder,
                      width: 68,
                      height: 68,
                    ),
                  ),
                  const SizedBox(
                    height: 27,
                  ),
                  Text(
                    'Invitation to',
                    style: AppStyle.b9Medium
                        .copyWith(color: ColorList.blackSecondColor),
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  Text(
                    widget.emailAddress,
                    style: AppStyle.b7Bold
                        .copyWith(color: ColorList.blackSecondColor),
                  ),
                  if (widget.koloboxFundEnum == KoloboxFundEnum.koloFamily) ...[
                    const SizedBox(
                      height: 27,
                    ),
                    Text(
                      'Relation',
                      style: AppStyle.b9Medium
                          .copyWith(color: ColorList.blackSecondColor),
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    Text(
                      widget.relation,
                      style: AppStyle.b7Bold
                          .copyWith(color: ColorList.blackSecondColor),
                    ),
                  ],
                  const SizedBox(
                    height: 38,
                  ),
                  // Text(
                  //   'Invitation Note',
                  //   style: AppStyle.b9SemiBold
                  //       .copyWith(color: ColorList.greyLight2Color),
                  // ),
                  // const SizedBox(
                  //   height: 8,
                  // ),
                  // Container(
                  //   width: double.maxFinite,
                  //   decoration: BoxDecoration(
                  //     border:
                  //         Border.all(color: ColorList.greyLight7Color, width: 1),
                  //     borderRadius: BorderRadius.circular(12),
                  //   ),
                  //   padding:
                  //       const EdgeInsets.symmetric(vertical: 20, horizontal: 14),
                  //   child: Text(
                  //     'Let us save toward it together using KoloBox',
                  //     style: AppStyle.b9Regular
                  //         .copyWith(color: ColorList.blackSecondColor),
                  //   ),
                  // ),
                ],
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Button(
              'Next',
              backgroundColor: ColorList.primaryColor,
              textColor: ColorList.white,
              overlayColor: ColorList.blueColor,
              borderRadius: 32,
              onPressed: () {
                if (widget.koloboxFundEnum == KoloboxFundEnum.koloGroup) {
                  BlocProvider.of<KoloFlexBloc>(context).add(GroupInviteEvent(
                      model: GroupInviteRequestModel(
                          groupId: widget.groupModel.groupId ?? '',
                          email: widget.emailAddress)));
                } else if (widget.koloboxFundEnum ==
                    KoloboxFundEnum.koloFamily) {
                  BlocProvider.of<KoloFlexBloc>(context).add(FamilyInviteEvent(
                      model: CreateFamilyUserRequestModel(
                    groupId: widget.groupModel.groupId ?? '',
                    firstName: widget.emailAddress,
                    relation: widget.relation,
                  )));
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  // Widget getOptionWidget() {
  //   return GestureDetector(
  //     onTap: () async {
  //       // switch (fundEnum) {
  //       //   case KoloboxFundEnum.koloFlex:
  //       //   case KoloboxFundEnum.koloTarget:
  //       //   case KoloboxFundEnum.koloFamily:
  //       //   case KoloboxFundEnum.koloGroup:
  //       //     showCustomBottomSheet(
  //       //         DepositYourKoloboxWidget(
  //       //           koloboxFundEnum: fundEnum,
  //       //         ),
  //       //         height: 0.9);
  //       //     break;
  //       //   case KoloboxFundEnum.koloTargetPlus:
  //       //     comingSoon();
  //       //     break;
  //       // }
  //     },
  //     child: Container(
  //       decoration: BoxDecoration(
  //         color: koloboxFundEnum.getFundBackColorValue,
  //         borderRadius: BorderRadius.circular(14),
  //       ),
  //       padding: const EdgeInsets.all(24),
  //       child: Row(
  //         children: [
  //           Expanded(
  //             child: Text(
  //               koloboxFundEnum.getFundValue,
  //               style: AppStyle.b3Bold
  //                   .copyWith(color: koloboxFundEnum.getFundTextColorValue),
  //             ),
  //           ),
  //           koloboxFundEnum.isPhotoEnabledAsIcon
  //               ? Icon(
  //                   koloboxFundEnum.getFundIconValue,
  //                   size: 48,
  //                   color:
  //                       koloboxFundEnum.getFundIconColorValue.withOpacity(0.4),
  //                 )
  //               : Image.asset(
  //                   koloboxFundEnum.getFundImageValue,
  //                   width: 48,
  //                   height: 48,
  //                 ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  @override
  void dispose() {
    super.dispose();
    // enableRecurringDepositStreamController.close();
  }
}
