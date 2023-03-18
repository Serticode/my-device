import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_device/router/router.dart';
import 'package:my_device/router/routes.dart';
import 'package:my_device/screens/home/widgets/device.dart';
import 'package:my_device/screens/widgets/app_custom_text_widget.dart';
import 'package:my_device/shared/constants/app_divider.dart';
import 'package:my_device/shared/constants/app_texts.dart';
import 'package:my_device/shared/utils/app_extensions.dart';
import 'package:my_device/shared/utils/app_screen_utils.dart';
import 'package:my_device/shared/utils/type_defs.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});
  //! NUMBER OF PAGES
  static final ValueNotifier<int> numberOfDevices = ValueNotifier(4);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ValueListenableBuilder(
        valueListenable: numberOfDevices,
        child: const SizedBox.shrink(),
        builder: (context, value, child) => Padding(
            padding: AppScreenUtils.defaultPadding,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
                  child: ListView.separated(
                      itemCount:
                          numberOfDevices.value < 1 ? 0 : numberOfDevices.value,
                      physics: const BouncingScrollPhysics(),
                      separatorBuilder: (context, index) =>
                          const AppDivider(isVertical: false),
                      itemBuilder: (context, index) => Device(
                          onTap: () => AppNavigator.navigateToPage(
                              thePageRouteName: AppRoutes.viewDevice,
                              context: context),
                          delete: () => {
                                "Device Delete Pressed".log(),
                                numberOfDevices.value < 1
                                    ? numberOfDevices.value = 0
                                    : numberOfDevices.value--
                              },
                          index: index)))
            ])));
  }
}
