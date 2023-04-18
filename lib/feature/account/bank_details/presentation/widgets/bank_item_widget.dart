import 'package:flutter/material.dart';
import 'package:kolobox_new_app/core/base/base_screen.dart';

import '../../../../../core/colors/color_list.dart';
import '../../../../../core/constants/image_constants.dart';
import '../../../../../core/ui/style/app_style.dart';
import '../../../../dashboard/data/models/get_all_my_banks_response_model.dart';

class BankItemWidget extends BaseScreen {
  final MyBankData myBankData;

  const BankItemWidget({
    Key? key,
    required this.myBankData,
  }) : super(key: key);

  @override
  State<BankItemWidget> createState() => _BankItemWidgetState();
}

class _BankItemWidgetState extends BaseScreenState<BankItemWidget> {
  @override
  Widget body(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: ColorList.primaryColor,
          borderRadius: BorderRadius.circular(14)),
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    top: 20, bottom: 20, left: 16, right: 10),
                child: Image.asset(
                  imageBankDetailsIcon,
                  color: ColorList.white,
                  height: 24,
                  width: 24,
                ),
              ),
              Expanded(
                child: Text(
                  widget.myBankData.bankName ?? '',
                  style: AppStyle.b7Medium.copyWith(color: ColorList.white),
                ),
              ),
              GestureDetector(
                onTap: () => comingSoon(),
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 20, bottom: 20, left: 16, right: 8),
                  child: Image.asset(
                    deleteIcon,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => comingSoon(),
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 20, bottom: 20, left: 8, right: 16),
                  child: Image.asset(
                    editIcon,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.myBankData.accountNumber ?? '',
                        style:
                            AppStyle.b7Medium.copyWith(color: ColorList.white),
                      ),
                      Text(
                        widget.myBankData.accountName ?? '',
                        style:
                            AppStyle.b7Medium.copyWith(color: ColorList.white),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => comingSoon(),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                  child: Image.asset(
                    copyIcon,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
