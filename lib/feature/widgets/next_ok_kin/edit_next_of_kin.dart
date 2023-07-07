import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
import '../../../core/ui/widgets/toast_widget.dart';
import '../../../core/utils/utils.dart';
import '../../../routes/routes.dart';

class EditNextOfKinWidget extends BaseBlocWidget {
  const EditNextOfKinWidget({Key? key}) : super(key: key);

  @override
  State<EditNextOfKinWidget> createState() => _EditNextOfKinWidgetState();
}

class _EditNextOfKinWidgetState
    extends BaseBlocWidgetState<EditNextOfKinWidget> {
  final TextEditingController firstNameTextEditingController =
      TextEditingController();
  final TextEditingController lastNameTextEditingController =
      TextEditingController();
  final TextEditingController nextOfKinTextEditingController =
      TextEditingController();
  final TextEditingController phoneTextEditingController =
      TextEditingController();
  final TextEditingController occupationTextEditingController =
      TextEditingController();

  StreamController<bool> dateOfBirthStreamController =
      StreamController<bool>.broadcast();

  DateTime? dateOfBirth;

  @override
  void initState() {
    super.initState();
    firstNameTextEditingController.text =
        prefHelper?.getLoginResponseModel().firstname ?? '';
    lastNameTextEditingController.text =
        prefHelper?.getLoginResponseModel().lastname ?? '';
    nextOfKinTextEditingController.text =
        prefHelper?.getLoginResponseModel().nextOfKin ?? '';
    phoneTextEditingController.text =
        prefHelper?.getLoginResponseModel().phone ?? '';
    occupationTextEditingController.text =
        prefHelper?.getLoginResponseModel().occupation ?? '';
    dateOfBirth =
        DateHelper.getDateTime(prefHelper?.getLoginResponseModel().dob ?? '');
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
          Text(
            'First Name',
            style:
                AppStyle.b9Medium.copyWith(color: ColorList.blackSecondColor),
          ),
          const SizedBox(
            height: 7,
          ),
          CustomTextField(
            'Enter first name',
            keyboardType: TextInputType.name,
            textInputAction: TextInputAction.done,
            textCapitalization: TextCapitalization.words,
            controller: firstNameTextEditingController,
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            'Last Name',
            style:
                AppStyle.b9Medium.copyWith(color: ColorList.blackSecondColor),
          ),
          const SizedBox(
            height: 7,
          ),
          CustomTextField(
            'Enter last name',
            keyboardType: TextInputType.name,
            textInputAction: TextInputAction.done,
            textCapitalization: TextCapitalization.words,
            controller: lastNameTextEditingController,
          ),
          const SizedBox(
            height: 15,
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
            'Next of Kin',
            style:
                AppStyle.b9Medium.copyWith(color: ColorList.blackSecondColor),
          ),
          const SizedBox(
            height: 7,
          ),
          CustomTextField(
            'Enter next of kin',
            controller: nextOfKinTextEditingController,
            keyboardType: TextInputType.name,
            textInputAction: TextInputAction.done,
            textCapitalization: TextCapitalization.words,
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            'Phone Number',
            style:
                AppStyle.b9Medium.copyWith(color: ColorList.blackSecondColor),
          ),
          const SizedBox(
            height: 7,
          ),
          CustomTextField(
            'Enter phone number',
            controller: phoneTextEditingController,
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.next,
            textCapitalization: TextCapitalization.none,
            inputFormatter: [FilteringTextInputFormatter.digitsOnly],
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
                    goBack(context);
                  },
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              Expanded(
                child: Button(
                  'Save',
                  backgroundColor: ColorList.primaryColor,
                  textColor: ColorList.white,
                  overlayColor: ColorList.blueColor,
                  borderRadius: 32,
                  onPressed: () {
                    hideKeyboard();
                    onClickUpdateNextOfKin();
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  onClickUpdateNextOfKin() {
    if (firstNameTextEditingController.text.isEmpty) {
      Utils.showToast(
          context,
          ToastWidget(
            'Enter first name',
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
    if (lastNameTextEditingController.text.isEmpty) {
      Utils.showToast(
          context,
          ToastWidget(
            'Enter last name',
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
    if (dateOfBirth == null) {
      Utils.showToast(
          context,
          ToastWidget(
            'Select date of birth',
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
    if (nextOfKinTextEditingController.text.isEmpty) {
      Utils.showToast(
          context,
          ToastWidget(
            'Enter next of kin',
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
    if (phoneTextEditingController.text.isEmpty) {
      Utils.showToast(
          context,
          ToastWidget(
            'Enter phone number',
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
    if (phoneTextEditingController.text.length != 11) {
      Utils.showToast(
          context,
          ToastWidget(
            'Enter valid phone number',
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
    if (occupationTextEditingController.text.isEmpty) {
      Utils.showToast(
          context,
          ToastWidget(
            'Enter occupation',
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

    BlocProvider.of<EditProfileBloc>(context).add(UpdateProfileEvent(
        model: UpdateProfileRequestModel(
      firstname: firstNameTextEditingController.text,
      lastname: lastNameTextEditingController.text,
      email: prefHelper?.getLoginResponseModel().email ?? '',
      phone: phoneTextEditingController.text,
      nextOfKin: nextOfKinTextEditingController.text,
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
    firstNameTextEditingController.dispose();
    lastNameTextEditingController.dispose();
    nextOfKinTextEditingController.dispose();
    phoneTextEditingController.dispose();
    occupationTextEditingController.dispose();
    dateOfBirthStreamController.close();
  }
}
