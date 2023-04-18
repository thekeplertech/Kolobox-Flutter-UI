import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kolobox_new_app/core/base/base_screen.dart';
import 'package:kolobox_new_app/core/constants/image_constants.dart';
import 'package:kolobox_new_app/core/ui/style/app_style.dart';
import 'package:kolobox_new_app/feature/dashboard/data/models/get_banks_response_model.dart';
import 'package:kolobox_new_app/routes/routes.dart';

import '../../../core/colors/color_list.dart';
import '../../../core/ui/widgets/button.dart';

class SelectBankWidget extends BaseScreen {
  final BankData? selectedBankData;
  final List<BankData> banks;
  final Function(BankData?) onPop;

  const SelectBankWidget({
    Key? key,
    required this.selectedBankData,
    required this.banks,
    required this.onPop,
  }) : super(key: key);

  @override
  State<SelectBankWidget> createState() => _SelectBankWidgetState();
}

class _SelectBankWidgetState extends BaseScreenState<SelectBankWidget> {
  StreamController<bool> bankDataStreamController =
      StreamController<bool>.broadcast();
  BankData? selectedBankData;
  List<BankData> banks = [];

  @override
  void initState() {
    super.initState();
    selectedBankData = widget.selectedBankData;
    banks = widget.banks;
  }

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
                  'Select bank',
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
            height: 15,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.5,
            child: StreamBuilder<bool>(
                stream: bankDataStreamController.stream,
                builder: (context, snapshot) {
                  return ListView.builder(
                      itemCount: banks.length,
                      itemBuilder: (_, index) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Button(
                            banks[index].name ?? '',
                            backgroundColor: ColorList.whiteColor,
                            overlayColor: ColorList.blueColor,
                            textColor: ColorList.blackSecondColor,
                            borderSide: BorderSide(
                                color: (banks[index].id == selectedBankData?.id)
                                    ? ColorList.primaryColor
                                    : ColorList.greyLight7Color,
                                width: 1),
                            borderRadius: 12,
                            textStyle: (banks[index].id == selectedBankData?.id)
                                ? AppStyle.b7SemiBold
                                : AppStyle.b8Regular.copyWith(
                                    color: ColorList.blackSecondColor),
                            onPressed: () {
                              selectedBankData = banks[index];
                              bankDataStreamController.add(true);
                            },
                          ),
                        );
                      });
                }),
          ),
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
              widget.onPop(selectedBankData);
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
    bankDataStreamController.close();
  }
}
