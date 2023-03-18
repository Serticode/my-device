import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_device/screens/widgets/app_custom_text_widget.dart';
import 'package:my_device/shared/utils/app_screen_utils.dart';
import 'package:my_device/shared/utils/type_defs.dart';
import 'package:my_device/theme/app_theme.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class ProfileItem extends ConsumerWidget {
  final String title;
  final IconData icon;
  const ProfileItem({
    super.key,
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
        padding: AppScreenUtils.defaultPadding,
        height: 55.0.h,
        margin: EdgeInsets.symmetric(vertical: 8.0.h),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0.r),
            color: AppColours.appGreyFaint.withOpacity(0.1),
            border: Border.all(
              color: AppColours.appGreyFaint.withOpacity(0.4),
            )),
        child: Row(children: [
          //! ICON / IMAGE
          Icon(icon, color: AppColours.appGreyFaint),

          //! SPACER
          AppScreenUtils.horizontalSpaceSmall,

          //! TITLE
          AppTextWidget(theText: title, textType: AppTextType.regularBody),

          //! SPACER
          const Spacer(),

          //! ICON
          const Icon(PhosphorIcons.caretRightBold,
              color: AppColours.appGreyFaint)
        ]));
  }
}
