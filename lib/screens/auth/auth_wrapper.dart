import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_device/router/router.dart';
import 'package:my_device/router/routes.dart';
import 'package:my_device/screens/widgets/app_custom_text_widget.dart';
import 'package:my_device/shared/constants/app_images.dart';
import 'package:my_device/shared/constants/app_texts.dart';
import 'package:my_device/shared/utils/app_fade_animation.dart';
import 'package:my_device/shared/utils/app_screen_utils.dart';
import 'package:my_device/shared/utils/type_defs.dart';
import 'package:my_device/theme/app_theme.dart';

class AuthWrapper extends ConsumerWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => Scaffold(
      body: SafeArea(
          child: Padding(
              padding: AppScreenUtils.defaultPadding,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //! TITLE
                    const AppTextWidget(
                        theText: AppTexts.appName,
                        textType: AppTextType.header),

                    //!  SPACER
                    AppScreenUtils.verticalSpaceSmall,

                    //! NOTICE
                    const AppTextWidget(
                        theText: AppTexts.wrapperNote,
                        textColour: AppColours.appGreyFaint,
                        textType: AppTextType.boldBody),

                    //! SPACER
                    const Spacer(),

                    //! USER & LOGO
                    Container(
                        padding: AppScreenUtils.defaultPadding,
                        height: MediaQuery.of(context).size.height * 0.3.h,
                        decoration: BoxDecoration(
                            color: AppColours.containersBackgroundColour
                                .withOpacity(0.4),
                            borderRadius: BorderRadius.circular(21.0.r)),
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Align(
                                  alignment: Alignment.center,
                                  child: CircleAvatar(
                                      radius: 45.0,
                                      backgroundColor:
                                          AppColours.containersBackgroundColour,
                                      child: CircleAvatar(
                                          radius: 50.0,
                                          backgroundColor:
                                              AppColours.lettersAndIconsColour,
                                          child: Transform.scale(
                                              scale: 0.6,
                                              child: const Image(
                                                  filterQuality:
                                                      FilterQuality.high,
                                                  fit: BoxFit.contain,
                                                  image: AssetImage(AppImages
                                                      .defaultUser)))))),

                              //! SPACER
                              AppScreenUtils.horizontalSpaceSmall,

                              //! IMAGE
                              Align(
                                  alignment: Alignment.center,
                                  child: CircleAvatar(
                                      radius: 45.0,
                                      backgroundColor:
                                          AppColours.containersBackgroundColour,
                                      child: CircleAvatar(
                                          radius: 50.0,
                                          backgroundColor:
                                              AppColours.lettersAndIconsColour,
                                          child: Padding(
                                              padding:
                                                  AppScreenUtils.defaultPadding,
                                              child: const Image(
                                                  image: AssetImage(
                                                      AppImages.logo))))))
                            ])),

                    //! SPACER
                    const Spacer(),
                    //! SPACER
                    const Spacer(),

                    //! SPACER
                    AppScreenUtils.verticalSpaceLarge,

                    //! BUTTONS
                    AppFadeAnimation(
                        delay: 1.6,
                        child: SizedBox(
                            width: double.infinity,
                            height: 45.0.h,
                            child: ElevatedButton(
                                onPressed: () {
                                  AppNavigator.navigateToPage(
                                      thePageRouteName: AppRoutes.signInRoute,
                                      context: context);
                                },
                                child: const AppTextWidget(
                                    theText: AppTexts.signIn,
                                    textType: AppTextType.regularBody)))),

                    //! SPACER
                    AppScreenUtils.verticalSpaceMedium,

                    //! SIGN UP.
                    AppFadeAnimation(
                        delay: 1.8,
                        child: SizedBox(
                            width: double.infinity,
                            height: 45.0.h,
                            child: ElevatedButton(
                                onPressed: () {
                                  AppNavigator.navigateToPage(
                                      thePageRouteName: AppRoutes.signUpRoute,
                                      context: context);
                                },
                                child: const AppTextWidget(
                                    theText: AppTexts.getStarted,
                                    textType: AppTextType.regularBody)))),

                    //! SPACER
                    AppScreenUtils.verticalSpaceMedium
                  ]))));
}
