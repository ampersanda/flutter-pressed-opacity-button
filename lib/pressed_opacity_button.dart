library pressed_opacity_button;

import 'package:flutter/widgets.dart';

class PressedOpacityButton extends StatefulWidget {
  const PressedOpacityButton({
    Key key,
    @required this.onPressed,
    @required this.child,
    this.pressedOpacity = 0.6,
    this.backgroundColor = const Color(0xFFFFFFFF),
    this.pressedBackgroundColor = const Color(0xFFF1F1F1),
  })  : assert(pressedOpacity >= 0.0 && pressedOpacity <= 1.0),
        super(key: key);

  final VoidCallback onPressed;
  final Widget child;
  final double pressedOpacity;
  final Color backgroundColor, pressedBackgroundColor;

  @override
  _PressedOpacityButtonState createState() => _PressedOpacityButtonState();
}

class _PressedOpacityButtonState extends State<PressedOpacityButton> {
  bool _isPressing = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.backgroundColor,
      child: GestureDetector(
        onTapUp: widget.onPressed != null ? _onTapUp : null,
        onTapCancel: widget.onPressed != null ? _onTapCancel : null,
        onTapDown: widget.onPressed != null ? _onTapDown : null,
        onTap: widget.onPressed,
        child: Semantics(
          button: true,
          child: Opacity(
            opacity: _isPressing && widget.onPressed != null
                ? widget.pressedOpacity
                : 1.0,
            child: Container(
              color: _isPressing
                  ? widget.pressedBackgroundColor
                  : widget.backgroundColor,
              child: widget.child,
            ),
          ),
        ),
      ),
    );
  }

  void _onTapUp(TapUpDetails details) {
    setState(() => _isPressing = false);
  }

  void _onTapCancel() {
    setState(() => _isPressing = false);
  }

  void _onTapDown(TapDownDetails details) {
    setState(() => _isPressing = true);
  }
}
