import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_device/screens/widgets/app_custom_text_widget.dart';
import 'package:my_device/services/models/device/device_model.dart';
import 'package:my_device/services/providers/user_devices_controller/user_devices_controller_provider.dart';
import 'package:my_device/shared/constants/app_texts.dart';
import 'package:my_device/shared/utils/app_extensions.dart';
import 'package:my_device/shared/utils/app_fade_animation.dart';
import 'package:my_device/shared/utils/app_screen_utils.dart';
import 'package:my_device/shared/utils/type_defs.dart';
import 'package:my_device/shared/utils/utils.dart';
import 'package:my_device/theme/app_theme.dart';

class ViewDeviceScreen extends ConsumerWidget {
  final String? deviceImage;
  final int? index;
  final DeviceModel device;
  const ViewDeviceScreen(
      {super.key, this.index, this.deviceImage, required this.device});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: false,
            elevation: 0.0.h,
            shadowColor: Colors.transparent,
            title: const AppTextWidget(
                theText: "View Device", textType: AppTextType.boldBody)),

        //! CONTENT
        body: SafeArea(
            child: Padding(
                padding: AppScreenUtils.defaultPadding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //! DEVICE IMAGE
                    Container(
                        height: MediaQuery.of(context).size.height * 0.3,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: AppColours.appGreyFaint.withOpacity(0.2),
                            border: Border.all(
                                color: AppColours.appGreyFaint.withOpacity(0.4),
                                width: 2.0.sp),
                            borderRadius: BorderRadius.circular(25.0.r)),
                        child: device.deviceImages == null ||
                                device.deviceImages!.isEmpty
                            ? Transform.scale(
                                scale: 2.0,
                                child: AppUtils.getDeviceIcons(
                                    index: DeviceType.values.indexWhere(
                                        (element) =>
                                            element.name == device.deviceType)))
                            : Image.asset("")),

                    //! SPACER
                    AppScreenUtils.verticalSpaceTiny,

                    //! DEVICE NAME
                    AppFadeAnimation(
                        delay: 1.6,
                        child: AppTextWidget(
                            theText: device.deviceName ?? "Device",
                            textType: AppTextType.subtitle)),

                    //! SPACER
                    AppScreenUtils.verticalSpaceTiny,

                    //! OTHER DEVICE DETAILS
                    Expanded(
                        child: Container(
                            padding: AppScreenUtils.defaultPadding,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: AppColours.appGreyFaint.withOpacity(0.1),
                                border: Border.all(
                                    color: AppColours.appGreyFaint
                                        .withOpacity(0.4),
                                    width: 2.0.sp),
                                borderRadius: BorderRadius.circular(25.0.r)),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  //! DEVICE TYPE
                                  DeviceDetail(
                                      label: "Device type",
                                      value: AppUtils.getDeviceType(
                                          index: DeviceType.values.indexWhere(
                                              (element) =>
                                                  element.name ==
                                                  device.deviceType))),

                                  //! SPACER
                                  AppScreenUtils.verticalSpaceSmall,

                                  //! DEVICE MODEL NUMBER
                                  DeviceDetail(
                                      label: "Model number",
                                      value: device.modelNumber ??
                                          "No registered model number"),

                                  //! SPACER
                                  AppScreenUtils.verticalSpaceSmall,

                                  //! DEVICE SERIAL NUMBER
                                  DeviceDetail(
                                      label: "Serial number",
                                      value: device.serialNumber ??
                                          "No registered serial number"),

                                  //! SPACER
                                  AppScreenUtils.verticalSpaceSmall,

                                  //! DEVICE COLOUR
                                  DeviceDetail(
                                      label: "Device colour",
                                      value: device.deviceColour ??
                                          "None submitted"),

                                  //! SPACER
                                  AppScreenUtils.verticalSpaceSmall,

                                  //! DEVICE BRAND
                                  DeviceDetail(
                                      label: "Device brand",
                                      value: device.brand ?? "None registered"),
                                ]))),

                    //! SPACER
                    AppScreenUtils.verticalSpaceTiny,

                    //! BUTTON
                    Row(children: [
                      Expanded(
                          child: AppFadeAnimation(
                              delay: 1.6,
                              child: SizedBox(
                                  width: double.infinity,
                                  height: 45.0.h,
                                  child: ElevatedButton(
                                      onPressed: () async {
                                        "Delete device from View Device screen"
                                            .log();

                                        await ref
                                            .read(deviceControllerProvider
                                                .notifier)
                                            .deleteDevice(
                                                serialNumber:
                                                    device.serialNumber)
                                            .then(
                                                (value) async => value.isRight()
                                                    ? {
                                                        AppUtils.showBanner(
                                                            context: context,
                                                            theMessage:
                                                                "Device deleted successfully",
                                                            theType:
                                                                NotificationType
                                                                    .success),
                                                        await Future.delayed(
                                                            const Duration(
                                                                milliseconds:
                                                                    2100)),
                                                        Navigator.of(context)
                                                            .pop()
                                                      }
                                                    : {})
                                            .catchError((error) => error.log());
                                      },
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: AppColours
                                              .appGreyFaint
                                              .withOpacity(0.1),
                                          side: BorderSide(
                                              width: 2.0.sp,
                                              color: AppColours.appRed)),
                                      child: const AppTextWidget(
                                          theText: AppTexts.delete,
                                          textType:
                                              AppTextType.regularBody))))),

                      //! SPACER
                      AppScreenUtils.horizontalSpaceSmall,

                      Expanded(
                          child: AppFadeAnimation(
                              delay: 1.6,
                              child: SizedBox(
                                  width: double.infinity,
                                  height: 45.0.h,
                                  child: ElevatedButton(
                                      onPressed: () =>
                                          Navigator.of(context).pop(),
                                      child: const AppTextWidget(
                                          theText: AppTexts.goBack,
                                          textType: AppTextType.regularBody)))))
                    ])
                  ],
                ))));
  }
}

//! DEVICE DETAIL WIDGET
class DeviceDetail extends ConsumerWidget {
  final String label;
  final String value;
  const DeviceDetail({
    super.key,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
        padding: AppScreenUtils.defaultPadding,
        width: double.infinity,
        decoration: BoxDecoration(
            color: AppColours.appGreyFaint.withOpacity(0.1),
            border: Border.all(color: AppColours.appGreyFaint, width: 2.0.sp),
            borderRadius: BorderRadius.circular(12.0.r)),
        child: Row(children: [
          //! LABEL
          AppTextWidget(theText: "$label :", textType: AppTextType.regularBody),

          //! SPACER
          AppScreenUtils.horizontalSpaceSmall,

          AppTextWidget(theText: value, textType: AppTextType.regularBody)
        ]));
  }
}
