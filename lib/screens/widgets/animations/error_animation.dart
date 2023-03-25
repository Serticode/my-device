import 'package:my_device/screens/widgets/animations/animation_wrapper.dart';
import 'package:my_device/shared/utils/type_defs.dart';

class ErrorAnimation extends AnimationWrapper {
  const ErrorAnimation({super.key})
      : super(animation: LottieAnimation.smallError);
}
