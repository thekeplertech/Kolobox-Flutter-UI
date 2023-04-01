import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kolobox_new_app/core/base/base_screen.dart';
import 'package:kolobox_new_app/core/enums/dashboard_tab_enum.dart';
import 'package:kolobox_new_app/core/ui/style/app_style.dart';
import 'package:kolobox_new_app/feature/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:kolobox_new_app/feature/dashboard/presentation/bloc/dashboard_event.dart';
import 'package:kolobox_new_app/routes/routes.dart';

import '../../core/colors/color_list.dart';
import '../../core/constants/image_constants.dart';

class HomeAppBarWidget extends BaseScreen {
  final String? title;
  final String? amount;
  final StreamController<bool>? walletBalanceStreamController;
  final String leftIcon;
  final String? rightIcon;
  final Function()? onLeftPressed;
  final Function()? onRightPressed;

  const HomeAppBarWidget({
    Key? key,
    this.title,
    this.amount,
    this.walletBalanceStreamController,
    required this.leftIcon,
    this.rightIcon,
    this.onLeftPressed,
    this.onRightPressed,
  }) : super(key: key);

  @override
  State<HomeAppBarWidget> createState() => _HomeAppBarWidgetState();
}

class _HomeAppBarWidgetState extends BaseScreenState<HomeAppBarWidget> {
  @override
  Widget body(BuildContext context) => Stack(
        alignment: Alignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () => widget.onLeftPressed == null
                    ? goBack(context)
                    : widget.onLeftPressed!(),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 30, right: 15, top: 11, bottom: 11),
                  child: Image.asset(widget.leftIcon),
                ),
              ),
              const Spacer(),
              if (widget.walletBalanceStreamController != null) ...[
                GestureDetector(
                  onTap: () => BlocProvider.of<DashboardBloc>(context)
                      .add(SelectTabEvent(tabEnum: DashboardTabEnum.wallet)),
                  child: AbsorbPointer(
                    child: Row(
                      children: [
                        Text(
                          'Wallet balance',
                          style: AppStyle.b8Medium
                              .copyWith(color: ColorList.blackThirdColor),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        StreamBuilder<bool>(
                            stream:
                                widget.walletBalanceStreamController!.stream,
                            builder: (context, snapshot) {
                              return Container(
                                decoration: BoxDecoration(
                                    color: ColorList.lightBlue2Color,
                                    borderRadius: BorderRadius.circular(24)),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 4,
                                ),
                                child: Row(
                                  children: [
                                    Image.asset(imageWalletBalance),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      widget.amount ?? '',
                                      style: AppStyle.b8Bold.copyWith(
                                          color: ColorList.primaryColor),
                                    ),
                                  ],
                                ),
                              );
                            }),
                      ],
                    ),
                  ),
                ),
              ],
              if (widget.rightIcon != null) ...[
                GestureDetector(
                  onTap: widget.onRightPressed,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 20, right: 30, top: 11, bottom: 11),
                    child: Image.asset(widget.rightIcon!),
                  ),
                ),
              ],
            ],
          ),
          if (widget.title != null) ...[
            Text(
              widget.title!,
              style: AppStyle.b7SemiBold
                  .copyWith(color: ColorList.blackSecondColor),
            ),
          ],
        ],
      );
}
