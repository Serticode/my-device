import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_device/router/router.dart';
import 'package:my_device/router/routes.dart';
import 'package:my_device/screens/home/home_wrapper.dart';
import 'package:my_device/screens/profile/widgets/about.dart';
import 'package:my_device/screens/profile/widgets/profile_item.dart';
import 'package:my_device/screens/profile/widgets/report_a_problem.dart';
import 'package:my_device/screens/widgets/app_custom_text_widget.dart';
import 'package:my_device/screens/widgets/profile_picture.dart';
import 'package:my_device/services/models/auth/user_model/user_model.dart';
import 'package:my_device/services/providers/auth_state/auth_state_provider.dart';
import 'package:my_device/services/providers/upload_image/upload_image_provider.dart';
import 'package:my_device/services/providers/user_info/user_info_provider.dart';
import 'package:my_device/services/repositories/auth_repository.dart';
import 'package:my_device/shared/constants/app_texts.dart';
import 'package:my_device/shared/utils/app_extensions.dart';
import 'package:my_device/shared/utils/app_fade_animation.dart';
import 'package:my_device/shared/utils/app_screen_utils.dart';
import 'package:my_device/shared/utils/type_defs.dart';
import 'package:my_device/shared/utils/utils.dart';
import 'package:my_device/theme/app_theme.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class Profile extends ConsumerWidget {
  const Profile({super.key});
  static const List<String> profileOptions = [
    "Change profile picture",
    "View deleted devices",
    "About",
    "Report a problem",
  ];
  static const List<IconData> profileOptionIcons = [
    PhosphorIcons.userBold,
    PhosphorIcons.listDashesBold,
    PhosphorIcons.newspaperClippingBold,
    PhosphorIcons.notepadBold,
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<UserModel> loggedInUser = ref.watch(
        loggedInUserDetailsProvider(ref.read(authControllerProvider).userId!));
    final Size screenSize = MediaQuery.of(context).size;

    return Padding(
        padding: AppScreenUtils.defaultPadding,
        child: Column(children: [
          //! PROFILE PICTURE
          Align(
              alignment: Alignment.center,
              child: Consumer(builder: (context, ref, child) {
                final bool isLoading = ref.watch(uploadImageProvider);
                return isLoading
                    ? CircleAvatar(
                        radius: 65.0.r,
                        backgroundColor: AppColours.appWhite,
                        child: CircularProgressIndicator(
                            color: AppColours.appGrey,
                            backgroundColor: AppColours.appBlue))
                    : ProfilePicture(
                        imageURL: loggedInUser.value?.profilePhoto ?? "",
                        largerRadius: 65.0.r,
                        smallerRadius: 60.0.r,
                        boxFit: BoxFit.contain);
              })),

          //! SPACER
          AppScreenUtils.verticalSpaceSmall,

          //! USER NAME
          AppTextWidget(
              theText:
                  "${loggedInUser.value?.lastName} ${loggedInUser.value?.firstName}",
              textType: AppTextType.boldBody),

          //! SPACER
          AppScreenUtils.verticalSpaceTiny,

          //! USER COURSE AND LEVEL
          Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppTextWidget(
                    theText: "${loggedInUser.value?.department}",
                    textType: AppTextType.regularBody),

                //! SPACER
                AppScreenUtils.horizontalSpaceSmall,

                //! DOT
                Container(
                    height: 4.0.h,
                    width: 4.0.w,
                    decoration: const BoxDecoration(
                        color: AppColours.appGreyFaint,
                        shape: BoxShape.circle)),

                //! SPACER
                AppScreenUtils.horizontalSpaceSmall,

                AppTextWidget(
                    theText: "${loggedInUser.value?.matricNumber}",
                    textType: AppTextType.regularBody)
              ]),

          //! SPACER
          AppScreenUtils.verticalSpaceSmall,

          //! SETTINGS SHOWING ABOUT, REPORT A PROBLEM, CHANGE PROFILE PICTURE
          //! LIST OF DELETED DEVICES
          //!
          Container(
              height: MediaQuery.of(context).size.height * 0.5,
              width: double.infinity,
              padding: AppScreenUtils.defaultPadding,
              decoration: BoxDecoration(
                  color: AppColours.appGreyFaint.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(21.0.r)),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //! SPACER
                    AppScreenUtils.verticalSpaceSmall,

                    //! NOTICE
                    const AppTextWidget(
                        theText: AppTexts.profileOptions,
                        textType: AppTextType.subtitle),

                    //! SPACER
                    AppScreenUtils.verticalSpaceSmall,

                    Expanded(
                        child: Column(
                            children: List.generate(
                                4,
                                (index) => AppFadeAnimation(
                                    delay: (index + 1) * 0.5,
                                    child: InkWell(
                                      onTap: () => profileOptionsCTA(
                                          index: index,
                                          context: context,
                                          screenSize: screenSize,
                                          ref: ref,
                                          loggedInUser: loggedInUser),
                                      splashColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      child: ProfileItem(
                                          title:
                                              profileOptions.elementAt(index),
                                          icon: profileOptionIcons
                                              .elementAt(index)),
                                    )))))
                  ])),

          //! SPACER
          const Spacer(),

          //! LOG OUT
          AppFadeAnimation(
              delay: 1.6,
              child: SizedBox(
                  width: double.infinity,
                  height: 45.0.h,
                  child: ElevatedButton(
                      onPressed: () async {
                        await ref
                            .read(authControllerProvider.notifier)
                            .logOut();

                        // ignore: use_build_context_synchronously
                        AppNavigator.removeUntilPage(
                            thePageRouteName: AppRoutes.authWrapperRoute,
                            context: context);
                      },
                      child: const AppTextWidget(
                          theText: AppTexts.logout,
                          textType: AppTextType.regularBody))))
        ]));
  }

  static void profileOptionsCTA(
      {required int index,
      required BuildContext context,
      required Size screenSize,
      required WidgetRef ref,
      required AsyncValue<UserModel> loggedInUser}) async {
    switch (index) {
      case 0:
        await AppUtils.pickImage().then((profilePhoto) async {
          if (profilePhoto == null) {
            "Select profile photo aborted".log();
            return;
          } else {
            await ref
                .read(uploadImageProvider.notifier)
                .uploadProfilePhoto(
                    userId: ref.read(authRepositoryProvider).userId!,
                    profilePhoto: profilePhoto,
                    fileType: FileType.image,
                    loggedInUser: loggedInUser.value!)
                .then((value) => value
                    ? "User profile photo uploaded".log()
                    : AppUtils.showBanner(
                        context: context,
                        theMessage: "User profile photo upload failed",
                        theType: NotificationType.failure))
                .catchError((error) => error.toString().log());
          }
        });
        break;
      case 1:
        AppNavigator.navigateToPage(
            thePageRouteName: AppRoutes.deletedDevices, context: context);
        break;
      case 2:
        AppUtils.showAppBottomSheet(
            context: context,
            height: screenSize.height * 0.3,
            width: screenSize.width,
            whenComplete: () {},
            child: const About());
        break;
      case 3:
        AppUtils.showAppBottomSheet(
            context: context,
            height: screenSize.height * 0.35,
            width: screenSize.width,
            whenComplete: () {},
            child: const ReportAProblem());
        break;
      default:
        "Profile options CTA called.".log();
    }
  }
}
