import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kolobox_new_app/core/base/base_screen.dart';
import 'package:kolobox_new_app/core/constants/image_constants.dart';
import 'package:kolobox_new_app/core/ui/style/app_style.dart';
import 'package:kolobox_new_app/routes/routes.dart';

import '../../../core/colors/color_list.dart';
import '../../../core/ui/widgets/button.dart';
import '../../../core/ui/widgets/toast_widget.dart';
import '../../../core/utils/utils.dart';
import '../../dashboard/data/models/get_group_list_response_model.dart';

class SelectGroupWidget extends BaseScreen {
  final Function(GroupModel) onPop;
  final GroupModel? selectedGroupModel;
  final List<GroupModel> groupModels;

  const SelectGroupWidget({
    Key? key,
    required this.selectedGroupModel,
    required this.groupModels,
    required this.onPop,
  }) : super(key: key);

  @override
  State<SelectGroupWidget> createState() => _SelectGroupWidgetState();
}

class _SelectGroupWidgetState extends BaseScreenState<SelectGroupWidget> {
  StreamController<bool> groupStreamController =
      StreamController<bool>.broadcast();
  GroupModel? selectedGroupModel;
  List<GroupModel> groupModels = [];

  @override
  void initState() {
    super.initState();
    selectedGroupModel = widget.selectedGroupModel;
    groupModels = widget.groupModels;
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
            'Select a group',
            style:
                AppStyle.b8Regular.copyWith(color: ColorList.blackSecondColor),
          ),
          const SizedBox(
            height: 15,
          ),
          StreamBuilder<bool>(
              stream: groupStreamController.stream,
              builder: (context, snapshot) {
                return ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: groupModels.length,
                    itemBuilder: (_, index) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Button(
                          groupModels[index].name ?? '',
                          backgroundColor: ColorList.whiteColor,
                          overlayColor: ColorList.blueColor,
                          textColor: ColorList.blackSecondColor,
                          borderSide: BorderSide(
                              color: groupModels[index].groupId ==
                                      selectedGroupModel?.groupId
                                  ? ColorList.primaryColor
                                  : ColorList.greyLight7Color,
                              width: 1),
                          borderRadius: 12,
                          textStyle: (groupModels[index].groupId ==
                                      selectedGroupModel?.groupId
                                  ? AppStyle.b7SemiBold
                                  : AppStyle.b8Regular)
                              .copyWith(color: ColorList.blackSecondColor),
                          onPressed: () {
                            selectedGroupModel = groupModels[index];
                            groupStreamController.add(true);
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
              widget.onPop(selectedGroupModel!);
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
    groupStreamController.close();
  }
}
