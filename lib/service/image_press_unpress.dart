import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PressUnpress extends StatefulWidget {
  final String? imageAssetUnPress;
  final String? imageAssetPress;
  final VoidCallback onTap;
  final Color? pressColor;
  final Color? unPressColor;
  final double height;
  final double width;
  final Widget? child;
  final Gradient? pressGradient;
  final Gradient? unPressGradient;

  PressUnpress({
    this.imageAssetUnPress,
    this.imageAssetPress,
    required this.onTap,
    required this.height,
    required this.width,
    this.child,
    this.pressColor,
    this.unPressColor,
    this.pressGradient,
    this.unPressGradient
  });

  @override
  _PressUnpressState createState() => _PressUnpressState();
}

class _PressUnpressState extends State<PressUnpress> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
   if(widget.imageAssetPress?.isNotEmpty ?? false)precacheImage(AssetImage(widget.imageAssetPress ?? ''), context);
    return GestureDetector(
      onTapDown: (_) => _handleTap(true),
      onTapUp: (_) => _handleTap(false),
      onTapCancel: _resetTap,
      onTap: (){
        widget.onTap();
      },
      child: buildContainer(),
    );
  }

  void _handleTap(bool isPressed) {
    setState(() {
      _isPressed = isPressed;
    });
  }

  void _resetTap() {
    _handleTap(false);
  }

  Widget buildContainer() {
    return Container(
      height: widget.height,
      width: widget.width,
      decoration: BoxDecoration(
        borderRadius: widget.imageAssetUnPress == null ? BorderRadius.circular(40) : null,
        color: _isPressed ? widget.pressColor : widget.unPressColor,
        gradient: _isPressed ? widget.pressGradient : widget.unPressGradient,
        image: widget.imageAssetUnPress != null && widget.imageAssetUnPress!.isNotEmpty && widget.imageAssetPress != null && widget.imageAssetPress!.isNotEmpty
            ? DecorationImage(
          image: AssetImage(_isPressed ? widget.imageAssetPress! : widget.imageAssetUnPress!),
          fit: BoxFit.contain,
          alignment: Alignment.center
        )
            : null,
      ),
      child: Center(child: widget.child ?? const SizedBox.shrink()),
    );
  }
}
