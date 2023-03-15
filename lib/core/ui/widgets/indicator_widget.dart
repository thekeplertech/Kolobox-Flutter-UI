import 'dart:async';

import 'package:flutter/material.dart';

import '../../colors/color_list.dart';

class IndicatorWidget<T> extends StatefulWidget {
  final List<T> list;
  final int initialPosition;
  final Color activeColor;
  final Color inactiveColor;
  final StreamController<int> streamController;

  const IndicatorWidget({
    Key? key,
    required this.list,
    required this.streamController,
    this.initialPosition = 0,
    this.activeColor = ColorList.white,
    this.inactiveColor = ColorList.lightBlue4Color,
  }) : super(key: key);

  @override
  State<IndicatorWidget<T>> createState() => _IndicatorWidgetState<T>();
}

class _IndicatorWidgetState<T> extends State<IndicatorWidget<T>> {
  @override
  Widget build(BuildContext context) => StreamBuilder<int>(
      stream: widget.streamController.stream,
      builder: (context, snapshot) => Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: _buildPageIndicator(),
          ));

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < widget.list.length; i++) {
      list.add(
          i == widget.initialPosition ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) => AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        margin: const EdgeInsets.symmetric(horizontal: 4),
        height: 5,
        width: isActive ? 15 : 5,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: isActive ? widget.activeColor : widget.inactiveColor,
          borderRadius: const BorderRadius.all(Radius.circular(12)),
        ),
      );
}
