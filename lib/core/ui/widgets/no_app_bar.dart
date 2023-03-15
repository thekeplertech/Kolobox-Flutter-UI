import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../colors/color_list.dart';

class NoAppBar extends StatelessWidget implements PreferredSizeWidget {
  const NoAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: ColorList.transparentColor,
      bottomOpacity: 0,
      elevation: 0,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: ColorList.white,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
      title: const SizedBox(),
      centerTitle: false,
      titleSpacing: 0,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(0);
}
