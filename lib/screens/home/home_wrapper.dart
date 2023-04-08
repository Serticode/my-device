import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_device/router/router.dart';
import 'package:my_device/router/routes.dart';
import 'package:my_device/screens/home/widgets/app_bar.dart';
import 'package:my_device/screens/home/widgets/home_screen.dart';
import 'package:my_device/screens/news_feed/news_feed.dart';
import 'package:my_device/screens/profile/profile.dart';
import 'package:my_device/screens/widgets/profile_picture.dart';
import 'package:my_device/services/models/auth/user_model/user_model.dart';
import 'package:my_device/services/providers/auth_state/auth_state_provider.dart';
import 'package:my_device/services/providers/upload_image/upload_image_provider.dart';
import 'package:my_device/services/providers/user_info/user_info_provider.dart';
import 'package:my_device/shared/utils/app_extensions.dart';
import 'package:my_device/theme/app_theme.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class HomeWrapper extends ConsumerWidget {
  const HomeWrapper({super.key});
  //! PAGE INDEX
  static final ValueNotifier<int> currentPageIndex = ValueNotifier(0);
  //! LIST OF PAGES
  static const List<Widget> listOfPages = [HomeScreen(), NewsFeed(), Profile()];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(75.0.h),
            child: ValueListenableBuilder(
                valueListenable: currentPageIndex,
                child: const SizedBox.shrink(),
                builder: (context, value, child) => AppBarWidget(
                    onTap: () => "App Bar onTap".log(),
                    currentPage: currentPageIndex.value))),

        //! BODY
        body: SafeArea(
            child: ValueListenableBuilder(
                valueListenable: currentPageIndex,
                child: const SizedBox.shrink(),
                builder: (context, value, child) =>
                    listOfPages.elementAt(currentPageIndex.value))),

        //! FLOATING ACTION BUTTON
        floatingActionButton: ValueListenableBuilder(
            valueListenable: currentPageIndex,
            builder: (context, value, child) => currentPageIndex.value != 0
                ? const SizedBox.shrink()
                : FloatingActionButton(
                    onPressed: () => AppNavigator.navigateToPage(
                        thePageRouteName: AppRoutes.addDevice,
                        context: context),
                    backgroundColor: AppColours.appGreyFaint,
                    mini: true,
                    child: Icon(PhosphorIcons.plusBold,
                        size: 16.0.sp, color: AppColours.appBlue))),

        //! BOTTOM NAVIGATION BAR
        bottomNavigationBar: ValueListenableBuilder(
            valueListenable: currentPageIndex,
            builder: (context, value, child) => BottomNavigationBar(
                    backgroundColor: Colors.transparent,
                    elevation: 0.0.h,
                    selectedItemColor: AppColours.appWhite,
                    unselectedItemColor: AppColours.appGrey,
                    iconSize: 21.0.sp,
                    enableFeedback: true,

                    //! CHANGE CURRENT INDEX FOR BOTTOM NAV BAR
                    onTap: (value) => currentPageIndex.value = value,
                    currentIndex: currentPageIndex.value,

                    //! ITEMS
                    items: [
                      //! HomeWrapper
                      const BottomNavigationBarItem(
                          label: "Home",
                          icon: Icon(PhosphorIcons.houseSimpleBold)),

                      //! NOTIFICATIONS
                      const BottomNavigationBarItem(
                          label: "News Feed",
                          icon: Icon(PhosphorIcons.articleNyTimesBold)),

                      //! PROFILE PICTURE
                      BottomNavigationBarItem(
                          label: "Profile",
                          icon: Consumer(builder: (context, ref, child) {
                            return Consumer(builder: (context, ref, child) {
                              final bool isLoading =
                                  ref.watch(uploadImageProvider);
                              final AsyncValue<UserModel> loggedInUser =
                                  ref.watch(loggedInUserDetailsProvider(ref
                                      .read(authControllerProvider)
                                      .userId!));
                              return isLoading
                                  ? CircleAvatar(
                                      radius: 14.0.r,
                                      backgroundColor: AppColours.appWhite,
                                      child: Transform.scale(
                                          scale: 0.6,
                                          child: CircularProgressIndicator(
                                              color: AppColours.appGrey,
                                              backgroundColor:
                                                  AppColours.appBlue)))
                                  : ProfilePicture(
                                      imageURL:
                                          loggedInUser.value?.profilePhoto ??
                                              "",
                                      largerRadius: 14.0.r,
                                      smallerRadius: 12.0.r,
                                      boxFit: BoxFit.contain);
                            });
                          }))
                    ])));
  }
}
