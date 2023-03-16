import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_device/router/router.dart';
import 'package:my_device/screens/onboarding_screen/onboarding_screen.dart';
import 'package:my_device/settings/settings.dart';
import 'package:my_device/shared/constants/app_texts.dart';
import 'package:my_device/shared/utils/register_model_adapters.dart';
import 'package:my_device/theme/app_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  //! INITIALIZE WIDGETS BINDING
  WidgetsFlutterBinding.ensureInitialized();

  //! INITIALIZE DB AND REGISTER ADAPTERS
  await RegisterAdapters.initializeBDAndRegisterAdapters();

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
            theme: AppTheme.theTheme,

            //! NAVIGATION
            onGenerateRoute: (settings) =>
                AppNavigator.generateRoute(routeSettings: settings),

            //! SHOW HOME
            home: showHome
                ? Container(color: Colors.blue)
                : const OnboardingScreen()));
  }
}
