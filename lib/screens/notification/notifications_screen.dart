import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_device/screens/home/widgets/app_bar.dart';
import 'package:my_device/screens/home/widgets/device.dart';
import 'package:my_device/screens/notification/widgets/notification_item.dart';
import 'package:my_device/screens/widgets/animations/empty_contents_animation_with_text.dart';
import 'package:my_device/screens/widgets/animations/error_animation.dart';
import 'package:my_device/screens/widgets/animations/loading_animation.dart';
import 'package:my_device/screens/widgets/app_custom_text_widget.dart';
import 'package:my_device/screens/widgets/profile_picture.dart';
import 'package:my_device/services/models/auth/user_model/user_model.dart';
import 'package:my_device/services/models/device/device_model.dart';
import 'package:my_device/services/models/device/found_device_model.dart';
import 'package:my_device/services/providers/auth_state/auth_state_provider.dart';
import 'package:my_device/services/providers/found_devices/found_devices_provider.dart';
import 'package:my_device/services/providers/user_devices/user_devices_provider.dart';
import 'package:my_device/services/providers/user_info/user_info_provider.dart';
import 'package:my_device/shared/constants/app_divider.dart';
import 'package:my_device/shared/constants/app_texts.dart';
import 'package:my_device/shared/utils/app_extensions.dart';
import 'package:my_device/shared/utils/app_fade_animation.dart';
import 'package:my_device/shared/utils/app_screen_utils.dart';
import 'package:my_device/shared/utils/type_defs.dart';
import 'package:my_device/shared/utils/utils.dart';
import 'package:my_device/theme/app_theme.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class NotificationsScreen extends ConsumerWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<Iterable<FoundDeviceModel>> foundDevicesList =
        ref.watch(foundDevicesProvider);

    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(75.0.h),
            child: SafeArea(
                child: Padding(
                    padding: AppScreenUtils.defaultPadding,
                    child: Row(children: [
                      //! PROFILE PICTURE
                      Consumer(builder: (context, ref, child) {
                        return Consumer(builder: (context, ref, child) {
                          final AsyncValue<UserModel> loggedInUser = ref.watch(
                              loggedInUserDetailsProvider(
                                  ref.read(authControllerProvider).userId!));
                          return ProfilePicture(
                              imageURL: loggedInUser.value?.profilePhoto ?? "",
                              boxFit: BoxFit.contain);
                        });
                      }),

                      //! SPACER
                      AppScreenUtils.horizontalSpaceSmall,

                      const AppTextWidget(
                          theText: "Notifications",
                          textType: AppTextType.boldBody)
                    ])))),

        //! BODY
        body: Padding(
            padding: AppScreenUtils.defaultPadding,
            child: Column(children: [
              Expanded(
                  child: RefreshIndicator(
                      onRefresh: () {
                        // ignore: unused_result
                        ref.refresh(userDevicesProvider);
                        return Future.delayed(const Duration(seconds: 1));
                      },
                      child: foundDevicesList.when(
                          data: (foundDevices) {
                            if (foundDevices.isEmpty) {
                              return const EmptyContentsWithTextAnimationView(
                                  text:
                                      "None of your missing devices; if any, has been found");
                            } else {
                              return ListView.separated(
                                  itemCount: foundDevices.length,
                                  physics: const BouncingScrollPhysics(),
                                  separatorBuilder: (context, index) =>
                                      const AppDivider(isVertical: false),
                                  itemBuilder: (context, index) =>
                                      NotificationItem(
                                          foundDevice:
                                              foundDevices.elementAt(index)));
                            }
                          },
                          error: (error, stackTrace) => const ErrorAnimation(),
                          loading: () => const LoadingAnimation()))),

              //! SPACER
              AppScreenUtils.verticalSpaceSmall,

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
            ])));
  }
}
