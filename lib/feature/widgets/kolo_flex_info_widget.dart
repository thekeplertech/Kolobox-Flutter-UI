import 'package:flutter/material.dart';
import 'package:kolobox_new_app/core/enums/kolobox_fund_enum.dart';
import 'package:kolobox_new_app/core/ui/style/app_style.dart';

import '../../core/colors/color_list.dart';
import '../../core/constants/image_constants.dart';
import '../../core/ui/widgets/button.dart';
import '../../routes/routes.dart';

class KoloFlexInfoWidget extends StatelessWidget {
  final KoloboxFundEnum koloboxFundEnum;

  const KoloFlexInfoWidget({
    Key? key,
    required this.koloboxFundEnum,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding:
            const EdgeInsets.only(top: 17, left: 28, right: 28, bottom: 31),
        child: Column(
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
              height: 20,
            ),
            Container(
              decoration: BoxDecoration(
                color: koloboxFundEnum.getFundBackColorValue,
                shape: BoxShape.circle,
              ),
              padding: const EdgeInsets.all(25),
              child: Icon(
                koloboxFundEnum.getFundIconValue,
                size: 90,
                color: koloboxFundEnum.getFundIconColorValue,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              'Learn about Koloflex',
              style:
                  AppStyle.b5Bold.copyWith(color: ColorList.blackSecondColor),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28),
              child: Text(
                'Suspendisse auctor mauris ut sapien pharetra pharetra. Curabitur luctus tellus nunc, a auctor lorem sodales pellentesque. Nullam mollis felis odio\n\nSemper ligula imperdiet vel. Curabitur ultricies ac est non pretium. Sed orci risus, tincidunt ac pulvinar eget, consequat sit amet dui.',
                style: AppStyle.b8Regular
                    .copyWith(color: ColorList.blackThirdColor),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(
              height: 35,
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
      ),
    );
  }
}
