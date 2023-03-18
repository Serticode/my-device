import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_device/screens/widgets/app_custom_text_widget.dart';
import 'package:my_device/shared/constants/app_texts.dart';
import 'package:my_device/shared/utils/app_fade_animation.dart';
import 'package:my_device/shared/utils/app_screen_utils.dart';
import 'package:my_device/shared/utils/type_defs.dart';
import 'package:my_device/theme/app_theme.dart';

class ReportAProblem extends ConsumerWidget {
  const ReportAProblem({super.key});
  static final ValueNotifier<TextEditingController> textController =
      ValueNotifier(TextEditingController());

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
            theText: AppTexts.reportAProblem,
            textType: AppTextType.boldBody),

        //! SPACER
        AppScreenUtils.verticalSpaceTiny,

        //! MAIN CONTENT
        Expanded(
            child: TextFormField(
                controller: textController.value,
                textAlign: TextAlign.justify,
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: AppColours.appBlack),
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                        vertical: 8.0.h, horizontal: 12.0.w)),
                maxLines: 10,
                maxLength: 350)),

        //! SPACER
        AppScreenUtils.verticalSpaceTiny,

        //! SUBMIT
        AppFadeAnimation(
            delay: 1.6,
            child: SizedBox(
                width: double.infinity,
                height: 45.0.h,
                child: ElevatedButton(
                    onPressed: () {
                      textController.dispose();
                      Navigator.of(context).pop();
                    },
                    child: const AppTextWidget(
                        theText: AppTexts.submit,
                        textType: AppTextType.regularBody))))
      ]));
}
