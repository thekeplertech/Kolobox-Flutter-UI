import 'package:flutter/material.dart';

import '../../colors/color_list.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
    this.hint, {
    Key? key,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.done,
  }) : super(key: key);

  final String hint;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: ColorList.greyLightColor,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextFormField(
        controller: controller,
        style: TextStyle(
          color: ColorList.blackThirdColor,
          fontSize: 12,
          fontWeight: FontWeight.w400,
        ),
        decoration: InputDecoration(
          hintText: hint,
          border: InputBorder.none,
          isDense: true,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 15,
            horizontal: 12,
          ),
          hintStyle: TextStyle(
            color: ColorList.blackThirdColor,
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),
        ),
        keyboardType: keyboardType,
        textInputAction: textInputAction,
      ),
    );
  }
}
