import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_device/theme/app_theme.dart';

class AppDivider extends StatelessWidget {
  final bool? isVertical;
  const AppDivider({super.key, this.isVertical});

  @override
  Widget build(BuildContext context) => isVertical != null && isVertical == true
      ? VerticalDivider(
          width: 2.0.w,
          color: AppColours.appGrey.withOpacity(0.3),
          thickness: 0.8.sp)
      : Divider(
          height: 2.0.h,
          color: AppColours.appGrey.withOpacity(0.3),
          thickness: 0.8.sp);
}
