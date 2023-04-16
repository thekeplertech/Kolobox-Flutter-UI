import 'package:flutter/material.dart';
import 'package:kolobox_new_app/core/base/base_screen.dart';
import 'package:kolobox_new_app/core/constants/image_constants.dart';
import 'package:kolobox_new_app/core/ui/style/app_style.dart';

import '../../../core/colors/color_list.dart';
import '../../../core/ui/widgets/button.dart';
import '../../../core/ui/widgets/custom_text_field.dart';
import '../../../routes/routes.dart';

class EditProfileWidget extends BaseScreen {
  const EditProfileWidget({Key? key}) : super(key: key);

  @override
  State<EditProfileWidget> createState() => _EditProfileWidgetState();
}

class _EditProfileWidgetState extends BaseScreenState<EditProfileWidget> {
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
                  'Edit Profile',
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
          Center(
            child: Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: ColorList.lightBlue3Color,
              ),
              padding: const EdgeInsets.all(15),
              child: Image.asset(
                imageUserPlaceHolder,
                width: 68,
                height: 68,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Center(
            child: SizedBox(
              width: 158,
              child: Button(
                'Upload Image',
                backgroundColor: ColorList.lightBlue3Color,
                textColor: ColorList.primaryColor,
                overlayColor: ColorList.primaryColor,
                borderRadius: 32,
                onPressed: () {
                  goBack(context);
                },
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            'Date Of Birth',
            style:
                AppStyle.b9Medium.copyWith(color: ColorList.blackSecondColor),
          ),
          const SizedBox(
            height: 7,
          ),
          CustomTextField(
            'Select your date of birth',
            postIcon: imageCalendar,
            onPressed: () {},
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            'Occupation',
            style:
                AppStyle.b9Medium.copyWith(color: ColorList.blackSecondColor),
          ),
          const SizedBox(
            height: 7,
          ),
          CustomTextField(
            'Enter your occupation',
            keyboardType: TextInputType.name,
            textInputAction: TextInputAction.done,
            textCapitalization: TextCapitalization.words,
          ),
          const SizedBox(
            height: 35,
          ),
          Row(
            children: [
              Expanded(
                child: Button(
                  'Discard',
                  backgroundColor: ColorList.lightRed2Color,
                  textColor: ColorList.redDarkColor,
                  overlayColor: ColorList.redDarkColor,
                  borderRadius: 32,
                  onPressed: () {
                    comingSoon();
                  },
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              Expanded(
                child: Button(
                  'Yes',
                  backgroundColor: ColorList.primaryColor,
                  textColor: ColorList.white,
                  overlayColor: ColorList.blueColor,
                  borderRadius: 32,
                  onPressed: () {
                    goBack(context);
                  },
                ),
              ),
            ],
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
