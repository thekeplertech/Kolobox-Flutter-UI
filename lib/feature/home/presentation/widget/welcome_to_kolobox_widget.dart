import 'package:flutter/material.dart';
import 'package:kolobox_new_app/core/ui/style/app_style.dart';

import '../../../../core/colors/color_list.dart';
import '../../../../core/constants/image_constants.dart';

class WelcomeToKoloboxWidget extends StatelessWidget {
  const WelcomeToKoloboxWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      color: ColorList.white,
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.only(
          left: 20,
          right: 16,
          top: 16,
          bottom: 25,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome to KoloBox',
                    style: AppStyle.b9SemiBold
                        .copyWith(color: ColorList.primaryColor),
                  ),
                  const SizedBox(
                    height: 2.2,
                  ),
                  Text(
                    'Finish your account setup',
                    style: AppStyle.b6SemiBold.copyWith(
                      color: ColorList.blackSecondColor,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Stack(
                          children: [
                            Container(
                              width: double.maxFinite,
                              height: 8,
                              decoration: BoxDecoration(
                                color: ColorList.greyVeryLightColor,
                                borderRadius: BorderRadius.circular(100),
                              ),
                            ),
                            Container(
                              width: 50,
                              height: 8,
                              decoration: BoxDecoration(
                                color: ColorList.yellowDarkColor,
                                borderRadius: BorderRadius.circular(100),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 6,
                      ),
                      Text(
                        '2/5',
                        style: AppStyle.b8Medium
                            .copyWith(color: ColorList.blackSecondColor),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            Image.asset(imageAccountSetup),
          ],
        ),
      ),
    );
  }
}
