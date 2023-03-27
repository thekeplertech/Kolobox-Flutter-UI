import 'package:flutter/material.dart';
import 'package:kolobox_new_app/core/colors/color_list.dart';
import 'package:kolobox_new_app/core/constants/image_constants.dart';
import 'package:kolobox_new_app/core/ui/style/app_style.dart';

class FamilyContributorsWidget extends StatelessWidget {
  const FamilyContributorsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: ColorList.greyLight6Color, width: 1),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: const BoxDecoration(
              color: ColorList.lightBlue3Color,
              shape: BoxShape.circle,
            ),
            padding: const EdgeInsets.all(5),
            child: Image.asset(
              imageUserIcon,
              width: 25,
              height: 25,
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            'Babe',
            style:
                AppStyle.b10Medium.copyWith(color: ColorList.greyLight12Color),
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            '@Analpeal',
            style: AppStyle.b10Medium.copyWith(color: ColorList.primaryColor),
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            '₦ 100,000.00',
            style: AppStyle.b9Bold.copyWith(color: ColorList.primaryColor),
          ),
        ],
      ),
    );
  }
}
