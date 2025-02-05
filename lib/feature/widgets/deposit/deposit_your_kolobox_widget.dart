import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kolobox_new_app/core/constants/app_constants.dart';
import 'package:kolobox_new_app/core/constants/image_constants.dart';
import 'package:kolobox_new_app/core/constants/kolo_box_icon.dart';
import 'package:kolobox_new_app/core/enums/kolobox_fund_enum.dart';
import 'package:kolobox_new_app/core/ui/style/app_style.dart';
import 'package:kolobox_new_app/core/ui/widgets/button.dart';
import 'package:kolobox_new_app/core/ui/widgets/currency_text_input_formatter.dart';
import 'package:kolobox_new_app/feature/widgets/confirm_pin_and_pay/bloc/confirm_pin_and_pay_event.dart';
import 'package:kolobox_new_app/feature/widgets/deposit/deposit_summary_widget_page.dart';
import 'package:kolobox_new_app/feature/widgets/inherited_state_container.dart';
import 'package:kolobox_new_app/feature/widgets/product_item_widget.dart';
import 'package:kolobox_new_app/routes/routes.dart';

import '../../../../../core/colors/color_list.dart';
import '../../../core/base/base_bloc_widget.dart';
import '../../../core/enums/period_enum.dart';
import '../../../core/ui/widgets/custom_text_field.dart';
import '../../../core/ui/widgets/toast_widget.dart';
import '../../../core/utils/date_helper.dart';
import '../../../core/utils/utils.dart';
import '../../dashboard/data/models/get_family_user_list_response_model.dart';
import '../../dashboard/data/models/get_family_user_request_model.dart';
import '../../dashboard/data/models/get_group_list_response_model.dart';
import '../../dashboard/data/models/get_group_tenor_response_model.dart';
import '../confirm_pin_and_pay/bloc/confirm_pin_and_pay_bloc.dart';
import '../confirm_pin_and_pay/bloc/confirm_pin_and_pay_state.dart';
import '../recurring_deposit/select_recurring_period_widget.dart';
import '../select_group/select_family_user_widget.dart';
import '../select_group/select_family_widget.dart';
import '../select_group/select_group_widget.dart';
import '../select_tenor/select_tenor_widget.dart';

class DepositYourKoloboxWidget extends BaseBlocWidget {
  final bool isCreateGroup;

  const DepositYourKoloboxWidget({
    Key? key,
    required this.isCreateGroup,
  }) : super(key: key);

  @override
  State<DepositYourKoloboxWidget> createState() =>
      _DepositYourKoloboxWidgetState();
}

