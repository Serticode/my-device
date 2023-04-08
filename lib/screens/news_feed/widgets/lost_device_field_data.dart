import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_device/shared/utils/app_screen_utils.dart';
import 'package:my_device/theme/app_theme.dart';

class LostDeviceFieldsData extends ConsumerWidget {
  final String theKey;
  final String value;
  const LostDeviceFieldsData(
      {required this.theKey, required this.value, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
        height: 60.0.h,
        width: double.infinity,
        padding: AppScreenUtils.defaultPadding,
        decoration: BoxDecoration(
            color: AppColours.appGreyFaint.withOpacity(0.5),
            borderRadius: BorderRadius.circular(6.0.r)),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          //! KEY
          Text(theKey,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: AppColours.appBlack)),

          //! SPACER
          AppScreenUtils.horizontalSpaceSmall,

          //! VALUE
          Text(value,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: AppColours.appBlack, fontSize: 14.0.sp))
        ]));
  }
}
