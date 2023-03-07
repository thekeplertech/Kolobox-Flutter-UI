import 'package:flutter/material.dart';

import '../../../../core/colors/color_list.dart';

class NewsItemWidget extends StatelessWidget {
  const NewsItemWidget({Key? key}) : super(key: key);

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
                  child: Image.network(
                    'https://cdn.pixabay.com/photo/2015/12/01/20/28/road-1072821__480.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(
                  height: 11,
                ),
                Text(
                  'Jul 28, 2022',
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
                    '10 reasons to start investing during global rescission asd fja;lksdjf lsakjf;ksaj f;lksa jf;lksa jf;slk jf;salk fj;lkj ;lk j;lk j;lkj',
                    style: TextStyle(
                      color: ColorList.blackSecondColor,
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
