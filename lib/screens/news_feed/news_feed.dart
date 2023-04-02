import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_device/screens/news_feed/widgets/lost_device.dart';
import 'package:my_device/screens/widgets/animations/empty_contents_animation_with_text.dart';
import 'package:my_device/screens/widgets/animations/error_animation.dart';
import 'package:my_device/screens/widgets/animations/loading_animation.dart';
import 'package:my_device/screens/widgets/app_custom_text_widget.dart';
import 'package:my_device/services/models/device/device_model.dart';
import 'package:my_device/services/providers/lost_devices/lost_devices_provider.dart';
import 'package:my_device/shared/constants/app_divider.dart';
import 'package:my_device/shared/constants/app_texts.dart';
import 'package:my_device/shared/utils/app_screen_utils.dart';
import 'package:my_device/shared/utils/type_defs.dart';
import 'package:my_device/shared/utils/utils.dart';
import 'widgets/lost_device_owner_details.dart';

class NewsFeed extends ConsumerWidget {
  const NewsFeed({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Size screenSize = MediaQuery.of(context).size;
    final AsyncValue<Iterable<DeviceModel>> lostDevices =
        ref.watch(lostDevicesProvider);

    return Padding(
        padding: AppScreenUtils.defaultPadding,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          //! TITLE
          const AppTextWidget(
              theText: AppTexts.newsFeed, textType: AppTextType.subtitle),

          //! SPACER
          AppScreenUtils.verticalSpaceTiny,

          //! NOTICE
          const AppTextWidget(
              theText: AppTexts.newsFeedNotice,
              textType: AppTextType.regularBody),

          //! SPACER
          AppScreenUtils.verticalSpaceTiny,

          //! EXPANDED
          Expanded(
              child: RefreshIndicator(
                  onRefresh: () {
                    // ignore: unused_result
                    ref.refresh(lostDevicesProvider);
                    return Future.delayed(const Duration(seconds: 1));
                  },
                  child: lostDevices.when(
                      data: (devices) {
                        if (devices.isEmpty) {
                          return const EmptyContentsWithTextAnimationView(
                            text:
                                "There are no lost devices within the community on our platform",
                          );
                        } else {
                          return ListView.separated(
                              itemCount: devices.length,
                              physics: const BouncingScrollPhysics(),
                              separatorBuilder: (context, index) =>
                                  const AppDivider(isVertical: false),
                              itemBuilder: (context, index) => LostDevice(
                                  device: devices.elementAt(index),
                                  onTap: () => AppUtils.showAppBottomSheet(
                                      context: context,
                                      height: screenSize.height * 0.6,
                                      width: screenSize.width,
                                      child: const LostDeviceOwnerDetails()),
                                  //! TODO: WHEN YOU TAP ON LOST DEVICE, SHOW DEVICE OWNER DETAILS
                                  index: index));
                        }
                      },
                      error: (error, stackTrace) => const ErrorAnimation(),
                      loading: () => const LoadingAnimation())))
        ]));
  }
}
