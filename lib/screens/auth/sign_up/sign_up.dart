import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_device/router/router.dart';
import 'package:my_device/router/routes.dart';
import 'package:my_device/screens/widgets/app_custom_text_widget.dart';
import 'package:my_device/screens/widgets/signature_text.dart';
import 'package:my_device/shared/constants/app_texts.dart';
import 'package:my_device/shared/utils/app_fade_animation.dart';
import 'package:my_device/shared/utils/app_screen_utils.dart';
import 'package:my_device/shared/utils/type_defs.dart';
import 'package:my_device/theme/app_theme.dart';

class SignUp extends ConsumerStatefulWidget {
  const SignUp({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignUpState();
}

class _SignUpState extends ConsumerState<SignUp> {
  final ValueNotifier<TextEditingController> _matricNumberController =
      ValueNotifier(TextEditingController());
  final ValueNotifier<TextEditingController> _passwordController =
      ValueNotifier(TextEditingController());

  @override
  void dispose() {
    _matricNumberController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
          child: Padding(
              padding: AppScreenUtils.defaultPadding,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    //! SPACER
                    AppScreenUtils.verticalSpaceMedium,

                    //! WELCOME TEXT.
                    const AppTextWidget(
                        theText: AppTexts.welcomeToMyDevice,
                        textType: AppTextType.subtitle),

                    //! SPACER
                    AppScreenUtils.verticalSpaceSmall,

                    //! NOTICE
                    const AppTextWidget(
                        theText: AppTexts.fillForm,
                        textType: AppTextType.regularBody,
                        textColour: AppColours.lettersAndIconsFaintColour),

                    //! SPACER
                    AppScreenUtils.verticalSpaceMedium,

                    //! MATRIC
                    TextFormField(
                        style: Theme.of(context).textTheme.bodyMedium,
                        cursorColor: AppColours.lettersAndIconsColour,
                        controller: _matricNumberController.value,
                        decoration:
                            const InputDecoration(hintText: AppTexts.matric)),

                    //! SPACER
                    AppScreenUtils.verticalSpaceSmall,

                    //! PASSWORD
                    TextFormField(
                        style: Theme.of(context).textTheme.bodyMedium,
                        cursorColor: AppColours.lettersAndIconsColour,
                        controller: _passwordController.value,
                        decoration:
                            const InputDecoration(hintText: AppTexts.password)),

                    //! SPACER
                    const Spacer(),

                    //! BUTTON
                    AppFadeAnimation(
                        delay: 1.6,
                        child: SizedBox(
                            width: double.infinity,
                            height: 45.0.h,
                            child: ElevatedButton(
                                onPressed: () {
                                  //! TODO: MAKE API CALLS TO AUTHENTICATE USER.
                                  //! TODO: ADD IN APP LOCK SCREEN / AUTH ACCESS SCREEN

                                  AppNavigator.navigateToPage(
                                      thePageRouteName:
                                          AppRoutes.homeScreenInitializerRoute,
                                      context: context);
                                },
                                child: const AppTextWidget(
                                    theText: AppTexts.getStarted,
                                    textType: AppTextType.regularBody)))),

                    //! SPACER
                    AppScreenUtils.verticalSpaceLarge,

                    //! DON'T HAVE AN ACCOUNT, SIGN UP
                    Row(children: [
                      const AppTextWidget(
                          theText: AppTexts.alreadyHaveAccount,
                          textType: AppTextType.regularBody),
                      InkWell(
                          onTap: () => AppNavigator.navigateToReplacementPage(
                              thePageRouteName: AppRoutes.signInRoute,
                              context: context),
                          child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(AppTexts.signIn,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                          fontSize: 16.0.sp,
                                          color: AppColours
                                              .elevatedButtonBackgroundColour))))
                    ]),

                    //! SPACER
                    AppScreenUtils.verticalSpaceMedium,

                    //! SIGNATURE
                    const Center(child: SignatureText())
                  ]))));
}
