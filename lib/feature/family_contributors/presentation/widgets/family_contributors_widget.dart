import 'package:flutter/material.dart';
import 'package:kolobox_new_app/core/colors/color_list.dart';
import 'package:kolobox_new_app/core/constants/image_constants.dart';
import 'package:kolobox_new_app/core/ui/style/app_style.dart';
import 'package:kolobox_new_app/feature/dashboard/data/models/group_users_data_model.dart';

import '../../../../core/enums/kolobox_fund_enum.dart';
import '../../../../core/ui/widgets/currency_text_input_formatter.dart';
import '../../../dashboard/data/models/get_family_user_list_response_model.dart';

class FamilyContributorsWidget extends StatelessWidget {
  final GroupUsers? groupUser;
  final FamilyUserModel? familyUserModel;
  final KoloboxFundEnum koloboxFundEnum;

  const FamilyContributorsWidget({
    Key? key,
    this.groupUser,
    this.familyUserModel,
    required this.koloboxFundEnum,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: ColorList.greyLight6Color, width: 1),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: const BoxDecoration(
              color: ColorList.lightBlue3Color,
              shape: BoxShape.circle,
            ),
            padding: const EdgeInsets.all(5),
            child: Image.asset(
              imageUserIcon,
              width: 25,
              height: 25,
            ),
          ),
          if (koloboxFundEnum == KoloboxFundEnum.koloFamily) ...[
            const SizedBox(
              height: 4,
            ),
            Text(
              familyUserModel?.relation ?? '',
              style: AppStyle.b10Medium
                  .copyWith(color: ColorList.greyLight12Color),
            ),
          ],
          const SizedBox(
            height: 6,
          ),
          Text(
            '@${groupUser?.userName ?? familyUserModel?.firstname}',
            style: AppStyle.b10Medium.copyWith(color: ColorList.primaryColor),
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            groupUser != null
                ? CurrencyTextInputFormatter.formatAmount(
                    groupUser?.groupDeposit?.toString())
                : CurrencyTextInputFormatter.formatAmount(
                    familyUserModel?.groupDeposit?.toString()),
            style: AppStyle.b9Bold.copyWith(color: ColorList.primaryColor),
          ),
        ],
      ),
    );
  }
}
