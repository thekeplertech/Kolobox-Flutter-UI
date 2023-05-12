import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kolobox_new_app/core/base/base_screen.dart';
import 'package:kolobox_new_app/core/constants/image_constants.dart';
import 'package:kolobox_new_app/core/ui/style/app_style.dart';
import 'package:kolobox_new_app/feature/dashboard/data/models/get_group_tenor_response_model.dart';
import 'package:kolobox_new_app/routes/routes.dart';

import '../../../core/colors/color_list.dart';
import '../../../core/ui/widgets/button.dart';
import '../../../core/ui/widgets/toast_widget.dart';
import '../../../core/utils/utils.dart';

class SelectTenorWidget extends BaseScreen {
  final Function(GroupTenorModel) onPop;
  final GroupTenorModel? selectedTenorModel;
  final List<GroupTenorModel> groupTenorModels;

  const SelectTenorWidget({
    Key? key,
    required this.selectedTenorModel,
    required this.groupTenorModels,
    required this.onPop,
  }) : super(key: key);

  @override
  State<SelectTenorWidget> createState() => _SelectTenorWidgetState();
}

class _SelectTenorWidgetState extends BaseScreenState<SelectTenorWidget> {
  StreamController<bool> tenorStreamController =
      StreamController<bool>.broadcast();
  GroupTenorModel? selectedTenorModel;
  List<GroupTenorModel> groupTenorModels = [];

  @override
  void initState() {
    super.initState();
    selectedTenorModel = widget.selectedTenorModel;
    groupTenorModels = widget.groupTenorModels;
  }

  @override
  Widget body(BuildContext context) {
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
          const SizedBox(
            height: 10,
          ),
          Text(
            'Select a tenor',
            style:
                AppStyle.b8Regular.copyWith(color: ColorList.blackSecondColor),
          ),
          const SizedBox(
            height: 15,
          ),
          StreamBuilder<bool>(
              stream: tenorStreamController.stream,
              builder: (context, snapshot) {
                return ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: groupTenorModels.length,
                    itemBuilder: (_, index) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Button(
                          groupTenorModels[index].tenor ?? '',
                          backgroundColor: ColorList.whiteColor,
                          overlayColor: ColorList.blueColor,
                          textColor: ColorList.blackSecondColor,
                          borderSide: BorderSide(
                              color: groupTenorModels[index].id ==
                                      selectedTenorModel?.id
                                  ? ColorList.primaryColor
                                  : ColorList.greyLight7Color,
                              width: 1),
                          borderRadius: 12,
                          textStyle: (groupTenorModels[index].id ==
                                      selectedTenorModel?.id
                                  ? AppStyle.b7SemiBold
                                  : AppStyle.b8Regular)
                              .copyWith(color: ColorList.blackSecondColor),
                          onPressed: () {
                            selectedTenorModel = groupTenorModels[index];
                            tenorStreamController.add(true);
                          },
                        ),
                      );
                    });
              }),
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
              widget.onPop(selectedTenorModel!);
              goBack(context);
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    tenorStreamController.close();
  }
}
