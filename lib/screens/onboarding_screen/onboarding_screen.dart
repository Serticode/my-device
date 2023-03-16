import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:my_device/router/router.dart';
import 'package:my_device/router/routes.dart';
import 'package:my_device/screens/onboarding_screen/widget/onboarding_screen_icon_widget.dart';
import 'package:my_device/screens/widgets/app_custom_text_widget.dart';
import 'package:my_device/settings/settings.dart';
import 'package:my_device/shared/constants/app_images.dart';
import 'package:my_device/shared/constants/app_texts.dart';
import 'package:my_device/shared/utils/app_screen_utils.dart';
import 'package:my_device/shared/utils/type_defs.dart';
import 'package:my_device/theme/app_theme.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'widget/onboarding_screen_image_widget.dart';

class OnboardingScreen extends ConsumerWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //!THE PAGE STRUCTURE
    return Scaffold(
        body: SafeArea(
            child: IntroductionScreen(
                curve: Curves.bounceInOut,
                animationDuration: 700,
                globalBackgroundColor: Theme.of(context).colorScheme.primary,

                //!WHEN PAGES ARE DONE.
                done: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () {
                          AppSettings.setShowHome(showHome: true);

                          AppNavigator.navigateToReplacementPage(
                              thePageRouteName: AppRoutes.authWrapperRoute,
                              context: context);
                        },
                        child: const Text(AppTexts.done))),
                onDone: () {},

                //!NEXT BUTTON
                next:
                    ElevatedButton(onPressed: () {}, child: const Text("Next")),
                showNextButton: false,

                //!SKIP BUTTON
                skip: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () {
                          AppSettings.setShowHome(showHome: true);

                          AppNavigator.navigateToReplacementPage(
                              thePageRouteName: AppRoutes.authWrapperRoute,
                              context: context);
                        },
                        child: const Text(AppTexts.skip))),
                onSkip: () {},
                showSkipButton: true,

                //!PAGE VIEW INDICATOR
                dotsDecorator: DotsDecorator(
                    color: AppColours.appWhite,
                    activeColor: AppColours.appBlue,
                    activeShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(21.0.r)),
                    activeSize: Size(24.0.w, 12.0.h)),

                //!ONBOARDING PAGES
                pages: <PageViewModel>[
          //!FIRST PAGE
          PageViewModel(
              titleWidget: const AppTextWidget(
                  theText: AppTexts.onboardingPageOneHeader,
                  textType: AppTextType.subtitle),
              bodyWidget: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    //! SPACER
                    AppScreenUtils.verticalSpaceLarge,

                    //!FIRST IMAGE
                    const OnboardingScreenImageWidget(
                        theAssetImageURL: AppImages.defaultUser),

                    //!SECOND IMAGE SET
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const <Widget>[
                          //!IMAGE ONE
                          OnboardingScreenIconWidget(
                              theIcon: PhosphorIcons.deviceMobileBold,
                              theIconBGColour: AppColours.appWhite),

                          //!IMAGE TWO
                          OnboardingScreenIconWidget(
                              theIcon: PhosphorIcons.houseBold,
                              theIconBGColour: AppColours.appWhite)
                        ]),

                    //!LAST IMAGE
                    const OnboardingScreenIconWidget(
                        theIcon: PhosphorIcons.mapPinBold,
                        theIconBGColour: AppColours.appWhite),

                    //! SPACER
                    AppScreenUtils.verticalSpaceLarge,

                    //!TEXT
                    const AppTextWidget(
                        theText: AppTexts.onboardingPageOneSubheader,
                        textType: AppTextType.boldBody)
                  ])),

          //!SECOND PAGE
          PageViewModel(
              titleWidget: const AppTextWidget(
                  theText: AppTexts.onboardingPageTwoHeader,
                  textType: AppTextType.subtitle),
              bodyWidget: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    //! SPACER
                    AppScreenUtils.verticalSpaceLarge,

                    //!FIRST IMAGE
                    const OnboardingScreenImageWidget(
                        theAssetImageURL: AppImages.defaultUser),

                    //! SPACER
                    AppScreenUtils.verticalSpaceLarge,

                    //!SECOND ICON SET
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const <Widget>[
                          //!ICON ONE
                          OnboardingScreenIconWidget(
                              theIcon: PhosphorIcons.checkBold,
                              theIconBGColour: AppColours.appWhite),

                          //!ICON TWO
                          OnboardingScreenIconWidget(
                              theIcon: PhosphorIcons.houseBold,
                              theIconBGColour: AppColours.appWhite),

                          //!LAST ICON
                          OnboardingScreenIconWidget(
                              theIcon: PhosphorIcons.confettiBold,
                              theIconBGColour: AppColours.appWhite)
                        ]),

                    //! SPACER
                    AppScreenUtils.verticalSpaceLarge,

                    //!TEXT
                    const AppTextWidget(
                        theText: AppTexts.onboardingPageTwoSubheader,
                        textType: AppTextType.boldBody)
                  ])),

          //!THIRD PAGE
          PageViewModel(
              titleWidget: const AppTextWidget(
                  theText: AppTexts.onboardingPageThreeHeader,
                  textType: AppTextType.subtitle),
              bodyWidget: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    //! SPACER
                    AppScreenUtils.verticalSpaceLarge,

                    //!FIRST IMAGE
                    const OnboardingScreenImageWidget(
                        theAssetImageURL: AppImages.defaultUser),

                    //! SPACER
                    AppScreenUtils.verticalSpaceLarge,

                    //!SECOND ICON SET
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const <Widget>[
                          //!ICON ONE
                          OnboardingScreenIconWidget(
                              theIcon: PhosphorIcons.notepadBold,
                              theIconBGColour: AppColours.appWhite),

                          //!ICON TWO
                          OnboardingScreenIconWidget(
                              theIcon: PhosphorIcons.usersThreeBold,
                              theIconBGColour: AppColours.appWhite),

                          //!LAST ICON
                          OnboardingScreenIconWidget(
                              theIcon: PhosphorIcons.shieldChevronBold,
                              theIconBGColour: AppColours.appWhite)
                        ]),

                    //! SPACER
                    AppScreenUtils.verticalSpaceLarge,

                    //!TEXT
                    const AppTextWidget(
                        theText: AppTexts.onboardingPageThreeSubheader,
                        textType: AppTextType.boldBody)
                  ]))
        ])));
  }
}
