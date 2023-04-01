import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_device/router/router.dart';
import 'package:my_device/router/routes.dart';
import 'package:my_device/screens/home/widgets/device.dart';
import 'package:my_device/screens/home/widgets/view_device.dart';
import 'package:my_device/screens/widgets/animations/empty_contents_animation_with_text.dart';
import 'package:my_device/screens/widgets/animations/error_animation.dart';
import 'package:my_device/screens/widgets/animations/loading_animation.dart';
import 'package:my_device/screens/widgets/app_custom_text_widget.dart';
import 'package:my_device/services/models/device/device_model.dart';
import 'package:my_device/services/providers/auth_state/auth_state_provider.dart';
import 'package:my_device/services/providers/user_devices/user_devices_provider.dart';
import 'package:my_device/services/providers/user_devices_controller/user_devices_controller_provider.dart';
import 'package:my_device/shared/constants/app_divider.dart';
import 'package:my_device/shared/constants/app_texts.dart';
import 'package:my_device/shared/utils/app_extensions.dart';
import 'package:my_device/shared/utils/app_screen_utils.dart';
import 'package:my_device/shared/utils/type_defs.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<Iterable<DeviceModel>> devices =
        ref.watch(userDevicesProvider);

    return Padding(
        padding: AppScreenUtils.defaultPadding,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          //! TITLE
          const AppTextWidget(
              theText: AppTexts.appName, textType: AppTextType.subtitle),

          //! SPACER
          AppScreenUtils.verticalSpaceTiny,

          //! list view showing all user devices
          //! EACH DEVICE IS SEPARATED BY A DIVIDER
          //! EACH DEVICE CAN BE TAPPED ON TO VIEW DEVICE PROPERTIES, DELETE IT OR UPDATE DEVICE PICTURES
          //! YOU CANNOT UPDATE DEVICE DETAILS ONCE ADDED, IT'S A SECURITY MEASURE SO IF A DEVICE IS STOLEN ...
          //! ONLY THE MAIN OWNER HAS THE DEVICE DETAILS AS EXACT AS DESCRIBED.
          //! DELETED DEVICES LIST IS NEEDED TO TRACT LIST OF DEVICES A USER HAS DELETED.
          Expanded(
              child: RefreshIndicator(
                  onRefresh: () {
                    // ignore: unused_result
                    ref.refresh(userDevicesProvider);
                    return Future.delayed(const Duration(seconds: 1));
                  },
                  child: devices.when(
                      data: (devices) {
                        if (devices.isEmpty) {
                          return const EmptyContentsWithTextAnimationView(
                            text: "You haven't added any device yet",
                          );
                        } else {
                          return ListView.separated(
                              itemCount: devices.length,
                              physics: const BouncingScrollPhysics(),
                              separatorBuilder: (context, index) =>
                                  const AppDivider(isVertical: false),
                              itemBuilder: (context, index) => Device(
                                  onTap: () => Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ViewDeviceScreen(
                                                device:
                                                    devices.elementAt(index),
                                              ))),
                                  delete: () async {
                                    await ref
                                        .read(deviceControllerProvider.notifier)
                                        .deleteDevice(
                                            serialNumber: devices
                                                .elementAt(index)
                                                .serialNumber,
                                            deviceName: devices
                                                .elementAt(index)
                                                .deviceName,
                                            userId: ref
                                                .read(authControllerProvider)
                                                .userId);
                                  },
                                  device: devices.elementAt(index)));
                        }
                      },
                      error: (error, stackTrace) => const ErrorAnimation(),
                      loading: () => const LoadingAnimation())))
        ]));
  }
}
