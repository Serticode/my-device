import 'package:my_device/screens/widgets/animations/animation_wrapper.dart';
import 'package:my_device/shared/utils/type_defs.dart';

class LoadingAnimation extends AnimationWrapper {
  const LoadingAnimation({super.key})
      : super(animation: LottieAnimation.loading);
}
