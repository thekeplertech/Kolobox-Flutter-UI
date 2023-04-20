import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kolobox_new_app/core/base/base_bloc_widget.dart';
import 'package:kolobox_new_app/core/constants/image_constants.dart';
import 'package:kolobox_new_app/core/ui/style/app_style.dart';
import 'package:kolobox_new_app/core/utils/date_helper.dart';
import 'package:kolobox_new_app/feature/dashboard/data/models/update_profile_request_model.dart';
import 'package:kolobox_new_app/feature/widgets/edit_profile/bloc/edit_profile_bloc.dart';
import 'package:kolobox_new_app/feature/widgets/edit_profile/bloc/edit_profile_event.dart';
import 'package:kolobox_new_app/feature/widgets/edit_profile/bloc/edit_profile_state.dart';

import '../../../core/colors/color_list.dart';
import '../../../core/ui/widgets/button.dart';
import '../../../core/ui/widgets/custom_text_field.dart';
import '../../../routes/routes.dart';

class EditProfileWidget extends BaseBlocWidget {
  const EditProfileWidget({Key? key}) : super(key: key);

  @override
  State<EditProfileWidget> createState() => _EditProfileWidgetState();
}

class _EditProfileWidgetState extends BaseBlocWidgetState<EditProfileWidget> {
  final TextEditingController occupationTextEditingController =
      TextEditingController();

  StreamController<bool> dateOfBirthStreamController =
      StreamController<bool>.broadcast();

  DateTime? dateOfBirth;

  @override
  void initState() {
    super.initState();
    occupationTextEditingController.text =
        prefHelper?.getLoginResponseModel().occupation ?? '';
    dateOfBirth =
        DateHelper.getDateTime(prefHelper?.getLoginResponseModel().dob ?? '');

    print(prefHelper?.getLoginResponseModel().dob ?? '');

    print(dateOfBirth.toString());
    dateOfBirth = DateTime.parse(dateOfBirth.toString());
    print(dateOfBirth.toString());
  }

  @override
  Widget getCustomBloc() {
    return BlocListener<EditProfileBloc, EditProfileState>(
      listener: (_, state) {
        if (state is UpdateProfileState) {
          Future.delayed(const Duration(milliseconds: 300), () {
            goBack(context);
          });
        }
      },
      child: getChild(),
    );
  }

  Padding getChild() {
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
          StreamBuilder<bool>(
              stream: dateOfBirthStreamController.stream,
              builder: (context, snapshot) {
                return CustomTextField(
                  dateOfBirth == null
                      ? 'Select your date of birth'
                      : DateHelper.getTextFromDateTime(
                          dateOfBirth!, 'dd MMMM yyyy'),
                  postIcon: imageCalendar,
                  onPressed: () {
                    onClickDOB();
                  },
                );
              }),
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
            controller: occupationTextEditingController,
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
                    onClickUpdateProfile();
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  onClickUpdateProfile() {
    BlocProvider.of<EditProfileBloc>(context).add(UpdateProfileEvent(
        model: UpdateProfileRequestModel(
      firstname: prefHelper?.getLoginResponseModel().firstname ?? '',
      lastname: prefHelper?.getLoginResponseModel().lastname ?? '',
      email: prefHelper?.getLoginResponseModel().email ?? '',
      phone: prefHelper?.getLoginResponseModel().phone ?? '',
      nextOfKin: prefHelper?.getLoginResponseModel().nextOfKin ?? '',
      emailNotification:
          prefHelper?.getLoginResponseModel().emailNotification ?? false,
      smsNotification:
          prefHelper?.getLoginResponseModel().smsNotification ?? false,
      occupation: occupationTextEditingController.text,
      dob: DateHelper.getTextFromDateTime(dateOfBirth!, 'yyyy-MM-dd'),
    )));
    // goBack(context);
  }

  Future<void> onClickDOB() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1990, 1),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      dateOfBirth = picked;
      dateOfBirthStreamController.add(true);
    }
  }

  @override
  void dispose() {
    super.dispose();
    occupationTextEditingController.dispose();
    dateOfBirthStreamController.close();
  }
}
