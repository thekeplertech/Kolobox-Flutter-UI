import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kolobox_new_app/core/base/base_screen.dart';
import 'package:kolobox_new_app/core/constants/image_constants.dart';
import 'package:kolobox_new_app/core/ui/style/app_style.dart';

import '../../../core/colors/color_list.dart';
import '../../../core/constants/kolo_box_icon.dart';
import '../../../core/ui/widgets/button.dart';
import '../../../core/ui/widgets/custom_text_field.dart';
import '../../../routes/routes.dart';

class AddBankDetailsWidget extends BaseScreen {
  const AddBankDetailsWidget({Key? key}) : super(key: key);

  @override
  State<AddBankDetailsWidget> createState() => _AddBankDetailsWidgetState();
}

class _AddBankDetailsWidgetState extends BaseScreenState<AddBankDetailsWidget> {
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
                  'Add Bank Account',
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
            'Select Bank',
            style:
                AppStyle.b9Medium.copyWith(color: ColorList.blackSecondColor),
          ),
          const SizedBox(
            height: 7,
          ),
          CustomTextField(
            'Select a bank',
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.next,
            textCapitalization: TextCapitalization.none,
            onPressed: () {},
            iconData: KoloBoxIcons.dropDownArrow,
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            'Personal Bank Account Number',
            style:
                AppStyle.b9Medium.copyWith(color: ColorList.blackSecondColor),
          ),
          const SizedBox(
            height: 7,
          ),
          CustomTextField(
            'Enter your personal bank account number',
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.next,
            textCapitalization: TextCapitalization.none,
            inputFormatter: [FilteringTextInputFormatter.digitsOnly],
            // controller: nameTextEditingController,
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            'Account Name',
            style:
                AppStyle.b9Medium.copyWith(color: ColorList.blackSecondColor),
          ),
          const SizedBox(
            height: 7,
          ),
          CustomTextField(
            'Enter your account name',
            keyboardType: TextInputType.name,
            textInputAction: TextInputAction.done,
            textCapitalization: TextCapitalization.words,
            // controller: nameTextEditingController,
          ),
          const SizedBox(
            height: 40,
          ),
          Button(
            'Save',
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
