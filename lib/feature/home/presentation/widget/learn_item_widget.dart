import 'package:flutter/material.dart';

import '../../../../core/colors/color_list.dart';
import '../../../../core/constants/image_constants.dart';

class LearnItemWidget extends StatelessWidget {
  const LearnItemWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      margin: EdgeInsets.zero,
      elevation: 1,
      child: SizedBox(
        width: 178,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.network(
                'https://cdn.pixabay.com/photo/2015/12/01/20/28/road-1072821__480.jpg',
                fit: BoxFit.cover,
              ),
              Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                      ColorList.black.withOpacity(0),
                      ColorList.black.withOpacity(0.8),
                    ])),
                padding: const EdgeInsets.only(
                  left: 14,
                  bottom: 17,
                  right: 40,
                ),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    'Welcome to KoloBox',
                    style: TextStyle(
                      color: ColorList.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              Image.asset(imagePlay),
            ],
          ),
        ),
      ),
    );
  }
}
