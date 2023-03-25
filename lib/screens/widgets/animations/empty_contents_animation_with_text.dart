import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_device/screens/widgets/animations/empty_contents_animation.dart';
import 'package:my_device/screens/widgets/app_custom_text_widget.dart';
import 'package:my_device/shared/utils/app_screen_utils.dart';
import 'package:my_device/shared/utils/type_defs.dart';

class EmptyContentsWithTextAnimationView extends ConsumerWidget {
  final String text;
  const EmptyContentsWithTextAnimationView({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const EmptyContentAnimation(),

          //! SPACER
          AppScreenUtils.verticalSpaceTiny,

          AppTextWidget(theText: text, textType: AppTextType.regularBody),

          //! SPACER
          AppScreenUtils.verticalSpaceLarge,
          //! SPACER
          AppScreenUtils.verticalSpaceLarge
        ]);
  }
}
