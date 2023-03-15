import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_device/router/router.dart';
import 'package:my_device/shared/constants/app_texts.dart';
import 'package:my_device/shared/utils/register_model_adapters.dart';
import 'package:my_device/theme/app_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  //! INITIALIZE WIDGETS BINDING
  WidgetsFlutterBinding.ensureInitialized();

  //! INITIALIZE DB AND REGISTER ADAPTERS
  await RegisterAdapters.initializeBDAndRegisterAdapters();

  //! ONBOARDING STARTS HERE - SHARED PREFERENCES FOR ONBOARDING SCREEN
  SharedPreferences appPreferences = await SharedPreferences.getInstance();

  //! CHECK IF ONBOARDING SCREEN HAS BEEN VISITED.
  final bool showHome = appPreferences.getBool("showHome") ?? false;

  //! APP RUNNING STARTS HERE.
  runApp(ProviderScope(child: RetroPay(showHome: showHome)));
}

class RetroPay extends ConsumerStatefulWidget {
  final bool showHome;
  const RetroPay({super.key, required this.showHome});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RetroPayState();
}

class _RetroPayState extends ConsumerState<RetroPay> {
  @override
  Widget build(BuildContext context) {
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
            home: Container(color: Colors.blue)));
  }
}
