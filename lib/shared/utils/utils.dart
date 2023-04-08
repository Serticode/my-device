import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_device/shared/utils/app_extensions.dart';
import 'package:my_device/shared/utils/type_defs.dart';
import 'package:my_device/theme/app_theme.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class AppUtils {
//! IMAGE PICKER
  static Future<File?> pickImage() async {
    try {
      //! INITIALIZE PICKER THEN; PICK IMAGE OR TAKE PHOTO
      final XFile? userImage =
          await ImagePicker().pickImage(source: ImageSource.gallery);

      File? imageTemp = userImage?.path != null ? File(userImage!.path) : null;

      return imageTemp;
    } on PlatformException catch (error) {
      "Failed to pick images: $error".log();
      return null;
    }
  }

  //! GET DEVICE TYPE
  static String fetchDeviceType() {
    final MediaQueryData data =
        MediaQueryData.fromWindow(WidgetsBinding.instance.window);
    return data.size.shortestSide < 600 ? "phone" : "tablet";
  }

  //! SHOW BANNER
  static showBanner(
      {required BuildContext context,
      required String theMessage,
      required NotificationType theType}) {
    ScaffoldMessenger.of(context).showMaterialBanner(MaterialBanner(
        elevation: 2.0.sp,
        shadowColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        padding: EdgeInsets.symmetric(vertical: 20.0.h, horizontal: 25.0.w),
        forceActionsBelow: true,
        backgroundColor: theType == NotificationType.failure
            ? Colors.red.shade500
            : theType == NotificationType.success
                ? Colors.green
                : AppColours.appBlack,

        //! THE CONTENT
        content: Text(theMessage,
            style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: AppColours.appWhite)),

        //! ACTIONS - DISMISS BUTTON
        actions: [
          SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () =>
                      ScaffoldMessenger.of(context).hideCurrentMaterialBanner(),
                  style: ElevatedButton.styleFrom(
                      elevation: 0.0,
                      padding: const EdgeInsets.all(12.0),
                      shadowColor: Colors.transparent,
                      backgroundColor: Colors.white24,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(21.0.r))),
                  child: Text("Dismiss",
                      style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColours.appWhite))))
        ]));

    //! DISMISS AFTER 2 SECONDS
    Timer(const Duration(milliseconds: 1700),
        () => ScaffoldMessenger.of(context).hideCurrentMaterialBanner());
  }

  //! SHOW A MODAL BOTTOM SHEET
  static showAppBottomSheet(
          {required BuildContext context,
          required double height,
          required double width,
          required Widget child,
          required void Function() whenComplete}) =>
      showBottomSheet(
          context: context,
          elevation: 21.0.h,
          enableDrag: true,
          constraints:
              BoxConstraints(maxWidth: width * 0.9, minWidth: width * 0.9),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(21.0.r),
              side: BorderSide(width: 2.0.sp, color: AppColours.appGreyFaint)),
          builder: (context) => Container(
              height: height,
              width: width * 0.85,
              margin: EdgeInsets.symmetric(vertical: 6.0.h, horizontal: 6.0.w),
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(21.0.r)),
              child: child)).closed.whenComplete(() => whenComplete());

  //! GET DEVICE DEFAULT IMAGE
  static Icon getDeviceIcons({required int index}) {
    switch (DeviceType.values.elementAt(index)) {
      case DeviceType.fan:
        return Icon(PhosphorIcons.windBold,
            color: AppColours.appWhite, size: 22.0.sp);
      case DeviceType.iPad:
        return Icon(PhosphorIcons.tabsBold,
            color: AppColours.appWhite, size: 22.0.sp);
      case DeviceType.fridge:
        return Icon(PhosphorIcons.snowflakeBold,
            color: AppColours.appWhite, size: 22.0.sp);
      case DeviceType.gameConsole:
        return Icon(PhosphorIcons.gameControllerBold,
            color: AppColours.appWhite, size: 22.0.sp);
      case DeviceType.homePod:
        return Icon(PhosphorIcons.speakerSimpleHighBold,
            color: AppColours.appWhite, size: 22.0.sp);
      case DeviceType.iWatch:
        return Icon(PhosphorIcons.timerBold,
            color: AppColours.appWhite, size: 22.0.sp);
      case DeviceType.iphone:
        return Icon(PhosphorIcons.phoneBold,
            color: AppColours.appWhite, size: 22.0.sp);
      case DeviceType.laptop:
        return Icon(PhosphorIcons.laptopBold,
            color: AppColours.appWhite, size: 22.0.sp);
      case DeviceType.monitor:
        return Icon(PhosphorIcons.monitorBold,
            color: AppColours.appWhite, size: 22.0.sp);
      case DeviceType.smartPhone:
        return Icon(PhosphorIcons.phone,
            color: AppColours.appWhite, size: 22.0.sp);
      case DeviceType.smartSpeaker:
        return Icon(PhosphorIcons.speakerSimpleHighBold,
            color: AppColours.appWhite, size: 22.0.sp);
      case DeviceType.smartWatch:
        return Icon(PhosphorIcons.watchBold,
            color: AppColours.appWhite, size: 22.0.sp);
      case DeviceType.speaker:
        return Icon(PhosphorIcons.speakerHighBold,
            color: AppColours.appWhite, size: 22.0.sp);
      case DeviceType.tab:
        return Icon(PhosphorIcons.deviceTabletBold,
            color: AppColours.appWhite, size: 22.0.sp);
      default:
        return Icon(PhosphorIcons.phoneBold,
            color: AppColours.appWhite, size: 22.0.sp);
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

  static DeviceType getDeviceTypeFromName({required String deviceTypeName}) {
    late DeviceType deviceType;

    List<String> placeHolder = deviceTypeName.toLowerCase().split(" ");

    for (DeviceType element in DeviceType.values) {
      placeHolder.contains(element.name.toLowerCase())
          ? deviceType = element
          : {};
    }

    "Device Type: $deviceType".log();

    return deviceType;
  }
}
