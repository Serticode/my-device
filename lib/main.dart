import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_device/router/router.dart';
import 'package:my_device/screens/auth/auth_wrapper.dart';
import 'package:my_device/screens/onboarding_screen/onboarding_screen.dart';
import 'package:my_device/settings/settings.dart';
import 'package:my_device/shared/constants/app_texts.dart';
import 'package:my_device/theme/app_theme.dart';

Future<void> main() async {
  //! INITIALIZE WIDGETS BINDING
  WidgetsFlutterBinding.ensureInitialized();

  //! CHECK IF ONBOARDING SCREEN HAS BEEN VISITED.
  final bool showHome = await AppSettings.getShowHome() ?? false;

  //! APP RUNNING STARTS HERE.
  runApp(ProviderScope(child: RetroPay(showHome: showHome)));
}

class RetroPay extends ConsumerWidget {
  final bool showHome;
  const RetroPay({super.key, required this.showHome});

  @override
  Widget build(BuildContext context, WidgetRef ref) => ScreenUtilInit(
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
          home: showHome ? const AuthWrapper() : const OnboardingScreen()));
}
