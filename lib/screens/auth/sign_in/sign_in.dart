import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_device/router/router.dart';
import 'package:my_device/router/routes.dart';
import 'package:my_device/screens/widgets/animated_button.dart';
import 'package:my_device/screens/widgets/app_custom_text_widget.dart';
import 'package:my_device/screens/widgets/signature_text.dart';
import 'package:my_device/services/controllers/auth_controller.dart';
import 'package:my_device/services/states/auth/auth_state.dart';
import 'package:my_device/shared/constants/app_texts.dart';
import 'package:my_device/shared/utils/app_fade_animation.dart';
import 'package:my_device/shared/utils/app_screen_utils.dart';
import 'package:my_device/shared/utils/type_defs.dart';
import 'package:my_device/theme/app_theme.dart';

class SignIn extends ConsumerStatefulWidget {
  const SignIn({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignInState();
}

class _SignInState extends ConsumerState<SignIn> {
  final ValueNotifier<TextEditingController> _emailController =
      ValueNotifier(TextEditingController());
  final ValueNotifier<TextEditingController> _passwordController =
      ValueNotifier(TextEditingController());

  @override
  void dispose() {
    _emailController.dispose();
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
                    //! WELCOME TEXT.
                    const AppTextWidget(
                        theText: AppTexts.welcomeBack,
                        textType: AppTextType.subtitle),

                    //! SPACER
                    AppScreenUtils.verticalSpaceTiny,

                    //! NOTICE
                    const AppTextWidget(
                        theText: AppTexts.fillDetails,
                        textType: AppTextType.regularBody,
                        textColour: AppColours.lettersAndIconsFaintColour),

                    //! SPACER
                    AppScreenUtils.verticalSpaceMedium,

                    //! MATRIC
                    TextFormField(
                        style: Theme.of(context).textTheme.bodyMedium,
                        cursorColor: AppColours.lettersAndIconsColour,
                        controller: _emailController.value,
                        decoration:
                            const InputDecoration(hintText: AppTexts.email)),

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

                    //! SIGN IN BUTTON
                    Center(
                        child: AppFadeAnimation(
                            delay: 1.6,
                            child: Consumer(builder: (context, ref, child) {
                              final AuthState authState =
                                  ref.watch(authControllerProvider);
                              final double width = authState.isLoading
                                  ? 56.w
                                  : MediaQuery.of(context).size.width;
                              final double radius =
                                  authState.isLoading ? 56.0.r : 21.0.r;

                              return IgnorePointer(
                                  ignoring: authState.isLoading,
                                  child: AnimatedButton(
                                      height: 45.0.h,
                                      width: width,
                                      radius: radius,
                                      content: Center(
                                          child: authState.isLoading
                                              ? Transform.scale(
                                                  scale: 0.7,
                                                  child:
                                                      const CircularProgressIndicator(
                                                          color: AppColours
                                                              .appWhite))
                                              : const AppTextWidget(
                                                  theText: AppTexts.signIn,
                                                  textType:
                                                      AppTextType.regularBody)),
                                      onTap: () async {
                                        await ref
                                            .read(
                                                authControllerProvider.notifier)
                                            .login(
                                                context: context,
                                                email: _emailController
                                                    .value.text
                                                    .trim(),
                                                password: _passwordController
                                                    .value.text
                                                    .trim())
                                            .then((value) => value
                                                ? {
                                                    AppNavigator.removeUntilPage(
                                                        thePageRouteName: AppRoutes
                                                            .homeWrapperRouter,
                                                        context: context)
                                                  }
                                                : {});
                                      }));
                            }))),

                    //! SPACER
                    AppScreenUtils.verticalSpaceTiny,

                    //! DON'T HAVE AN ACCOUNT, SIGN UP
                    Row(children: [
                      const AppTextWidget(
                          theText: AppTexts.dontHaveAccount,
                          textType: AppTextType.regularBody),
                      InkWell(
                          onTap: () => AppNavigator.navigateToReplacementPage(
                              thePageRouteName: AppRoutes.signUpRoute,
                              context: context),
                          child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Sign up",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                          fontSize: 16.0.sp,
                                          color: AppColours
                                              .elevatedButtonBackgroundColour))))
                    ])
                  ]))));
}
