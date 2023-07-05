import 'package:flutter/material.dart';
import 'package:kolobox_new_app/core/ui/widgets/button.dart';
import 'package:kolobox_new_app/routes/routes.dart';

import '../../../../../core/base/base_screen.dart';
import '../../../../../core/colors/color_list.dart';

class ProductInfoKoloboxWidget extends BaseScreen {
  final String title;
  final String text;

  const ProductInfoKoloboxWidget({
    Key? key,
    required this.title,
    required this.text,
  }) : super(key: key);

  @override
  State<ProductInfoKoloboxWidget> createState() =>
      _ProductInfoKoloboxWidgetState();
}

class _ProductInfoKoloboxWidgetState
    extends BaseScreenState<ProductInfoKoloboxWidget> {
  @override
  Widget body(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 25, left: 28, right: 28, bottom: 31),
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Text(
            widget.title,
            style: const TextStyle(
              color: ColorList.primaryColor,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            widget.text,
            style: TextStyle(
              color: ColorList.blackSecondColor,
              fontSize: 10,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 20,
          ),
          Button(
            'Ok',
            backgroundColor: ColorList.primaryColor,
            textColor: ColorList.white,
            overlayColor: ColorList.blueColor,
            borderRadius: 32,
            onPressed: () {
              goBack(context);
            },
          ),
        ],
      ),
    );
  }
}
