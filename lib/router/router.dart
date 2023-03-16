import 'package:flutter/material.dart';
import 'package:my_device/router/routes.dart';
import 'package:my_device/screens/auth/sign_in/sign_in.dart';
import 'package:my_device/screens/auth/sign_up/sign_up.dart';
import 'package:my_device/screens/home_wrapper.dart';

class AppNavigator {
  //! NAVIGATE TO A PAGE WITHOUT REPLACING THE PREVIOUS PAGE.
  static void navigateToPage(
          {required String thePageRouteName, required BuildContext context}) =>
      Navigator.of(context).pushNamed(thePageRouteName);

  //! NAVIGATE TO A PAGE AND REPLACE THE PREVIOUS PAGE
  static void navigateToReplacementPage(
          {required String thePageRouteName, required BuildContext context}) =>
      Navigator.of(context).pushReplacementNamed(thePageRouteName);

  static Route<dynamic> generateRoute({required RouteSettings routeSettings}) {
    switch (routeSettings.name) {
      //! AUTH WRAPPER / HOME WRAPPER
      case AppRoutes.authWrapperRoute:
        return _getPageRoute(
            routeName: routeSettings.name,
            args: routeSettings.arguments,
            view: const HomeWrapper());

      //! SIGN IN
      case AppRoutes.signInRoute:
        return _getPageRoute(
            routeName: routeSettings.name,
            args: routeSettings.arguments,
            view: const SignIn());

      //! SIGN UP
      case AppRoutes.signUpRoute:
        return _getPageRoute(
            routeName: routeSettings.name,
            args: routeSettings.arguments,
            view: const SignUp());

      //! HOME SCREEN
      case AppRoutes.homeScreenRoute:
        return _getPageRoute(
            routeName: routeSettings.name,
            args: routeSettings.arguments,
            view: Scaffold(
              body: Container(color: Colors.red),
            ));

      //! DEFAULT
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                body: Center(
                    child:
                        Text('No route defined for ${routeSettings.name}'))));
    }
  }
}

//! GET A PAGE ROUTE
PageRoute _getPageRoute({String? routeName, Widget? view, Object? args}) {
  return MaterialPageRoute(
      settings: RouteSettings(name: routeName, arguments: args),
      builder: (_) => view!);
}
