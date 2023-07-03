import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/colors/color_list.dart';
import '../../../../core/constants/image_constants.dart';

class LearnItemWidget extends StatelessWidget {
  final String title;
  final String url;

  const LearnItemWidget({Key? key, required this.title, required this.url})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String imageUrl =
        'https://img.youtube.com/vi/${url.substring(url.lastIndexOf('/') + 1)}/mqdefault.jpg';
    return GestureDetector(
      onTap: () {
        launchUrl(Uri.parse(url));
      },
      child: Card(
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
                  imageUrl,
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
                      title,
                      style: const TextStyle(
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
      ),
    );
  }
}
