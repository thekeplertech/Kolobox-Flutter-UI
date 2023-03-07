import 'package:flutter/material.dart';

import '../../../../core/colors/color_list.dart';
import '../../../../core/constants/image_constants.dart';

class ReferAndEarnWidget extends StatelessWidget {
  const ReferAndEarnWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Card(
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 15,
            horizontal: 20,
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Referral & Earn',
                      style: TextStyle(
                        color: ColorList.blackSecondColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    Text(
                      'Users can now refer people to invest and earn bonuses',
                      style: TextStyle(
                        color: ColorList.greyDark2Color,
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Image.asset(imageAnnouncement),
            ],
          ),
        ),
      );
}
