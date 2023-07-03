import 'package:flutter/material.dart';

import '../../../../core/colors/color_list.dart';

class NewsItemWidget extends StatelessWidget {
  final String icon;
  final String title;
  final String text;

  const NewsItemWidget(
      {Key? key, required this.icon, required this.title, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      margin: EdgeInsets.zero,
      elevation: 1,
      child: Container(
          width: 180,
          decoration: BoxDecoration(
              border: Border.all(
                width: 1,
                color: ColorList.blackFourColor,
              ),
              borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.only(
              top: 13,
              bottom: 13,
              left: 16,
              right: 16,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    icon,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(
                  height: 11,
                ),
                Text(
                  title,
                  style: TextStyle(
                    color: ColorList.greyLight2Color,
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 6,
                ),
                Expanded(
                  child: Text(
                    text,
                    style: TextStyle(
                      color: ColorList.blackSecondColor,
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 5,
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
