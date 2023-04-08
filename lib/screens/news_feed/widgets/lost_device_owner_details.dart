import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_device/screens/news_feed/widgets/lost_device_field_item.dart';
import 'package:my_device/screens/widgets/app_custom_text_widget.dart';
import 'package:my_device/services/models/auth/user_model/user_model.dart';
import 'package:my_device/services/models/device/device_model.dart';
import 'package:my_device/services/providers/device_owner/device_owner_provider.dart';
import 'package:my_device/shared/constants/app_texts.dart';
import 'package:my_device/shared/utils/app_extensions.dart';
import 'package:my_device/shared/utils/app_fade_animation.dart';
import 'package:my_device/shared/utils/app_screen_utils.dart';
import 'package:my_device/shared/utils/type_defs.dart';
import 'package:my_device/theme/app_theme.dart';

class OwnerDetailsForLostDevices extends ConsumerWidget {
  final DeviceModel theDevice;
  const OwnerDetailsForLostDevices({required this.theDevice, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
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

          //! TITLE
          AppTextWidget(
              textColour: AppColours.appBlack,
              theText: AppTexts.lostDevice,
              textType: AppTextType.boldBody),

          //! SPACER
          AppScreenUtils.verticalSpaceTiny,

          //! NOTE
          AppTextWidget(
              textColour: AppColours.appBlack,
              theText: AppTexts.lostDeviceNotice,
              textType: null),

          //! SPACER
          AppScreenUtils.verticalSpaceSmall,

          // //! CONTENT
          Expanded(
              child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: LostDeviceFieldsItem(lostDevice: theDevice))),

          //! SPACER
          AppScreenUtils.verticalSpaceTiny,

          //! NOTE
          AppTextWidget(
              textColour: AppColours.appBlack,
              theText: AppTexts.noteToMarkAsFound,
              textType: null),

          //! SPACER
          AppScreenUtils.verticalSpaceTiny,

          //! MARK AS FOUND
          AppFadeAnimation(
              delay: 1.6,
              child: SizedBox(
                  width: double.infinity,
                  height: 45.0.h,
                  child: ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const AppTextWidget(
                          theText: AppTexts.markAsFound, textType: null))))
        ]));
  }
}
