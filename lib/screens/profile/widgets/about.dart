import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_device/screens/widgets/app_custom_text_widget.dart';
import 'package:my_device/shared/constants/app_texts.dart';
import 'package:my_device/shared/utils/app_screen_utils.dart';
import 'package:my_device/shared/utils/type_defs.dart';
import 'package:my_device/theme/app_theme.dart';

class About extends ConsumerWidget {
  const About({super.key});

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

        //! title
        AppTextWidget(
            textColour: AppColours.appBlack,
            theText: AppTexts.aboutUs,
            textType: AppTextType.boldBody),

        //! SPACER
        AppScreenUtils.verticalSpaceTiny,

        //! MAIN CONTENT
        Expanded(
            child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: AppTextWidget(
                    textColour: AppColours.appBlack,
                    theText: AppTexts.aboutUsNote,
                    textType: AppTextType.regularBody)))
      ]));
}
