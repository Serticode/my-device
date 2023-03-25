import 'package:my_device/screens/widgets/animations/animation_wrapper.dart';
import 'package:my_device/shared/utils/type_defs.dart';

class EmptyContentAnimation extends AnimationWrapper {
  const EmptyContentAnimation({super.key})
      : super(animation: LottieAnimation.dataIsEmpty);
}
