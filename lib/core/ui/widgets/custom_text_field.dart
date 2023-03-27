import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../colors/color_list.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
    this.hint, {
    Key? key,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.done,
    this.textCapitalization = TextCapitalization.none,
    this.inputFormatter,
    this.postIcon,
    this.iconData,
    this.onPressed,
    this.onChanged,
    this.textStyle,
    this.hintStyle,
    this.obscureText = false,
    this.textAlign = TextAlign.start,
    this.maxLines = 1,
  }) : super(key: key);

  final String hint;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final TextCapitalization textCapitalization;
  final List<TextInputFormatter>? inputFormatter;
  final String? postIcon;
  final IconData? iconData;
  final Function? onPressed;
  final Function(String)? onChanged;
  final bool obscureText;
  final TextStyle? textStyle;
  final TextStyle? hintStyle;
  final TextAlign textAlign;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    if (onPressed == null) {
      return getChild();
    } else {
      return GestureDetector(
        onTap: () {
          onPressed!();
        },
        child: AbsorbPointer(
          child: getChild(),
        ),
      );
    }
  }

  Container getChild() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: ColorList.greyLightColor,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: controller,
              style: textStyle ??
                  TextStyle(
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
                hintStyle: hintStyle ??
                    TextStyle(
                      color: ColorList.blackThirdColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
              ),
              keyboardType: keyboardType,
              textInputAction: textInputAction,
              textCapitalization: textCapitalization,
              inputFormatters: inputFormatter ?? [],
              enabled: onPressed == null,
              onChanged: onChanged,
              obscureText: obscureText,
              textAlign: textAlign,
              maxLines: maxLines,
            ),
          ),
          if (postIcon != null) ...[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Image.asset(postIcon!),
            ),
          ],
          if (iconData != null) ...[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Icon(iconData, size: 8),
            ),
          ],
        ],
      ),
    );
  }
}
