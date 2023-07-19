import 'package:flutter/material.dart';
import 'package:kolobox_new_app/core/base/base_screen.dart';
import 'package:kolobox_new_app/core/constants/image_constants.dart';
import 'package:kolobox_new_app/core/enums/kolobox_fund_enum.dart';
import 'package:kolobox_new_app/core/ui/style/app_style.dart';
import 'package:kolobox_new_app/feature/dashboard/data/models/get_group_list_response_model.dart';
import 'package:kolobox_new_app/feature/widgets/invite_user/invite_family_member_summary_page.dart';
import 'package:kolobox_new_app/routes/routes.dart';

import '../../../core/colors/color_list.dart';
import '../../../core/ui/widgets/button.dart';
import '../../../core/ui/widgets/custom_text_field.dart';
import '../../../core/ui/widgets/toast_widget.dart';
import '../../../core/utils/utils.dart';

class InviteFamilyMemberWidget extends BaseScreen {
  final GroupModel? groupModel;
  final KoloboxFundEnum koloboxFundEnum;

  const InviteFamilyMemberWidget({
    Key? key,
    required this.groupModel,
    required this.koloboxFundEnum,
  }) : super(key: key);

  @override
  State<InviteFamilyMemberWidget> createState() =>
      _InviteFamilyMemberWidgetState();
}

class _InviteFamilyMemberWidgetState
    extends BaseScreenState<InviteFamilyMemberWidget> {
  TextEditingController emailAddressTextEditingController =
      TextEditingController();
  TextEditingController relationTextEditingController = TextEditingController();

  // StreamController<bool> enableRecurringDepositStreamController =
  //     StreamController<bool>.broadcast();
  // bool isEnableRecurringDeposit = false;

  // KoloboxFundEnum koloboxFundEnum = KoloboxFundEnum.koloFlex;

  @override
  Widget body(BuildContext context) {
    // koloboxFundEnum = StateContainer.of(context).koloboxFundEnum;
    return Padding(
      padding: const EdgeInsets.only(top: 17, left: 28, right: 28, bottom: 31),
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
            'Invite a family member',
            style: AppStyle.b4Bold.copyWith(color: ColorList.blackSecondColor),
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
            height: 20,
          ),
          Text(
            'Invitation email',
            style: TextStyle(
              color: ColorList.blackSecondColor,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(
            height: 7,
          ),
          CustomTextField(
            'Enter user email to invite',
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.done,
            controller: emailAddressTextEditingController,
          ),
          if (widget.koloboxFundEnum == KoloboxFundEnum.koloFamily) ...[
            const SizedBox(
              height: 20,
            ),
            Text(
              'Relation',
              style: TextStyle(
                color: ColorList.blackSecondColor,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              height: 7,
            ),
            CustomTextField(
              'Enter user\'s relation',
              keyboardType: TextInputType.name,
              textInputAction: TextInputAction.done,
              controller: relationTextEditingController,
            ),
          ],
          // const SizedBox(
          //   height: 15,
          // ),
          // Text(
          //   'Invitation note',
          //   style: TextStyle(
          //     color: ColorList.blackSecondColor,
          //     fontSize: 12,
          //     fontWeight: FontWeight.w500,
          //   ),
          // ),
          // const SizedBox(
          //   height: 7,
          // ),
          // const CustomTextField(
          //   'Let us save toward it together using KoloBox',
          //   keyboardType: TextInputType.text,
          //   textCapitalization: TextCapitalization.sentences,
          //   textInputAction: TextInputAction.done,
          //   maxLines: 3,
          //   // controller: emailTextEditingController,
          // ),
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
              hideKeyboard();
              if (emailAddressTextEditingController.text.isEmpty) {
                Utils.showToast(
                    context,
                    ToastWidget(
                      'Enter email address',
                      borderColor: ColorList.redDarkColor,
                      backgroundColor: ColorList.white,
                      textColor: ColorList.black,
                      messageIcon: imageCloseRed,
                      closeWidget: Image.asset(
                        imageClose,
                        color: ColorList.black,
                      ),
                    ));
                return;
              }
              if (!Utils.emailValid(emailAddressTextEditingController.text)) {
                Utils.showToast(
                    context,
                    ToastWidget(
                      'Enter valid email address',
                      borderColor: ColorList.redDarkColor,
                      backgroundColor: ColorList.white,
                      textColor: ColorList.black,
                      messageIcon: imageCloseRed,
                      closeWidget: Image.asset(
                        imageClose,
                        color: ColorList.black,
                      ),
                    ));
                return;
              }
              if (widget.koloboxFundEnum == KoloboxFundEnum.koloFamily) {
                if (relationTextEditingController.text.isEmpty) {
                  Utils.showToast(
                      context,
                      ToastWidget(
                        'Enter relation',
                        borderColor: ColorList.redDarkColor,
                        backgroundColor: ColorList.white,
                        textColor: ColorList.black,
                        messageIcon: imageCloseRed,
                        closeWidget: Image.asset(
                          imageClose,
                          color: ColorList.black,
                        ),
                      ));
                  return;
                }
              }
              if (widget.groupModel == null) return;
              showCustomBottomSheet(InviteFamilyMemberSummaryWidgetPage(
                emailAddress: emailAddressTextEditingController.text,
                groupModel: widget.groupModel!,
                koloboxFundEnum: widget.koloboxFundEnum,
                relation: relationTextEditingController.text,
              ));
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    emailAddressTextEditingController.dispose();
    // enableRecurringDepositStreamController.close();
  }
}
