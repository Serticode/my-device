import 'package:flutter/material.dart';
import 'package:my_device/theme/app_theme.dart';

class AnimatedButton extends StatelessWidget {
  final double height;
  final double width;
  final double radius;
  final void Function()? onTap;
  final Widget content;
  final Color? colour;
  final BoxBorder? border;
  const AnimatedButton({
    Key? key,
    required this.height,
    required this.width,
    required this.radius,
    this.onTap,
    required this.content,
    this.colour,
    this.border,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onTap,
        child: AnimatedContainer(
            duration: const Duration(milliseconds: 700),
            curve: Curves.fastOutSlowIn,
            height: height,
            width: width,
            decoration: BoxDecoration(
                color: colour ?? AppColours.appBlue,
                borderRadius: BorderRadius.circular(radius),
                border: border),
            child: content));
  }
}
