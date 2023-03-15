import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:my_device/router/router.dart';
import 'package:my_device/router/routes.dart';
import 'package:my_device/screens/onboarding_screen/widget/onboarding_screen_icon_widget.dart';
import 'package:my_device/screens/widgets/app_custom_text_widget.dart';
import 'package:my_device/settings/settings.dart';
import 'package:my_device/shared/utils/app_screen_utils.dart';
import 'package:my_device/shared/utils/type_defs.dart';
import 'widget/onboarding_screen_image_widget.dart';

class SertidriveOnboardingScreen extends StatefulWidget {
  const SertidriveOnboardingScreen({Key? key}) : super(key: key);

  @override
  State<SertidriveOnboardingScreen> createState() =>
      _SertidriveOnboardingScreenState();
}

class _SertidriveOnboardingScreenState
    extends State<SertidriveOnboardingScreen> {
  @override
  Widget build(BuildContext context) {
    //!THE PAGE STRUCTURE
    return Scaffold(
        body: SafeArea(
            child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) =>
                    IntroductionScreen(
                        curve: Curves.decelerate,
                        animationDuration: 700,
                        globalBackgroundColor:
                            Theme.of(context).colorScheme.primary,

                        //!WHEN PAGES ARE DONE.
                        done: SizedBox(
                            width: 120.0,
                            child: ElevatedButton(
                                onPressed: () {
                                  AppSettings().setOnboardingScreenCount(
                                      onboardingScreenCount: 1);

                                  AppNavigator.navigateToReplacementPage(
                                      thePageRouteName:
                                          AppRoutes.authWrapperRoute,
                                      context: context);
                                },
                                child: const Text("Done"))),
                        onDone: () {},

                        //!NEXT BUTTON
                        next: SizedBox(
                            width: 120.0,
                            child: ElevatedButton(
                                onPressed: () {}, child: const Text("Next"))),
                        showNextButton: false,

                        //!SKIP BUTTON
                        skip: SizedBox(
                            width: 120.0,
                            child: ElevatedButton(
                                onPressed: () {
                                  AppSettings().setOnboardingScreenCount(
                                      onboardingScreenCount: 1);

                                  AppNavigator.navigateToReplacementPage(
                                      thePageRouteName:
                                          AppRoutes.authWrapperRoute,
                                      context: context);
                                },
                                child: const Text("Skip"))),
                        onSkip: () {},
                        showSkipButton: true,

                        //!PAGE VIEW INDICATOR
                        dotsDecorator: DotsDecorator(
                            color: Colors.white,
                            activeColor: const Color(0xFF0B29EF),
                            activeShape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            activeSize: const Size(22.0, 10.0)),

                        //!ONBOARDING PAGES
                        pages: <PageViewModel>[
                          //!FIRST PAGE
                          PageViewModel(
                              titleWidget: const AppTextWidget(
                                  theText: "Complete cloud storage.",
                                  textType: AppTextType.subtitle),
                              bodyWidget: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    //! SPACER
                                    AppScreenUtils.verticalSpaceMedium,

                                    //!FIRST IMAGE
                                    const SertidriveOnboardingScreenImageWidget(
                                        theAssetImageURL:
                                            "assets/images/sertidrive_default_user.png"),

                                    //!SECOND IMAGE SET
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: const <Widget>[
                                          //!IMAGE ONE
                                          SertidriveOnboardingScreenImageWidget(
                                              theAssetImageURL:
                                                  "assets/images/googledrive_logo.png"),

                                          //!IMAGE TWO
                                          SertidriveOnboardingScreenImageWidget(
                                              theAssetImageURL:
                                                  "assets/images/onedrive_logo.png")
                                        ]),

                                    //!LAST IMAGE
                                    const SertidriveOnboardingScreenImageWidget(
                                        theAssetImageURL:
                                            "assets/images/dropbox_logo.png"),

                                    //! SPACER
                                    AppScreenUtils.verticalSpaceMedium,

                                    //!TEXT
                                    const AppTextWidget(
                                        theText:
                                            "Your cloud accounts, all in one place!",
                                        textType: AppTextType.regularBody)
                                  ])),

                          //!SECOND PAGE
                          PageViewModel(
                              titleWidget: const AppTextWidget(
                                theText: "Relish control. \nPower, with ease.",
                                textType: AppTextType.subtitle,
                              ),
                              bodyWidget: Container(
                                  //!MAIN CONTAINER
                                  height: constraints.maxHeight * 0.6,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondaryContainer
                                          .withOpacity(0.2),
                                      borderRadius:
                                          BorderRadius.circular(30.0)),
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        //!FIRST ICON
                                        AppOnboardingScreenIconWidget(
                                            theIcon: Icons
                                                .create_new_folder_outlined,
                                            theIconBGColour:
                                                Colors.green.shade600),

                                        //!SECOND ICON SET
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: <Widget>[
                                              //!ICON ONE
                                              AppOnboardingScreenIconWidget(
                                                  theIcon:
                                                      Icons.upload_outlined,
                                                  theIconBGColour:
                                                      Colors.pink.shade300),

                                              //!ICON TWO
                                              AppOnboardingScreenIconWidget(
                                                  theIcon:
                                                      Icons.download_outlined,
                                                  theIconBGColour:
                                                      Colors.yellow.shade600),

                                              //!LAST ICON
                                              AppOnboardingScreenIconWidget(
                                                  theIcon: Icons.delete_outline,
                                                  theIconBGColour: Colors
                                                      .red.shade800
                                                      .withOpacity(0.8))
                                            ]),

                                        //!TEXT
                                        const AppTextWidget(
                                            theText:
                                                "Create Folders, Upload, Download, \nDelete data at will.",
                                            textType: AppTextType.regularBody)
                                      ]))),

                          //!THIRD PAGE
                          PageViewModel(
                              titleWidget: const AppTextWidget(
                                theText: "Your information at your fingertips",
                                textType: AppTextType.subtitle,
                              ),
                              bodyWidget: Container(
                                  //!MAIN CONTAINER
                                  height: constraints.maxHeight * 0.6,
                                  width: double.infinity,
                                  padding: AppScreenUtils.defaultPadding,
                                  decoration: BoxDecoration(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondaryContainer
                                          .withOpacity(0.2),
                                      borderRadius:
                                          BorderRadius.circular(30.0)),
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        //!HEADER
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                            //!TITLE
                                            const AppTextWidget(
                                                theText: "Latest changes",
                                                textType: AppTextType.subtitle),

                                            //!BUTTON
                                            ElevatedButton(
                                                onPressed: () {},
                                                style: ElevatedButton.styleFrom(
                                                    primary: Theme.of(context)
                                                        .colorScheme
                                                        .primary,
                                                    textStyle: const TextStyle(
                                                        fontSize: 14.0,
                                                        fontWeight:
                                                            FontWeight.w500)),
                                                child: Row(children: const <
                                                    Widget>[
                                                  //!TEXT
                                                  Text("See all changes"),

                                                  //!ICON
                                                  Icon(Icons.arrow_forward_ios,
                                                      size: 18.0)
                                                ]))
                                          ],
                                        ),

                                        //!STEPPER WIDGET
                                        Container(
                                            width: double.infinity,
                                            padding:
                                                AppScreenUtils.defaultPadding,
                                            child: Stepper(
                                                controlsBuilder:
                                                    (context, details) {
                                                  return const SizedBox();
                                                },
                                                steps: <Step>[
                                                  //!TOP STEP
                                                  Step(
                                                      state: StepState.complete,
                                                      title: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: const <
                                                            Widget>[
                                                          //!IMAGE
                                                          SertidriveOnboardingScreenImageWidget(
                                                              theAssetImageURL:
                                                                  "assets/images/sertidrive_default_user.png"),

                                                          //!UPDATE
                                                          AppTextWidget(
                                                            theText:
                                                                "You uploaded 2 files",
                                                            textType: AppTextType
                                                                .regularBody,
                                                          )
                                                        ],
                                                      ),

                                                      //!TIME OF EVENT
                                                      content: const Align(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: AppTextWidget(
                                                            theText:
                                                                "2 hours ago...",
                                                            textType: AppTextType
                                                                .regularBody,
                                                          ))),

                                                  //!BOTTOM STEP
                                                  Step(
                                                      state: StepState.complete,
                                                      title: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: const <
                                                            Widget>[
                                                          //!IMAGE
                                                          SertidriveOnboardingScreenImageWidget(
                                                              theAssetImageURL:
                                                                  "assets/images/sertidrive_default_user.png"),

                                                          //!UPDATE
                                                          AppTextWidget(
                                                              theText:
                                                                  "You created a folder \n3 hours ago",
                                                              textType: AppTextType
                                                                  .regularBody),
                                                        ],
                                                      ),

                                                      //!TIME OF EVENT
                                                      content: const SizedBox())
                                                ])),

                                        //!TEXT
                                        const AppTextWidget(
                                          theText:
                                              "See your cloud activities... \nAs they happen!",
                                          textType: AppTextType.regularBody,
                                        ),
                                      ])))
                        ]))));
  }
}
