import 'package:flutter/material.dart';
import 'package:kolobox_new_app/core/base/base_screen.dart';
import 'package:kolobox_new_app/core/constants/image_constants.dart';
import 'package:kolobox_new_app/core/ui/style/app_style.dart';

import '../../../core/colors/color_list.dart';
import '../../../core/ui/widgets/button.dart';
import '../../../routes/routes.dart';

class DeleteBankDetailsWidget extends BaseScreen {
  const DeleteBankDetailsWidget({Key? key}) : super(key: key);

  @override
  State<DeleteBankDetailsWidget> createState() =>
      _DeleteBankDetailsWidgetState();
}

class _DeleteBankDetailsWidgetState
    extends BaseScreenState<DeleteBankDetailsWidget> {
  @override
  Widget body(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 17, left: 28, right: 28, bottom: 31),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Delete Bank Details',
                  style: AppStyle.b4Bold
                      .copyWith(color: ColorList.blackSecondColor),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    goBack(context);
                  },
                  child: Image.asset(imageClose),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          Text(
            'You are about to delete your bank details below, Do you want to proceed with the action?',
            style:
                AppStyle.b9Medium.copyWith(color: ColorList.blackSecondColor),
          ),
          const SizedBox(
            height: 25,
          ),
          Text(
            'Bank',
            style:
                AppStyle.b9Medium.copyWith(color: ColorList.blackSecondColor),
          ),
          const SizedBox(
            height: 3,
          ),
          Text(
            'Access Bank Pls',
            style: AppStyle.b7Bold.copyWith(color: ColorList.blackSecondColor),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            'Account Number',
            style:
                AppStyle.b9Medium.copyWith(color: ColorList.blackSecondColor),
          ),
          const SizedBox(
            height: 3,
          ),
          Text(
            '09302841100',
            style: AppStyle.b7Bold.copyWith(color: ColorList.blackSecondColor),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            'Account Name',
            style:
                AppStyle.b9Medium.copyWith(color: ColorList.blackSecondColor),
          ),
          const SizedBox(
            height: 3,
          ),
          Text(
            'Dami Anoreq',
            style: AppStyle.b7Bold.copyWith(color: ColorList.blackSecondColor),
          ),
          const SizedBox(
            height: 35,
          ),
          Button(
            'Yes',
            backgroundColor: ColorList.primaryColor,
            textColor: ColorList.white,
            overlayColor: ColorList.blueColor,
            borderRadius: 32,
            onPressed: () {
              goBack(context);
              // BlocProvider.of<DashboardBloc>(context).add(
              //   ClearBackStackEvent(
              //     until: StateContainer.of(context).isFromFundMyKoloBox
              //         ? '/'
              //         : StateContainer.of(context)
              //             .koloboxFundEnum
              //             .getFundPageValue(
              //                 StateContainer.of(context).isFromDetail),
              //   ),
              // );
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
