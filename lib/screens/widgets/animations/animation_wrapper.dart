import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:my_device/shared/utils/type_defs.dart';

class AnimationWrapper extends StatelessWidget {
  final LottieAnimation animation;
  final bool repeat;
  final bool reverse;
  const AnimationWrapper({
    super.key,
    required this.animation,
    this.repeat = true,
    this.reverse = false,
  });

  @override
  Widget build(BuildContext context) => Lottie.asset(animation.fullPath,
      reverse: reverse,
      repeat: repeat,
      fit: BoxFit.contain,
      filterQuality: FilterQuality.high,
      alignment: Alignment.center);
}

extension GetFullPath on LottieAnimation {
  String get fullPath => 'lib/assets/animations/$name.json';
}
