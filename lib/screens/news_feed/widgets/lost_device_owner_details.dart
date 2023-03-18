import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_device/screens/widgets/app_custom_text_widget.dart';
import 'package:my_device/shared/constants/app_texts.dart';
import 'package:my_device/shared/utils/app_fade_animation.dart';
import 'package:my_device/shared/utils/app_screen_utils.dart';
import 'package:my_device/shared/utils/type_defs.dart';
import 'package:my_device/theme/app_theme.dart';

class LostDeviceOwnerDetails extends ConsumerWidget {
  const LostDeviceOwnerDetails({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => Padding(
      padding: AppScreenUtils.defaultPadding,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        //! BAR
        Center(
            child: Container(
                height: 4.0.h,
                width: 45.0.w,
                decoration: BoxDecoration(
                    color: AppColours.appBlack,
                    borderRadius: BorderRadius.circular(12.0.r)))),

        //! SPACER
        AppScreenUtils.verticalSpaceTiny,

        //! TITLE
        AppTextWidget(
            textColour: AppColours.appBlack,
            theText: AppTexts.lostDevice,
            textType: AppTextType.boldBody),

        //! SPACER
        AppScreenUtils.verticalSpaceTiny,

        //! NOTE
        AppTextWidget(
            textColour: AppColours.appBlack,
            theText: AppTexts.lostDeviceNotice,
            textType: null),

        //! SPACER
        AppScreenUtils.verticalSpaceTiny,

        //! SPACER
        const Spacer(),

        //! NOTE
        AppTextWidget(
            textColour: AppColours.appBlack,
            theText: AppTexts.noteToMarkAsFound,
            textType: null),

        //! SPACER
        AppScreenUtils.verticalSpaceTiny,

        //! LOG OUT
        AppFadeAnimation(
            delay: 1.6,
            child: SizedBox(
                width: double.infinity,
                height: 45.0.h,
                child: ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const AppTextWidget(
                        theText: AppTexts.markAsFound, textType: null))))
      ]));
}
