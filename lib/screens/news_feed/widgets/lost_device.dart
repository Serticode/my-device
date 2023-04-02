import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_device/screens/home/widgets/show_device_image.dart';
import 'package:my_device/screens/widgets/app_custom_text_widget.dart';
import 'package:my_device/services/models/device/device_model.dart';
import 'package:my_device/shared/utils/app_screen_utils.dart';
import 'package:my_device/shared/utils/type_defs.dart';
import 'package:my_device/shared/utils/utils.dart';
import 'package:my_device/theme/app_theme.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
//! EACH DEVICE HAS A NAME, MODEL NUMBER, SERIAL NUMBER, COLOUR, TYPE
//! EACH DEVICE WIDGET WILL SHOW THE DEVICE IMAGE, DEVICE NAME, DEVICE TYPE, AND DEVICE SERIAL NUMBER

class LostDevice extends ConsumerWidget {
  final void Function() onTap;
  final int index;
  final DeviceModel device;
  const LostDevice(
      {super.key,
      required this.onTap,
      required this.index,
      required this.device});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 12.0.h),
        child: InkWell(
            onTap: () => onTap(),
            hoverColor: Colors.transparent,
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            child: Row(children: [
              //! DEVICE IMAGE
              Container(
                  height: 50.0.h,
                  width: 45.0.w,
                  decoration: BoxDecoration(
                      color: AppColours.appGreyFaint.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12.0.r),
                      border: Border.all(
                          width: 1.2, color: AppColours.appGreyFaint)),
                  child: device.deviceImages == null ||
                          device.deviceImages!.isEmpty
                      ? AppUtils.getDeviceIcons(index: index)
                      : ShowDeviceImage(devicePictures: device.deviceImages!)),

              //! SPACER
              AppScreenUtils.horizontalSpaceSmall,

              //! DEVICE NAME, SERIAL NUMBER, AND TYPE
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                //! DEVICE NAME
                AppTextWidget(
                    theText: device.deviceName!,
                    textType: AppTextType.regularBody),

                //! SPACER
                AppScreenUtils.verticalSpaceSmall,

                //! TYPE AND SERIAL NUMBER
                Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  //! DEVICE TYPE
                  Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                    //! ICON
                    Icon(PhosphorIcons.infoBold,
                        color: AppColours.appGreyFaint, size: 16.0.sp),

                    //! SPACER
                    AppScreenUtils.horizontalSpaceTiny,

                    //! TEXT
                    AppTextWidget(theText: device.deviceType!, textType: null)
                  ]),

                  //! SPACER
                  AppScreenUtils.horizontalSpaceSmall,

                  //! SERIAL NUMBER.
                  AppTextWidget(theText: device.serialNumber!, textType: null)
                ])
              ]),

              //! SPACER
              const Spacer(),
            ])));
  }
}
