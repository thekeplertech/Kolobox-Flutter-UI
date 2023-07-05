import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kolobox_new_app/core/base/base_screen.dart';

import '../../../../core/colors/color_list.dart';
import '../../../dashboard/presentation/bloc/dashboard_bloc.dart';
import '../../../dashboard/presentation/bloc/dashboard_event.dart';
import '../../../widgets/testimony_info/testimony_info_widget.dart';

class NewsItemWidget extends BaseScreen {
  final String icon;
  final String title;
  final String text;

  const NewsItemWidget(
      {Key? key, required this.icon, required this.title, required this.text})
      : super(key: key);

  @override
  State<NewsItemWidget> createState() => _NewsItemWidgetState();
}

class _NewsItemWidgetState extends BaseScreenState<NewsItemWidget> {
  @override
  Widget body(BuildContext context) {
    return GestureDetector(
      onTap: () {
        BlocProvider.of<DashboardBloc>(context)
            .add(HideDisableBottomScreenEvent());
        showCustomBottomSheet(
          TestimonyInfoKoloboxWidget(
            icon: widget.icon,
            title: widget.title,
            text: widget.text,
          ),
        ).then((value) {
          BlocProvider.of<DashboardBloc>(context)
              .add(ShowEnableBottomScreenEvent());
        });
      },
      child: Card(
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
                      widget.icon,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(
                    height: 11,
                  ),
                  Text(
                    widget.title,
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
                      widget.text,
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
      ),
    );
  }
}
