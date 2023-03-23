import 'package:flutter/material.dart';
import 'package:kolobox_new_app/core/colors/color_list.dart';

class FlutterCustomSwitch extends StatefulWidget {
  /// Called when the user toggles the switch on or off.
  ///
  /// The switch passes the new value to the callback but does not actually
  /// change state until the parent widget rebuilds the switch with the new
  /// value.
  ///
  /// If null, the switch will be displayed as disabled.
  ///
  /// The callback provided to [onChanged] should update the state of the parent
  /// [StatefulWidget] using the [State.setState] method, so that the parent
  /// gets rebuilt; for example:
  ///
  /// ```dart
  /// Switch(
  ///   value: _giveVerse,
  ///   onChanged: (bool newValue) {
  ///     setState(() {
  ///       _giveVerse = newValue;
  ///     });
  ///   },
  /// )
  /// ```
  final ValueChanged<bool> onChanged;

  /// Whether this switch is true or false.
  ///
  /// This property must not be null.
  final bool value;

  /// background active color
  final Color activeColor;

  /// background in active color
  final Color inActiveColor;

  /// thumb active color
  final Color activeThumbColor;

  /// thumb in active color
  final Color inActiveThumbColor;

  /// active image path
  final String? activeImagePath;

  /// in-active image path
  final String? inActiveImagePath;

  /// active thumb image path
  final String? activeThumbImagePath;

  /// in-active thumb image path
  final String? inActiveThumbImagePath;

  /// enable the text view
  final bool enableOutsideText;

  /// for small size button
  final bool isSmallToggle;

  const FlutterCustomSwitch({
    Key? key,
    required this.value,
    required this.onChanged,
    this.activeColor = Colors.blue,
    this.inActiveColor = Colors.grey,
    this.activeThumbColor = Colors.white,
    this.inActiveThumbColor = Colors.white,
    this.activeImagePath,
    this.inActiveImagePath,
    this.activeThumbImagePath,
    this.inActiveThumbImagePath,
    this.enableOutsideText = false,
    this.isSmallToggle = false,
  }) : super(key: key);

  @override
  FlutterCustomSwitchState createState() => FlutterCustomSwitchState();
}

class FlutterCustomSwitchState extends State<FlutterCustomSwitch> {
  double _switchWidth = 48.0;

  double _switchHeight = 24.0;

  double _thumbSize = 18.0;

  final int _animationDuration = 150;

  final double _switchBorderRadius = 12.5;

  final double _thumbBorderRadius = 100.0;

  final double _switchWidthBorder = 0.5;

  /// main build
  @override
  Widget build(BuildContext context) {
    /// small size toggle init
    if (widget.isSmallToggle) {
      _switchWidth = 44.0;
      _switchHeight = 20.0;
      _thumbSize = 14.0;
    } else {
      _switchWidth = 48.0;
      _switchHeight = 24.0;
      _thumbSize = 18.0;
    }

    return Container(
      child: _switchButton(),
    );
  }

  /// custom switch button
  _switchButton() {
    Color backgroundColor =
        (widget.value) ? widget.activeColor : widget.inActiveColor;

    return Row(
      children: [
        (widget.enableOutsideText)
            ? (!widget.value)
                ? Container(
                    padding: const EdgeInsets.only(right: 5),
                    child: const Text("off"),
                  )
                : Container()
            : Container(),
        GestureDetector(
          child: AnimatedContainer(
            duration: Duration(milliseconds: _animationDuration),
            width: _switchWidth,
            height: _switchHeight,
            alignment:
                (widget.value) ? Alignment.centerRight : Alignment.centerLeft,
            decoration: BoxDecoration(
              color: backgroundColor,
              image: _backgroundDecorationImage(),
              borderRadius: BorderRadius.circular(_switchBorderRadius),
              border: Border.all(
                  color: ColorList.lightBlue10Color, width: _switchWidthBorder),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(_switchBorderRadius),
              child: _circleView(),
            ),
          ),
          onTap: () {
            widget.onChanged(!widget.value);
          },
        ),
        (widget.enableOutsideText)
            ? (widget.value)
                ? Container(
                    padding: const EdgeInsets.only(left: 5),
                    child: const Text("on"),
                  )
                : Container()
            : Container(),
      ],
    );
  }

  /// active and in-active thumb view
  _circleView() {
    Color iconColor =
        widget.value ? widget.activeThumbColor : widget.inActiveThumbColor;

    return Container(
      height: _thumbSize,
      width: _thumbSize,
      margin: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        image: _thumbDecorationImage(),
        color: iconColor,
        borderRadius: BorderRadius.circular(_thumbBorderRadius),
      ),
    );
  }

  /// image view
  /// should pass the both [widget.activeImagePath] and [widget.inActiveImagePath],
  /// else it won't add the image and it'll return the null
  DecorationImage? _backgroundDecorationImage() {
    String? image =
        (widget.value) ? widget.activeImagePath : widget.inActiveImagePath;
    if (_checkBackgroundDecorationImage() && image != null) {
      return DecorationImage(image: AssetImage(image), fit: BoxFit.cover);
    }
    return null;
  }

  /// thumb image view
  ///  /// should pass the both [widget.activeThumbImagePath] and [widget.inActiveThumbImagePath],
  /// else it won't add the image and it'll return the null
  DecorationImage? _thumbDecorationImage() {
    if (((widget.activeThumbImagePath != null &&
            (widget.activeThumbImagePath ?? '').isNotEmpty) &&
        (widget.inActiveThumbImagePath != null &&
            (widget.inActiveThumbImagePath ?? '').isNotEmpty))) {
      return DecorationImage(
          image: AssetImage((widget.value)
              ? widget.activeThumbImagePath!
              : widget.inActiveThumbImagePath!),
          fit: BoxFit.cover);
    }
    return null;
  }

  bool _checkBackgroundDecorationImage() {
    return ((widget.activeImagePath != null &&
            (widget.activeImagePath ?? '').isNotEmpty) &&
        (widget.inActiveImagePath != null &&
            (widget.inActiveImagePath ?? '').isNotEmpty));
  }
}
