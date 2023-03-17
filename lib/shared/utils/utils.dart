import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_device/shared/utils/type_defs.dart';
import 'package:my_device/theme/app_theme.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class AppUtils {
  //! GET DEVICE DEFAULT IMAGE
  static Icon getDeviceIcons({required int index}) {
    switch (DeviceType.values.elementAt(index)) {
      case DeviceType.fan:
        return Icon(PhosphorIcons.windBold,
            color: AppColours.appWhite, size: 26.0.sp);
      case DeviceType.iPad:
        return Icon(PhosphorIcons.tabsBold,
            color: AppColours.appWhite, size: 26.0.sp);
      case DeviceType.fridge:
        return Icon(PhosphorIcons.snowflakeBold,
            color: AppColours.appWhite, size: 26.0.sp);
      case DeviceType.gameConsole:
        return Icon(PhosphorIcons.gameControllerBold,
            color: AppColours.appWhite, size: 26.0.sp);
      case DeviceType.homePod:
        return Icon(PhosphorIcons.speakerSimpleHighBold,
            color: AppColours.appWhite, size: 26.0.sp);
      case DeviceType.iWatch:
        return Icon(PhosphorIcons.timerBold,
            color: AppColours.appWhite, size: 26.0.sp);
      case DeviceType.iphone:
        return Icon(PhosphorIcons.phoneBold,
            color: AppColours.appWhite, size: 26.0.sp);
      case DeviceType.laptop:
        return Icon(PhosphorIcons.laptopBold,
            color: AppColours.appWhite, size: 26.0.sp);
      case DeviceType.monitor:
        return Icon(PhosphorIcons.monitorBold,
            color: AppColours.appWhite, size: 26.0.sp);
      case DeviceType.smartPhone:
        return Icon(PhosphorIcons.phone,
            color: AppColours.appWhite, size: 26.0.sp);
      case DeviceType.smartSpeaker:
        return Icon(PhosphorIcons.speakerSimpleHighBold,
            color: AppColours.appWhite, size: 26.0.sp);
      case DeviceType.smartWatch:
        return Icon(PhosphorIcons.watchBold,
            color: AppColours.appWhite, size: 26.0.sp);
      case DeviceType.speaker:
        return Icon(PhosphorIcons.speakerHighBold,
            color: AppColours.appWhite, size: 26.0.sp);
      case DeviceType.tab:
        return Icon(PhosphorIcons.tabsFill,
            color: AppColours.appWhite, size: 26.0.sp);
      default:
        return Icon(PhosphorIcons.phoneBold,
            color: AppColours.appWhite, size: 26.0.sp);
    }
  }

  //! GET DEVICE DEFAULT IMAGE
  static String getDeviceType({required int index}) {
    switch (DeviceType.values.elementAt(index)) {
      case DeviceType.fan:
        return "Fan";
      case DeviceType.iPad:
        return "iPad";
      case DeviceType.fridge:
        return "Fridge";
      case DeviceType.gameConsole:
        return "Game console";
      case DeviceType.homePod:
        return "Home pod speaker";
      case DeviceType.iWatch:
        return "Apple iWatch";
      case DeviceType.iphone:
        return "Apple iPhone";
      case DeviceType.laptop:
        return "Laptop";
      case DeviceType.monitor:
        return "Monitor";
      case DeviceType.smartPhone:
        return "Smartphone";
      case DeviceType.smartSpeaker:
        return "Smart speaker";
      case DeviceType.smartWatch:
        return "Smart watch";
      case DeviceType.speaker:
        return "Speaker";
      case DeviceType.tab:
        return "Tablet";
      default:
        return "Smartphone";
    }
  }

  /* //! SHOW A MODAL BOTTOM SHEET
  static showAppBottomSheet(
          {required BuildContext context,
          required double height,
          required double width,
          required Widget child}) =>
      showBottomSheet(
          context: context,
          elevation: 21.0.h,
          enableDrag: true,
          constraints:
              BoxConstraints(maxWidth: width * 0.9, minWidth: width * 0.9),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0.r),
              side: BorderSide(width: 2.0.sp, color: AppColours.appGreyFaint)),
          builder: (context) => Container(
              height: height,
              width: width * 0.85,
              margin: EdgeInsets.symmetric(vertical: 6.0.h, horizontal: 6.0.w),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0.r),
                  color: AppColours.appWhite),
              child: child)); */
}
