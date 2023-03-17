import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_device/screens/widgets/app_custom_text_widget.dart';
import 'package:my_device/screens/widgets/profile_picture.dart';
import 'package:my_device/shared/constants/app_texts.dart';
import 'package:my_device/shared/utils/app_fade_animation.dart';
import 'package:my_device/shared/utils/app_screen_utils.dart';
import 'package:my_device/shared/utils/type_defs.dart';
import 'package:my_device/theme/app_theme.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class AppBarWidget extends ConsumerWidget implements PreferredSizeWidget {
  final int currentPage;
  final void Function() onTap;
  const AppBarWidget(
      {super.key, required this.onTap, required this.currentPage});

  @override
  Size get preferredSize => Size.fromHeight(75.0.h);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
        child: Padding(
            padding: currentPage == 2
                ? EdgeInsets.zero
                : AppScreenUtils.defaultPadding,
            child: currentPage == 2
                ? null
                : Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                        //! PROFILE PICTURE
                        const ProfilePicture(imageURL: ""),

                        //! SPACER
                        AppScreenUtils.horizontalSpaceTiny,

                        //! GREETING
                        const AppFadeAnimation(
                            delay: 1.6,
                            child: AppTextWidget(
                                theText: AppTexts.greetings,
                                textType: AppTextType.regularBody)),

                        //! SPACER
                        const Spacer(),

                        //! NOTIFICATION
                        IconButton(
                            onPressed: () => onTap(),
                            icon: const Icon(PhosphorIcons.bellSimpleBold,
                                color: AppColours.appWhite))
                      ])));
  }
}
