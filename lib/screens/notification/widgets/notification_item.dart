import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_device/screens/widgets/app_custom_text_widget.dart';
import 'package:my_device/services/models/device/found_device_model.dart';
import 'package:my_device/shared/utils/app_screen_utils.dart';
import 'package:my_device/shared/utils/type_defs.dart';
import 'package:my_device/shared/utils/utils.dart';
import 'package:my_device/theme/app_theme.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class NotificationItem extends ConsumerWidget {
  final FoundDeviceModel foundDevice;
  const NotificationItem({
    super.key,
    required this.foundDevice,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final DateTime dateAndTime =
        DateTime.tryParse(foundDevice.createdAt.toString())!;
    final String foundDate =
        "${AppUtils.getMonth(dateTime: dateAndTime)} ${dateAndTime.day}, ${dateAndTime.year}";
    return Container(
        width: double.infinity,
        height: 200.0.h,
        padding: AppScreenUtils.defaultPadding,
        decoration: BoxDecoration(
            color: AppColours.appGreyFaint.withOpacity(0.2),
            borderRadius: BorderRadius.circular(12.0.r),
            border: Border.all(
                color: AppColours.appWhite.withOpacity(0.5), width: 1.5.sp)),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //! TIME OF DAY
              AppTextWidget(
                  theText: foundDate,
                  textColour: AppColours.appGreyFaint,
                  textType: AppTextType.boldBody),

              //! SPACER
              AppScreenUtils.verticalSpaceTiny,

              Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                CircleAvatar(
                    radius: 24.0.r,
                    backgroundColor: AppColours.appBlue.withOpacity(0.5),
                    child: Icon(PhosphorIcons.bellSimpleRingingBold,
                        size: 18.0.sp)),

                //! SPACER
                AppScreenUtils.horizontalSpaceTiny,

                Flexible(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                      //! TITLE
                      const AppTextWidget(
                          theText: "My Device HQ",
                          textType: AppTextType.regularBody),

                      //! SPACER
                      AppScreenUtils.verticalSpaceTiny,

                      //! NOTICE
                      RichText(
                          textAlign: TextAlign.justify,
                          text: TextSpan(
                              text: "Your device with Serial Number -  ",
                              style: Theme.of(context).textTheme.bodyMedium,
                              children: [
                                TextSpan(
                                    text:
                                        "${foundDevice.device!.serialNumber} has been found. ",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge
                                        ?.copyWith(fontSize: 16.0.sp)),
                                TextSpan(
                                    text:
                                        "Kindly pick it up at the Security 'SOP' office, with your ID card.",
                                    style:
                                        Theme.of(context).textTheme.bodyMedium)
                              ]))
                    ]))
              ])
            ]));
  }
}
