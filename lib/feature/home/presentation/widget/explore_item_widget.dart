import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kolobox_new_app/core/base/base_screen.dart';

import '../../../../core/colors/color_list.dart';
import '../../../dashboard/presentation/bloc/dashboard_bloc.dart';
import '../../../dashboard/presentation/bloc/dashboard_event.dart';
import '../../../widgets/product_info/product_info_widget.dart';

class ProductItemWidget extends BaseScreen {
  final String title;
  final String text;

  const ProductItemWidget({Key? key, required this.title, required this.text})
      : super(key: key);

  @override
  State<ProductItemWidget> createState() => _ProductItemWidgetState();
}

class _ProductItemWidgetState extends BaseScreenState<ProductItemWidget> {
  @override
  Widget body(BuildContext context) {
    return GestureDetector(
      onTap: () {
        BlocProvider.of<DashboardBloc>(context)
            .add(HideDisableBottomScreenEvent());
        showCustomBottomSheet(
          ProductInfoKoloboxWidget(
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
                    widget.title,
                    style: const TextStyle(
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
                          widget.text,
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
                        style: const TextStyle(
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
      ),
    );
  }
}
