import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_device/firebase_options.dart';
import 'package:my_device/router/router.dart';
import 'package:my_device/screens/auth/auth_wrapper.dart';
import 'package:my_device/screens/home/home_wrapper.dart';
import 'package:my_device/screens/onboarding_screen/onboarding_screen.dart';
import 'package:my_device/settings/settings.dart';
import 'package:my_device/shared/constants/app_texts.dart';
import 'package:my_device/theme/app_theme.dart';
import 'services/providers/is_logged_in/is_logged_in_provider.dart';

Future<void> main() async {
  //! INITIALIZE WIDGETS BINDING
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  //! CHECK IF ONBOARDING SCREEN HAS BEEN VISITED.
  final bool showHome = await AppSettings.getShowHome() ?? false;

  //! APP RUNNING STARTS HERE.
  runApp(ProviderScope(child: RetroPay(showHome: showHome)));
}

class RetroPay extends ConsumerWidget {
  final bool showHome;
  const RetroPay({super.key, required this.showHome});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: false,
        builder: (context, child) => MaterialApp(
            debugShowCheckedModeBanner: false,
            title: AppTexts.appName,

            //! THEME
            theme: AppTheme.instance.theTheme,

            //! NAVIGATION
            onGenerateRoute: (settings) =>
                AppNavigator.generateRoute(routeSettings: settings),

            //! SHOW HOME
            home: Consumer(builder: (context, ref, child) {
              final bool isLoggedIn = ref.watch(isLoggedInProvider);

              if (isLoggedIn) {
                return const HomeWrapper();
              } else if (showHome) {
                return const AuthWrapper();
              } else {
                return const OnboardingScreen();
              }
            })));
  }
}
