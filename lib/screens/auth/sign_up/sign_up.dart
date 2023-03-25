import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_device/router/router.dart';
import 'package:my_device/router/routes.dart';
import 'package:my_device/screens/widgets/animated_button.dart';
import 'package:my_device/screens/widgets/app_custom_text_widget.dart';
import 'package:my_device/services/providers/auth_state/auth_state_provider.dart';
import 'package:my_device/services/states/auth/auth_state.dart';
import 'package:my_device/shared/constants/app_texts.dart';
import 'package:my_device/shared/utils/app_fade_animation.dart';
import 'package:my_device/shared/utils/app_screen_utils.dart';
import 'package:my_device/shared/utils/type_defs.dart';
import 'package:my_device/theme/app_theme.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

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
  final ValueNotifier<TextEditingController> _confirmPasswordController =
      ValueNotifier(TextEditingController());
  final ValueNotifier<TextEditingController> _hallController =
      ValueNotifier(TextEditingController());
  final ValueNotifier<TextEditingController> _departmentController =
      ValueNotifier(TextEditingController());
  final ValueNotifier<TextEditingController> _firstNameController =
      ValueNotifier(TextEditingController());
  final ValueNotifier<TextEditingController> _lastNameController =
      ValueNotifier(TextEditingController());
  final ValueNotifier<TextEditingController> _phoneNoController =
      ValueNotifier(TextEditingController());
  final ValueNotifier<TextEditingController> _emailController =
      ValueNotifier(TextEditingController());

  //! PASSWORD VISIBILITY
  final ValueNotifier<bool> isPasswordVisible = ValueNotifier(false);
  final ValueNotifier<bool> isConfirmPasswordVisible = ValueNotifier(false);

  @override
  void dispose() {
    _matricNumberController.dispose();
    _passwordController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _hallController.dispose();
    _confirmPasswordController.dispose();
    _phoneNoController.dispose();
    _departmentController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      //resizeToAvoidBottomInset: false,
      body: SafeArea(
          child: Padding(
              padding: AppScreenUtils.defaultPadding,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    //! SPACER
                    AppScreenUtils.verticalSpaceTiny,

                    //! WELCOME TEXT.
                    const AppTextWidget(
                        theText: AppTexts.welcomeToMyDevice,
                        textType: AppTextType.subtitle),

                    //! SPACER
                    AppScreenUtils.verticalSpaceTiny,

                    //! NOTICE
                    const AppTextWidget(
                        theText: AppTexts.fillForm,
                        textType: AppTextType.regularBody,
                        textColour: AppColours.lettersAndIconsFaintColour),

                    //! SPACER
                    AppScreenUtils.verticalSpaceTiny,

                    //! CONTENT
                    Expanded(
                        child: SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            padding: EdgeInsets.zero,
                            child: Column(children: [
                              //! FIRST NAME
                              TextFormField(
                                  style: Theme.of(context).textTheme.bodyMedium,
                                  cursorColor: AppColours.lettersAndIconsColour,
                                  controller: _firstNameController.value,
                                  decoration: const InputDecoration(
                                      hintText: AppTexts.firstName)),

                              //! SPACER
                              AppScreenUtils.verticalSpaceSmall,

                              //! LAST NAME
                              TextFormField(
                                  style: Theme.of(context).textTheme.bodyMedium,
                                  cursorColor: AppColours.lettersAndIconsColour,
                                  controller: _lastNameController.value,
                                  decoration: const InputDecoration(
                                      hintText: AppTexts.lastName)),

                              //! SPACER
                              AppScreenUtils.verticalSpaceSmall,

                              //! MATRIC
                              TextFormField(
                                  style: Theme.of(context).textTheme.bodyMedium,
                                  cursorColor: AppColours.lettersAndIconsColour,
                                  controller: _matricNumberController.value,
                                  decoration: const InputDecoration(
                                      hintText: AppTexts.matric)),

                              //! SPACER
                              AppScreenUtils.verticalSpaceSmall,

                              //! EMAIL
                              TextFormField(
                                  style: Theme.of(context).textTheme.bodyMedium,
                                  cursorColor: AppColours.lettersAndIconsColour,
                                  controller: _emailController.value,
                                  decoration: const InputDecoration(
                                      hintText: AppTexts.email)),

                              //! SPACER
                              AppScreenUtils.verticalSpaceSmall,

                              //! DEPARTMENT
                              TextFormField(
                                  style: Theme.of(context).textTheme.bodyMedium,
                                  cursorColor: AppColours.lettersAndIconsColour,
                                  controller: _departmentController.value,
                                  decoration: const InputDecoration(
                                      hintText: AppTexts.department)),

                              //! SPACER
                              AppScreenUtils.verticalSpaceSmall,

                              //! HALL OF RESIDENCE
                              TextFormField(
                                  style: Theme.of(context).textTheme.bodyMedium,
                                  cursorColor: AppColours.lettersAndIconsColour,
                                  controller: _hallController.value,
                                  decoration: const InputDecoration(
                                      hintText: AppTexts.hallOfResidence)),

                              //! SPACER
                              AppScreenUtils.verticalSpaceSmall,

                              //! PHONE NUMBER
                              TextFormField(
                                  style: Theme.of(context).textTheme.bodyMedium,
                                  cursorColor: AppColours.lettersAndIconsColour,
                                  controller: _phoneNoController.value,
                                  decoration: const InputDecoration(
                                      hintText: AppTexts.phoneNumber)),

                              //! SPACER
                              AppScreenUtils.verticalSpaceSmall,

                              //! PASSWORD
                              ValueListenableBuilder(
                                  valueListenable: isPasswordVisible,
                                  child: const SizedBox.shrink(),
                                  builder: (context, value, child) =>
                                      TextFormField(
                                          style:
                                              Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium,
                                          cursorColor: AppColours
                                              .lettersAndIconsColour,
                                          controller: _passwordController.value,
                                          obscureText: !isPasswordVisible.value,
                                          decoration: InputDecoration(
                                              hintText: AppTexts.password,
                                              suffixIcon: IconButton(
                                                  onPressed:
                                                      () =>
                                                          isPasswordVisible.value =
                                                              !isPasswordVisible
                                                                  .value,
                                                  icon: Icon(isPasswordVisible
                                                          .value
                                                      ? PhosphorIcons.eyeBold
                                                      : PhosphorIcons
                                                          .eyeSlashBold))))),

                              //! SPACER
                              AppScreenUtils.verticalSpaceSmall,

                              //! CONFIRM PASSWORD
                              ValueListenableBuilder(
                                  valueListenable: isConfirmPasswordVisible,
                                  child: const SizedBox.shrink(),
                                  builder: (context, value, child) => TextFormField(
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium,
                                      cursorColor:
                                          AppColours.lettersAndIconsColour,
                                      controller:
                                          _confirmPasswordController.value,
                                      obscureText:
                                          !isConfirmPasswordVisible.value,
                                      decoration: InputDecoration(
                                          hintText: AppTexts.confirmPassword,
                                          suffixIcon: IconButton(
                                              onPressed: () =>
                                                  isConfirmPasswordVisible
                                                          .value =
                                                      !isConfirmPasswordVisible
                                                          .value,
                                              icon: Icon(
                                                  isConfirmPasswordVisible.value
                                                      ? PhosphorIcons.eyeBold
                                                      : PhosphorIcons
                                                          .eyeSlashBold)))))
                            ]))),

                    //! SPACER
                    AppScreenUtils.verticalSpaceSmall,

                    //! SIGN UP BUTTON
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
                                                theText: AppTexts.getStarted,
                                                textType:
                                                    AppTextType.regularBody)),
                                    onTap: () async {
                                      await ref
                                          .read(authControllerProvider.notifier)
                                          .registerUser(
                                              context: context,
                                              firstName: _firstNameController
                                                  .value.text
                                                  .trim(),
                                              lastName: _lastNameController
                                                  .value.text
                                                  .trim(),
                                              matricNumber:
                                                  _matricNumberController
                                                      .value.text
                                                      .trim(),
                                              email: _emailController.value.text
                                                  .trim(),
                                              department: _departmentController
                                                  .value.text
                                                  .trim(),
                                              hallOfResidence: _hallController
                                                  .value.text
                                                  .trim(),
                                              phoneNumber: _phoneNoController
                                                  .value.text
                                                  .trim(),
                                              password: _passwordController
                                                  .value.text
                                                  .trim(),
                                              confirmPassword:
                                                  _confirmPasswordController
                                                      .value.text
                                                      .trim())
                                          .then((value) => value
                                              ? {
                                                  AppNavigator.removeUntilPage(
                                                      thePageRouteName: AppRoutes
                                                          .homeWrapperRouter,
                                                      context: context),
                                                }
                                              : {});
                                    }));
                          })),
                    ),

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
                    ])
                  ]))));
}
