import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_device/screens/news_feed/widgets/lost_device.dart';
import 'package:my_device/screens/widgets/app_custom_text_widget.dart';
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
              child: ListView.separated(
                  itemCount: 3,
                  physics: const BouncingScrollPhysics(),
                  separatorBuilder: (context, index) =>
                      const AppDivider(isVertical: false),
                  itemBuilder: (context, index) => LostDevice(
                      onTap: () => AppUtils.showAppBottomSheet(
                          context: context,
                          height: screenSize.height * 0.6,
                          width: screenSize.width,
                          child: const LostDeviceOwnerDetails()),
                      //! TODO: WHEN YOU TAP ON LOST DEVICE, SHOW DEVICE OWNER DETAILS
                      index: index,
                      canDelete: false)))
        ]));
  }
}
