import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_device/screens/home/widgets/app_bar.dart';
import 'package:my_device/screens/home/widgets/device.dart';
import 'package:my_device/screens/widgets/app_custom_text_widget.dart';
import 'package:my_device/services/models/device/device_model.dart';
import 'package:my_device/shared/constants/app_divider.dart';
import 'package:my_device/shared/constants/app_texts.dart';
import 'package:my_device/shared/utils/app_extensions.dart';
import 'package:my_device/shared/utils/app_fade_animation.dart';
import 'package:my_device/shared/utils/app_screen_utils.dart';
import 'package:my_device/shared/utils/type_defs.dart';

class DeletedDevices extends ConsumerWidget {
  const DeletedDevices({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(75.0.h),
            child: AppBarWidget(
                onTap: () => "App Bar onTap".log(),
                isDeletedDevicesScreen: true,
                currentPage: 0)),
        //! CONTENT
        body: SafeArea(
            child: Padding(
                padding: AppScreenUtils.defaultPadding,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //! TITLE
                      const AppTextWidget(
                          theText: AppTexts.deletedDevices,
                          textType: AppTextType.subtitle),

                      //! SPACER
                      AppScreenUtils.verticalSpaceTiny,

                      //! CONTENT
                      Expanded(
                          child: ListView.separated(
                              itemCount: 7,
                              physics: const BouncingScrollPhysics(),
                              separatorBuilder: (context, index) =>
                                  const AppDivider(isVertical: false),
                              itemBuilder: (context, index) => Device(
                                    onTap: () {},
                                    delete: () {},
                                    device: DeviceModel(),
                                    canDelete: false,
                                  ))),

                      //! SPACER
                      AppScreenUtils.verticalSpaceTiny,

                      //! GO BACK
                      AppFadeAnimation(
                          delay: 1.6,
                          child: SizedBox(
                              width: double.infinity,
                              height: 45.0.h,
                              child: ElevatedButton(
                                  onPressed: () => Navigator.of(context).pop(),
                                  child: const AppTextWidget(
                                      theText: AppTexts.goBack,
                                      textType: AppTextType.regularBody))))
                    ]))));
  }
}
