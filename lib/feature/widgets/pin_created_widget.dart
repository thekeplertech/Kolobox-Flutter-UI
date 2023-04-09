import 'package:flutter/material.dart';
import 'package:kolobox_new_app/core/ui/style/app_style.dart';

import '../../core/colors/color_list.dart';
import '../../core/constants/image_constants.dart';
import '../../core/ui/widgets/button.dart';
import '../../routes/routes.dart';

class PinCreatedWidget extends StatelessWidget {
  final Function() onBack;

  const PinCreatedWidget({
    Key? key,
    required this.onBack,
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
              height: 25,
            ),
            Image.asset(imageConfirm),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Transaction Pin Created Successful',
              style:
                  AppStyle.b5Bold.copyWith(color: ColorList.blackSecondColor),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'You have successfully created your transaction Pin to secure all your transactions',
                style: AppStyle.b9Medium
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
                onBack();
                goBack(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
