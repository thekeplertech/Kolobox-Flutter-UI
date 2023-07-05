import 'package:flutter/material.dart';
import 'package:kolobox_new_app/core/ui/widgets/button.dart';
import 'package:kolobox_new_app/routes/routes.dart';

import '../../../../../core/base/base_screen.dart';
import '../../../../../core/colors/color_list.dart';

class TestimonyInfoKoloboxWidget extends BaseScreen {
  final String icon;
  final String title;
  final String text;

  const TestimonyInfoKoloboxWidget({
    Key? key,
    required this.icon,
    required this.title,
    required this.text,
  }) : super(key: key);

  @override
  State<TestimonyInfoKoloboxWidget> createState() =>
      _TestimonyInfoKoloboxWidgetState();
}

class _TestimonyInfoKoloboxWidgetState
    extends BaseScreenState<TestimonyInfoKoloboxWidget> {
  @override
  Widget body(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 25, left: 28, right: 28, bottom: 31),
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              widget.icon,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            height: 11,
          ),
          Text(
            widget.title,
            style: TextStyle(
              color: ColorList.greyLight2Color,
              fontSize: 10,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(
            height: 6,
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