class _DepositYourKoloboxWidgetState
    extends BaseBlocWidgetState<DepositYourKoloboxWidget> {
  TextEditingController targetNameTextEditingController =
      TextEditingController();
  TextEditingController amountTextEditingController = TextEditingController();
  TextEditingController saveAmountTextEditingController =
      TextEditingController();

  StreamController<PeriodEnum> periodStreamController =
      StreamController<PeriodEnum>.broadcast();
  StreamController<bool> tenorStreamController =
      StreamController<bool>.broadcast();
  PeriodEnum selectedPeriodEnum = PeriodEnum.monthly;

  StreamController<bool> targetDateStreamController =
      StreamController<bool>.broadcast();
  DateTime? targetDateTime;

  StreamController<bool> groupStreamController =
      StreamController<bool>.broadcast();
  StreamController<bool> familyUsersStreamController =
      StreamController<bool>.broadcast();

  List<GroupTenorModel> tenors = [];
  List<GroupModel> groups = [];
  List<GroupModel> families = [];
  List<FamilyUserModel> familyUsers = [];
  GroupTenorModel? selectedTenorModel;
  GroupModel? selectedGroupModel;
  GroupModel? selectedFamilyModel;
  FamilyUserModel? selectedFamilyUserModel;

  KoloboxFundEnum? koloboxFundEnum;
  bool isInActive = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    koloboxFundEnum = StateContainer.of(context).getKoloBoxEnum();
    isInActive = koloboxFundEnum?.isInActiveProduct() ?? false;
  }

  @override
  Widget getCustomBloc() =>
      BlocListener<ConfirmPinAndPayBloc, ConfirmPinAndPayState>(
        listener: (_, state) {
          if (state is GetTenorState) {
            tenors = state.model.tenors ?? [];
            Future.delayed(const Duration(milliseconds: 200), () {
              showTenorDialog();
            });
          }
          if (state is GetGroupState) {
            groups = state.model.types ?? [];
            Future.delayed(const Duration(milliseconds: 200), () {
              showGroupDialog();
            });
          }
          if (state is GetFamilyState) {
            families = state.model.types ?? [];
            Future.delayed(const Duration(milliseconds: 200), () {
              showFamilyDialog();
            });
          }
          if (state is GetFamilyUsersState) {
            familyUsers = state.model.users ?? [];
            Future.delayed(const Duration(milliseconds: 200), () {
              showFamilyUserDialog();
            });
          }
        },
        child: getChild(),
      );

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
                  getDepositTitle(),
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
            height: 5,
          ),
          Text(
            getDepositMessage(),
            style:
                AppStyle.b8Regular.copyWith(color: ColorList.blackThirdColor),
          ),
          const SizedBox(
            height: 13,
          ),
          if (StateContainer.of(context).isFundYourKoloBox()) ...[
            Button(
              'Edit',
              backgroundColor: ColorList.lightBlue3Color,
              textColor: ColorList.primaryColor,
              overlayColor: ColorList.blueColor,
              borderRadius: 32,
              onPressed: () => goBack(context),
            ),
            const SizedBox(
              height: 12,
            ),
          ],
          if (isKoloFlex()) ...[
            getOptionWidget(),
            const SizedBox(
              height: 15,
            ),
            Text(
              'Enter Amount',
              style:
                  AppStyle.b8Regular.copyWith(color: ColorList.blackThirdColor),
            ),
            const SizedBox(
              height: 7,
            ),
            CustomTextField(
              '₦ 0.00',
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.done,
              textCapitalization: TextCapitalization.none,
              inputFormatter: [
                CurrencyTextInputFormatter(
                  name: '₦ ',
                )
              ],
              textStyle:
                  AppStyle.b3Bold.copyWith(color: ColorList.primaryColor),
              hintStyle:
                  AppStyle.b3Bold.copyWith(color: ColorList.primaryColor),
              textAlign: TextAlign.center,
              contentPadding: const EdgeInsets.symmetric(vertical: 25),
              controller: amountTextEditingController,
            ),
            const SizedBox(
              height: 15,
            ),
          ] else if (isKoloTarget()) ...[
            if (isInActive) ...[
              getOptionWidget(),
              const SizedBox(
                height: 15,
              ),
              Text(
                'Enter Amount',
                style: AppStyle.b8Regular
                    .copyWith(color: ColorList.blackThirdColor),
              ),
              const SizedBox(
                height: 7,
              ),
              CustomTextField(
                '₦ 0.00',
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.done,
                textCapitalization: TextCapitalization.none,
                inputFormatter: [
                  CurrencyTextInputFormatter(
                    name: '₦ ',
                  )
                ],
                textStyle:
                    AppStyle.b3Bold.copyWith(color: ColorList.primaryColor),
                hintStyle:
                    AppStyle.b3Bold.copyWith(color: ColorList.primaryColor),
                textAlign: TextAlign.center,
                contentPadding: const EdgeInsets.symmetric(vertical: 25),
                controller: amountTextEditingController,
              ),
              const SizedBox(
                height: 15,
              ),
            ] else ...[
              Text(
                'Name your target',
                style: AppStyle.b8Regular
                    .copyWith(color: ColorList.blackSecondColor),
              ),
              const SizedBox(
                height: 7,
              ),
              CustomTextField(
                'Enter your target name',
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.next,
                textCapitalization: TextCapitalization.words,
                controller: targetNameTextEditingController,
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                'Target Amount',
                style: AppStyle.b8Regular
                    .copyWith(color: ColorList.blackThirdColor),
              ),
              const SizedBox(
                height: 7,
              ),
              CustomTextField(
                '₦ 0.00',
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.done,
                textCapitalization: TextCapitalization.none,
                inputFormatter: [
                  CurrencyTextInputFormatter(
                    name: '₦ ',
                  )
                ],
                textStyle:
                    AppStyle.b3Bold.copyWith(color: ColorList.primaryColor),
                hintStyle:
                    AppStyle.b3Bold.copyWith(color: ColorList.primaryColor),
                textAlign: TextAlign.center,
                contentPadding: const EdgeInsets.symmetric(vertical: 25),
                controller: amountTextEditingController,
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                'Target date (Target date equals end date)',
                style: AppStyle.b9Medium
                    .copyWith(color: ColorList.blackSecondColor),
              ),
              const SizedBox(
                height: 7,
              ),
              StreamBuilder<bool>(
                  stream: targetDateStreamController.stream,
                  builder: (context, snapshot) {
                    return CustomTextField(
                      targetDateTime == null
                          ? 'Select date'
                          : DateHelper.getTextFromDateTime(
                              targetDateTime!, 'dd MMMM yyyy'),
                      postIcon: imageCalendar,
                      onPressed: () {
                        onClickTargetDate();
                      },
                    );
                  }),
              const SizedBox(
                height: 15,
              ),
              Text(
                'How much you plan to save now',
                style: AppStyle.b9Medium
                    .copyWith(color: ColorList.blackSecondColor),
              ),
              const SizedBox(
                height: 7,
              ),
              CustomTextField(
                '₦ 0.00',
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.done,
                textCapitalization: TextCapitalization.none,
                inputFormatter: [
                  CurrencyTextInputFormatter(
                    name: '₦ ',
                  )
                ],
                textStyle:
                    AppStyle.b3Bold.copyWith(color: ColorList.blackSecondColor),
                hintStyle:
                    AppStyle.b3Bold.copyWith(color: ColorList.blackSecondColor),
                textAlign: TextAlign.center,
                contentPadding: const EdgeInsets.symmetric(vertical: 25),
                controller: saveAmountTextEditingController,
              ),
              const SizedBox(
                height: 15,
              ),
            ],
          ] else if (isKoloGroup()) ...[
            if (isInActive && !widget.isCreateGroup) ...[
              getOptionWidget(),
              const SizedBox(
                height: 15,
              ),
              Text(
                'Select group',
                style: AppStyle.b8Medium
                    .copyWith(color: ColorList.blackSecondColor),
              ),
              const SizedBox(
                height: 7,
              ),
              StreamBuilder<bool>(
                  stream: groupStreamController.stream,
                  builder: (context, snapshot) {
                    return CustomTextField(
                      selectedGroupModel?.name ?? 'Select group',
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                      textCapitalization: TextCapitalization.words,
                      onPressed: () {
                        hideKeyboard();
                        if (groups.isNotEmpty) {
                          showGroupDialog();
                        } else {
                          BlocProvider.of<ConfirmPinAndPayBloc>(context)
                              .add(GetGroupEvent());
                        }
                      },
                      iconData: KoloBoxIcons.dropDownArrow,
                    );
                  }),
              const SizedBox(
                height: 15,
              ),
              Text(
                'Enter Amount',
                style: AppStyle.b8Regular
                    .copyWith(color: ColorList.blackThirdColor),
              ),
              const SizedBox(
                height: 7,
              ),
              CustomTextField(
                '₦ 0.00',
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.done,
                textCapitalization: TextCapitalization.none,
                inputFormatter: [
                  CurrencyTextInputFormatter(
                    name: '₦ ',
                  )
                ],
                textStyle:
                    AppStyle.b3Bold.copyWith(color: ColorList.primaryColor),
                hintStyle:
                    AppStyle.b3Bold.copyWith(color: ColorList.primaryColor),
                textAlign: TextAlign.center,
                contentPadding: const EdgeInsets.symmetric(vertical: 25),
                controller: saveAmountTextEditingController,
              ),
              const SizedBox(
                height: 15,
              ),
            ] else ...[
              Text(
                'Name your target',
                style: AppStyle.b8Regular
                    .copyWith(color: ColorList.blackSecondColor),
              ),
              const SizedBox(
                height: 7,
              ),
              CustomTextField(
                'Enter your target name',
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.next,
                textCapitalization: TextCapitalization.words,
                controller: targetNameTextEditingController,
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                'Target Amount',
                style: AppStyle.b8Regular
                    .copyWith(color: ColorList.blackThirdColor),
              ),
              const SizedBox(
                height: 7,
              ),
              CustomTextField(
                '₦ 0.00',
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.done,
                textCapitalization: TextCapitalization.none,
                inputFormatter: [
                  CurrencyTextInputFormatter(
                    name: '₦ ',
                  )
                ],
                textStyle:
                    AppStyle.b3Bold.copyWith(color: ColorList.primaryColor),
                hintStyle:
                    AppStyle.b3Bold.copyWith(color: ColorList.primaryColor),
                textAlign: TextAlign.center,
                contentPadding: const EdgeInsets.symmetric(vertical: 25),
                controller: amountTextEditingController,
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                'Select tenor',
                style: AppStyle.b8Medium
                    .copyWith(color: ColorList.blackSecondColor),
              ),
              const SizedBox(
                height: 7,
              ),
              StreamBuilder<bool>(
                  stream: tenorStreamController.stream,
                  builder: (context, snapshot) {
                    return CustomTextField(
                      selectedTenorModel?.tenor ?? 'Select Tenor',
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                      textCapitalization: TextCapitalization.words,
                      onPressed: () {
                        hideKeyboard();
                        if (tenors.isNotEmpty) {
                          showTenorDialog();
                        } else {
                          BlocProvider.of<ConfirmPinAndPayBloc>(context)
                              .add(GetTenorEvent());
                        }
                      },
                      iconData: KoloBoxIcons.dropDownArrow,
                    );
                  }),
              const SizedBox(
                height: 15,
              ),
              Text(
                'How much you plan to save now',
                style: AppStyle.b9Medium
                    .copyWith(color: ColorList.blackSecondColor),
              ),
              const SizedBox(
                height: 7,
              ),
              CustomTextField(
                '₦ 0.00',
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.done,
                textCapitalization: TextCapitalization.none,
                inputFormatter: [
                  CurrencyTextInputFormatter(
                    name: '₦ ',
                  )
                ],
                textStyle:
                    AppStyle.b3Bold.copyWith(color: ColorList.blackSecondColor),
                hintStyle:
                    AppStyle.b3Bold.copyWith(color: ColorList.blackSecondColor),
                textAlign: TextAlign.center,
                contentPadding: const EdgeInsets.symmetric(vertical: 25),
                controller: saveAmountTextEditingController,
              ),
              const SizedBox(
                height: 15,
              ),
            ],
          ] else if (isKoloFamily()) ...[
            if (isInActive && !widget.isCreateGroup) ...[
              getOptionWidget(),
              const SizedBox(
                height: 15,
              ),
              Text(
                'Select Family',
                style: AppStyle.b8Medium
                    .copyWith(color: ColorList.blackSecondColor),
              ),
              const SizedBox(
                height: 7,
              ),
              StreamBuilder<bool>(
                  stream: groupStreamController.stream,
                  builder: (context, snapshot) {
                    return CustomTextField(
                      selectedFamilyModel?.name ?? 'Select family',
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                      textCapitalization: TextCapitalization.words,
                      onPressed: () {
                        hideKeyboard();
                        if (families.isNotEmpty) {
                          showFamilyDialog();
                        } else {
                          BlocProvider.of<ConfirmPinAndPayBloc>(context)
                              .add(GetFamilyEvent());
                        }
                      },
                      iconData: KoloBoxIcons.dropDownArrow,
                    );
                  }),
              const SizedBox(
                height: 15,
              ),
              Text(
                'Select family member',
                style: AppStyle.b8Medium
                    .copyWith(color: ColorList.blackSecondColor),
              ),
              const SizedBox(
                height: 7,
              ),
              StreamBuilder<bool>(
                  stream: familyUsersStreamController.stream,
                  builder: (context, snapshot) {
                    return CustomTextField(
                      selectedFamilyUserModel?.firstname ??
                          'Select family member',
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                      textCapitalization: TextCapitalization.words,
                      onPressed: () {
                        hideKeyboard();
                        if (selectedFamilyModel == null) {
                          Utils.showToast(
                              context,
                              ToastWidget(
                                'Select family',
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
                        if (familyUsers.isNotEmpty) {
                          showFamilyUserDialog();
                        } else {
                          BlocProvider.of<ConfirmPinAndPayBloc>(context)
                              .add(GetFamilyUsersEvent(
                            model: GetFamilyUserRequestModel(
                                groupId: selectedFamilyModel?.groupId ?? ''),
                          ));
                        }
                      },
                      iconData: KoloBoxIcons.dropDownArrow,
                    );
                  }),
              const SizedBox(
                height: 15,
              ),
              Text(
                'Enter Amount',
                style: AppStyle.b8Regular
                    .copyWith(color: ColorList.blackThirdColor),
              ),
              const SizedBox(
                height: 7,
              ),
              CustomTextField(
                '₦ 0.00',
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.done,
                textCapitalization: TextCapitalization.none,
                inputFormatter: [
                  CurrencyTextInputFormatter(
                    name: '₦ ',
                  )
                ],
                textStyle:
                    AppStyle.b3Bold.copyWith(color: ColorList.primaryColor),
                hintStyle:
                    AppStyle.b3Bold.copyWith(color: ColorList.primaryColor),
                textAlign: TextAlign.center,
                contentPadding: const EdgeInsets.symmetric(vertical: 25),
                controller: saveAmountTextEditingController,
              ),
              const SizedBox(
                height: 15,
              ),
            ] else ...[
              Text(
                'Name your family',
                style: AppStyle.b8Regular
                    .copyWith(color: ColorList.blackSecondColor),
              ),
              const SizedBox(
                height: 7,
              ),
              CustomTextField(
                'Enter your family name',
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.next,
                textCapitalization: TextCapitalization.words,
                controller: targetNameTextEditingController,
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                'Target Amount',
                style: AppStyle.b8Regular
                    .copyWith(color: ColorList.blackThirdColor),
              ),
              const SizedBox(
                height: 7,
              ),
              CustomTextField(
                '₦ 0.00',
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.done,
                textCapitalization: TextCapitalization.none,
                inputFormatter: [
                  CurrencyTextInputFormatter(
                    name: '₦ ',
                  )
                ],
                textStyle:
                    AppStyle.b3Bold.copyWith(color: ColorList.primaryColor),
                hintStyle:
                    AppStyle.b3Bold.copyWith(color: ColorList.primaryColor),
                textAlign: TextAlign.center,
                contentPadding: const EdgeInsets.symmetric(vertical: 25),
                controller: amountTextEditingController,
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                'Select tenor',
                style: AppStyle.b8Medium
                    .copyWith(color: ColorList.blackSecondColor),
              ),
              const SizedBox(
                height: 7,
              ),
              StreamBuilder<bool>(
                  stream: tenorStreamController.stream,
                  builder: (context, snapshot) {
                    return CustomTextField(
                      selectedTenorModel?.tenor ?? 'Select Tenor',
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                      textCapitalization: TextCapitalization.words,
                      onPressed: () {
                        hideKeyboard();
                        if (tenors.isNotEmpty) {
                          showTenorDialog();
                        } else {
                          BlocProvider.of<ConfirmPinAndPayBloc>(context)
                              .add(GetTenorEvent());
                        }
                      },
                      iconData: KoloBoxIcons.dropDownArrow,
                    );
                  }),
              const SizedBox(
                height: 15,
              ),
              Text(
                'How much you plan to save now',
                style: AppStyle.b9Medium
                    .copyWith(color: ColorList.blackSecondColor),
              ),
              const SizedBox(
                height: 7,
              ),
              CustomTextField(
                '₦ 0.00',
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.done,
                textCapitalization: TextCapitalization.none,
                inputFormatter: [
                  CurrencyTextInputFormatter(
                    name: '₦ ',
                  )
                ],
                textStyle:
                    AppStyle.b3Bold.copyWith(color: ColorList.blackSecondColor),
                hintStyle:
                    AppStyle.b3Bold.copyWith(color: ColorList.blackSecondColor),
                textAlign: TextAlign.center,
                contentPadding: const EdgeInsets.symmetric(vertical: 25),
                controller: saveAmountTextEditingController,
              ),
              const SizedBox(
                height: 15,
              ),
            ],
          ],
          // if (isInActive) ...[
          //   getOptionWidget(),
          //   const SizedBox(
          //     height: 15,
          //   ),
          // ],
          // if (!isInActive &&
          //     koloboxFundEnum == KoloboxFundEnum.koloTarget) ...[
          // ],
          // if (koloboxFundEnum != KoloboxFundEnum.koloFlex) ...[
          //   Text(
          //     'Select a kolotarget to make this deposit to',
          //     style:
          //         AppStyle.b8Medium.copyWith(color: ColorList.blackSecondColor),
          //   ),
          //   const SizedBox(
          //     height: 4,
          //   ),
          //   Container(
          //     decoration: BoxDecoration(
          //       border: Border.all(color: ColorList.greyLightColor, width: 1),
          //       borderRadius: BorderRadius.circular(12),
          //     ),
          //     width: double.maxFinite,
          //     padding: const EdgeInsets.only(
          //         left: 12, right: 16, top: 12, bottom: 12),
          //     child: Row(
          //       children: [
          //         Expanded(
          //           child: Text(
          //             'Select a ${koloboxFundEnum.getFundValue}',
          //             style: AppStyle.b8Regular
          //                 .copyWith(color: ColorList.blackThirdColor),
          //           ),
          //         ),
          //         const Icon(KoloBoxIcons.dropDownArrow, size: 8),
          //       ],
          //     ),
          //   ),
          //   const SizedBox(
          //     height: 12,
          //   ),
          // ],

          // if (!isInActive &&
          //     koloboxFundEnum == KoloboxFundEnum.koloTarget) ...[

          // ],
          if (!isInActive) ...[
            Text(
              'Select recurring period',
              style:
                  AppStyle.b8Medium.copyWith(color: ColorList.blackSecondColor),
            ),
            const SizedBox(
              height: 7,
            ),
            StreamBuilder<PeriodEnum>(
                initialData: selectedPeriodEnum,
                stream: periodStreamController.stream,
                builder: (context, snapshot) {
                  return CustomTextField(
                    selectedPeriodEnum.getPeriodValue,
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                    textCapitalization: TextCapitalization.words,
                    onPressed: () {
                      showCustomBottomSheet(SelectRecurringPeriodWidget(
                        periodEnum: selectedPeriodEnum,
                        onPop: (periodEnum) {
                          selectedPeriodEnum = periodEnum;
                          periodStreamController.add(selectedPeriodEnum);
                        },
                      ));
                    },
                    iconData: KoloBoxIcons.dropDownArrow,
                  );
                }),
            const SizedBox(
              height: 20,
            ),
          ],
          Text(
            'Select payment option',
            style:
                AppStyle.b8SemiBold.copyWith(color: ColorList.blackSecondColor),
          ),
          const SizedBox(
            height: 9,
          ),
          Container(
            decoration: BoxDecoration(
              color: ColorList.greyLight5Color,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Paystack',
                          style: AppStyle.b7Regular
                              .copyWith(color: ColorList.blackSecondColor),
                        ),
                      ),
                      Image.asset(imagePayStackIcon),
                      const SizedBox(
                        width: 10,
                      ),
                      SizedBox(
                        width: 25,
                        height: 25,
                        child: Stack(
                          children: [
                            Image.asset(imageCheckedIcon),
                            const Center(
                              child: Icon(
                                KoloBoxIcons.check,
                                color: ColorList.white,
                                size: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 18,
          ),
          Button(
            'Next',
            backgroundColor: ColorList.primaryColor,
            textColor: ColorList.white,
            overlayColor: ColorList.blueColor,
            borderRadius: 32,
            onPressed: () {
              hideKeyboard();
              Future.delayed(const Duration(milliseconds: 300), () {
                onClickNext();
              });
            },
          ),
        ],
      ),
    );
  }

  onClickNext() {
    if (isKoloFlex()) {
      if (amountTextEditingController.text.isEmpty) {
        Utils.showToast(
            context,
            ToastWidget(
              'Enter amount',
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
      if (double.parse(getOnlyAmount(amountTextEditingController.text)) <
          double.parse(koloboxFundEnum!.getMinimumAmountValue())) {
        Utils.showToast(
            context,
            ToastWidget(
              'Amount is less than minimum amount required for this product',
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
      StateContainer.of(context).openFundMyKoloBox(
        fundEnum: StateContainer.of(context).getKoloBoxEnum(),
        amount: amountTextEditingController.text,
        targetAmount: amountTextEditingController.text,
        periodEnum: selectedPeriodEnum,
        targetDateTime: targetDateTime,
        targetName: targetNameTextEditingController.text,
      );
    } else if (isKoloTarget()) {
      if (isInActive) {
        if (amountTextEditingController.text.isEmpty) {
          Utils.showToast(
              context,
              ToastWidget(
                'Enter amount',
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
        if (double.parse(getOnlyAmount(amountTextEditingController.text)) <
            double.parse(koloboxFundEnum!.getMinimumAmountValue())) {
          Utils.showToast(
              context,
              ToastWidget(
                'Amount is less than minimum amount required for this product',
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
        StateContainer.of(context).openFundMyKoloBox(
          fundEnum: StateContainer.of(context).getKoloBoxEnum(),
          amount: amountTextEditingController.text,
          targetAmount: amountTextEditingController.text,
          periodEnum: selectedPeriodEnum,
          targetDateTime: targetDateTime,
          targetName: targetNameTextEditingController.text,
        );
      } else {
        if (targetNameTextEditingController.text.isEmpty) {
          Utils.showToast(
              context,
              ToastWidget(
                'Enter your target name',
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
        if (amountTextEditingController.text.isEmpty) {
          Utils.showToast(
              context,
              ToastWidget(
                'Enter target amount',
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
        if (double.parse(getOnlyAmount(amountTextEditingController.text)) <
            double.parse(koloboxFundEnum!.getMinimumAmountValue())) {
          Utils.showToast(
              context,
              ToastWidget(
                'Target Amount is less than minimum amount required for this product',
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
        if (targetDateTime == null) {
          Utils.showToast(
              context,
              ToastWidget(
                'Select target date',
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
        if (saveAmountTextEditingController.text.isEmpty) {
          Utils.showToast(
              context,
              ToastWidget(
                'Enter save amount',
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
        if (double.parse(getOnlyAmount(saveAmountTextEditingController.text)) <
            double.parse(koloboxFundEnum!.getMinimumAmountValue())) {
          Utils.showToast(
              context,
              ToastWidget(
                'Save Amount is less than minimum amount required for this product',
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
        StateContainer.of(context).openFundMyKoloBox(
          fundEnum: StateContainer.of(context).getKoloBoxEnum(),
          amount: saveAmountTextEditingController.text,
          targetAmount: amountTextEditingController.text,
          periodEnum: selectedPeriodEnum,
          targetDateTime: targetDateTime,
          targetName: targetNameTextEditingController.text,
        );
      }
    } else if (isKoloGroup()) {
      if (isInActive && !widget.isCreateGroup) {
        if (selectedGroupModel == null) {
          Utils.showToast(
              context,
              ToastWidget(
                'Select group',
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
        if (saveAmountTextEditingController.text.isEmpty) {
          Utils.showToast(
              context,
              ToastWidget(
                'Enter save amount',
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
        if (double.parse(getOnlyAmount(saveAmountTextEditingController.text)) <
            double.parse(koloboxFundEnum!.getMinimumAmountValue())) {
          Utils.showToast(
              context,
              ToastWidget(
                'Save Amount is less than minimum amount required for this product',
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
        StateContainer.of(context).openFundMyKoloBox(
          fundEnum: StateContainer.of(context).getKoloBoxEnum(),
          amount: saveAmountTextEditingController.text,
          targetAmount: amountTextEditingController.text,
          periodEnum: selectedPeriodEnum,
          groupTenorModel: selectedTenorModel,
          groupId: selectedGroupModel?.groupId,
          groupName: selectedGroupModel?.name,
          targetDateTime: targetDateTime,
          targetName: targetNameTextEditingController.text,
          familyUserId: '',
        );
      } else {
        if (targetNameTextEditingController.text.isEmpty) {
          Utils.showToast(
              context,
              ToastWidget(
                'Enter your target name',
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
        if (amountTextEditingController.text.isEmpty) {
          Utils.showToast(
              context,
              ToastWidget(
                'Enter target amount',
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
        if (double.parse(getOnlyAmount(amountTextEditingController.text)) <
            double.parse(koloboxFundEnum!.getMinimumAmountValue())) {
          Utils.showToast(
              context,
              ToastWidget(
                'Target Amount is less than minimum amount required for this product',
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
        if (selectedTenorModel == null) {
          Utils.showToast(
              context,
              ToastWidget(
                'Select tenor',
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
        if (saveAmountTextEditingController.text.isEmpty) {
          Utils.showToast(
              context,
              ToastWidget(
                'Enter save amount',
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
        if (double.parse(getOnlyAmount(saveAmountTextEditingController.text)) <
            double.parse(koloboxFundEnum!.getMinimumAmountValue())) {
          Utils.showToast(
              context,
              ToastWidget(
                'Save Amount is less than minimum amount required for this product',
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
        StateContainer.of(context).openFundMyKoloBox(
          fundEnum: StateContainer.of(context).getKoloBoxEnum(),
          amount: saveAmountTextEditingController.text,
          targetAmount: amountTextEditingController.text,
          periodEnum: selectedPeriodEnum,
          groupTenorModel: selectedTenorModel,
          targetDateTime: targetDateTime,
          targetName: targetNameTextEditingController.text,
          isCreateGroup: widget.isCreateGroup,
        );
      }
    } else if (isKoloFamily()) {
      if (isInActive && !widget.isCreateGroup) {
        if (selectedFamilyModel == null) {
          Utils.showToast(
              context,
              ToastWidget(
                'Select family',
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
        if (selectedFamilyUserModel == null) {
          Utils.showToast(
              context,
              ToastWidget(
                'Select family member',
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
        if (saveAmountTextEditingController.text.isEmpty) {
          Utils.showToast(
              context,
              ToastWidget(
                'Enter save amount',
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
        if (double.parse(getOnlyAmount(saveAmountTextEditingController.text)) <
            double.parse(koloboxFundEnum!.getMinimumAmountValue())) {
          Utils.showToast(
              context,
              ToastWidget(
                'Save Amount is less than minimum amount required for this product',
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
        StateContainer.of(context).openFundMyKoloBox(
          fundEnum: StateContainer.of(context).getKoloBoxEnum(),
          amount: saveAmountTextEditingController.text,
          targetAmount: amountTextEditingController.text,
          periodEnum: selectedPeriodEnum,
          groupTenorModel: selectedTenorModel,
          groupId: selectedFamilyModel?.groupId,
          groupName: selectedFamilyModel?.name,
          targetDateTime: targetDateTime,
          targetName: targetNameTextEditingController.text,
          familyUserId: selectedFamilyUserModel?.subUserId,
        );
      } else {
        if (targetNameTextEditingController.text.isEmpty) {
          Utils.showToast(
              context,
              ToastWidget(
                'Enter your family name',
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
        if (amountTextEditingController.text.isEmpty) {
          Utils.showToast(
              context,
              ToastWidget(
                'Enter target amount',
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
        if (double.parse(getOnlyAmount(amountTextEditingController.text)) <
            double.parse(koloboxFundEnum!.getMinimumAmountValue())) {
          Utils.showToast(
              context,
              ToastWidget(
                'Target Amount is less than minimum amount required for this product',
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
        if (selectedTenorModel == null) {
          Utils.showToast(
              context,
              ToastWidget(
                'Select tenor',
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
        if (saveAmountTextEditingController.text.isEmpty) {
          Utils.showToast(
              context,
              ToastWidget(
                'Enter save amount',
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
        if (double.parse(getOnlyAmount(saveAmountTextEditingController.text)) <
            double.parse(koloboxFundEnum!.getMinimumAmountValue())) {
          Utils.showToast(
              context,
              ToastWidget(
                'Save Amount is less than minimum amount required for this product',
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
        StateContainer.of(context).openFundMyKoloBox(
          fundEnum: StateContainer.of(context).getKoloBoxEnum(),
          amount: saveAmountTextEditingController.text,
          targetAmount: amountTextEditingController.text,
          periodEnum: selectedPeriodEnum,
          groupTenorModel: selectedTenorModel,
          targetDateTime: targetDateTime,
          targetName: targetNameTextEditingController.text,
          isCreateGroup: widget.isCreateGroup,
        );
      }
    }

    showCustomBottomSheet(DepositSummaryWidgetPage(
      key: Key('deposit_summary_${DateTime.now().millisecondsSinceEpoch}'),
    ));
  }

  String getDepositTitle() {
    String message = 'Deposit';
    logger?.d("deposit message $koloboxFundEnum In active $isInActive");

    if (!isInActive && koloboxFundEnum == KoloboxFundEnum.koloTarget) {
      return 'Create ${koloboxFundEnum!.getFundValue}';
    }

    return message;
  }

  String getDepositMessage() {
    String message = 'Deposit into your ';
    logger?.d("deposit message $koloboxFundEnum In active $isInActive");

    if (!isInActive && koloboxFundEnum == KoloboxFundEnum.koloTarget) {
      return 'Start investing towards your goal';
    }
    if (StateContainer.of(context).isWallet() ?? false) {
      message += 'wallet balance';
    } else if (koloboxFundEnum != null) {
      message += koloboxFundEnum!.getFundValue;
    }

    return message;
  }

  Widget getOptionWidget() {
    KoloboxFundEnum? fundEnum = StateContainer.of(context).getKoloBoxEnum();
    if (fundEnum == null) return const SizedBox();
    return ProductItemWidget(fundEnum: fundEnum);
  }

  Future<void> onClickTargetDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      targetDateTime = picked;
      targetDateStreamController.add(true);
    }
  }

  showTenorDialog() {
    showCustomBottomSheet(SelectTenorWidget(
      selectedTenorModel: selectedTenorModel,
      groupTenorModels: tenors,
      onPop: (model) {
        selectedTenorModel = model;
        tenorStreamController.add(true);
      },
    ));
  }

  showGroupDialog() {
    showCustomBottomSheet(SelectGroupWidget(
      selectedGroupModel: selectedGroupModel,
      groupModels: groups,
      onPop: (model) {
        selectedGroupModel = model;
        groupStreamController.add(true);
      },
    ));
  }

  showFamilyDialog() {
    showCustomBottomSheet(SelectFamilyWidget(
      selectedGroupModel: selectedFamilyModel,
      groupModels: families,
      onPop: (model) {
        selectedFamilyModel = model;
        groupStreamController.add(true);
        familyUsers.clear();
        selectedFamilyUserModel = null;
        familyUsersStreamController.add(true);
      },
    ));
  }

  showFamilyUserDialog() {
    showCustomBottomSheet(SelectFamilyUserWidget(
      selectedGroupModel: selectedFamilyUserModel,
      groupModels: familyUsers,
      onPop: (model) {
        selectedFamilyUserModel = model;
        familyUsersStreamController.add(true);
      },
    ));
  }

  bool isKoloFlex() => koloboxFundEnum == KoloboxFundEnum.koloFlex;

  bool isKoloTarget() => koloboxFundEnum == KoloboxFundEnum.koloTarget;

  // bool isKoloTargetPlus() => koloboxFundEnum == KoloboxFundEnum.koloTargetPlus;

  bool isKoloFamily() => koloboxFundEnum == KoloboxFundEnum.koloFamily;

  bool isKoloGroup() => koloboxFundEnum == KoloboxFundEnum.koloGroup;

  @override
  void dispose() {
    super.dispose();
    amountTextEditingController.dispose();
    periodStreamController.close();
    tenorStreamController.close();
    groupStreamController.close();
    targetDateStreamController.close();
  }
}
