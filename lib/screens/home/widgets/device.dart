import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_device/screens/widgets/app_custom_text_widget.dart';
import 'package:my_device/services/models/device/device_model.dart';
import 'package:my_device/shared/utils/app_screen_utils.dart';
import 'package:my_device/shared/utils/type_defs.dart';
import 'package:my_device/shared/utils/utils.dart';
import 'package:my_device/theme/app_theme.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
//! EACH DEVICE HAS A NAME, MODEL NUMBER, SERIAL NUMBER, COLOUR, TYPE
//! EACH DEVICE WIDGET WILL SHOW THE DEVICE IMAGE, DEVICE NAME, DEVICE TYPE, AND DEVICE SERIAL NUMBER

class Device extends ConsumerWidget {
  final void Function() onTap;
  final void Function() delete;
  final bool? canDelete;
  final DeviceModel device;
  const Device(
      {super.key,
      required this.delete,
      required this.onTap,
      required this.device,
      this.canDelete});

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
                  height: 60.0.h,
                  width: 55.0.w,
                  decoration: BoxDecoration(
                      color: AppColours.appGreyFaint.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12.0.r),
                      border: Border.all(
                          width: 1.2, color: AppColours.appGreyFaint)),
                  child: device.deviceImages == null ||
                          device.deviceImages!.isEmpty
                      ? AppUtils.getDeviceIcons(
                          index: DeviceType.values.indexWhere(
                              (element) => element.name == device.deviceType))
                      : Image.asset("")),

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

                    //! DEVICE TYPE
                    AppTextWidget(
                        theText: device.deviceType ??
                            DeviceType.values.elementAt(0).name,
                        textType: null)
                  ]),

                  //! SPACER
                  AppScreenUtils.horizontalSpaceSmall,

                  //! SERIAL NUMBER.
                  AppTextWidget(theText: device.serialNumber!, textType: null)
                ])
              ]),

              //! SPACER
              const Spacer(),

              //! DELETE ICON
              canDelete != null && canDelete == false
                  ? const SizedBox.shrink()
                  : IconButton(
                      onPressed: () => delete(),
                      icon: Icon(PhosphorIcons.trashSimpleFill,
                          size: 16.0.sp, color: AppColours.appWhite))
            ])));
  }
}
