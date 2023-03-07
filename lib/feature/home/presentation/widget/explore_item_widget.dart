import 'package:flutter/material.dart';

import '../../../../core/colors/color_list.dart';

class ExploreItemWidget extends StatelessWidget {
  const ExploreItemWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      margin: EdgeInsets.zero,
      elevation: 2,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: SizedBox(
          width: 230,
          height: double.maxFinite,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.maxFinite,
                color: ColorList.blueLight2Color,
                padding: const EdgeInsets.only(
                  top: 23,
                  bottom: 8,
                  left: 21,
                  right: 21,
                ),
                child: Text(
                  'Kolotarget',
                  style: TextStyle(
                    color: ColorList.primaryColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.only(
                  left: 21,
                  right: 21,
                  top: 12,
                  bottom: 10,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        'Phasellus efficitur accumsan orci in fringilla hasellus dictum euismod.',
                        style: TextStyle(
                          color: ColorList.greyDark2Color,
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                      ),
                    ),
                    Text(
                      'Explore',
                      style: TextStyle(
                        color: ColorList.primaryColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
