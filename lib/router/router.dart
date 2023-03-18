import 'package:flutter/material.dart';
import 'package:my_device/router/routes.dart';
import 'package:my_device/screens/auth/sign_in/sign_in.dart';
import 'package:my_device/screens/auth/sign_up/sign_up.dart';
import 'package:my_device/screens/auth/auth_wrapper.dart';
import 'package:my_device/screens/home/home_wrapper.dart';
import 'package:my_device/screens/home/widgets/add_device.dart';
import 'package:my_device/screens/home/widgets/home_screen.dart';
import 'package:my_device/screens/home/widgets/view_device.dart';
import 'package:my_device/screens/profile/widgets/deleted_devices.dart';

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
            view: const AuthWrapper());

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
      case AppRoutes.homeWrapperRouter:
        return _getPageRoute(
            routeName: routeSettings.name,
            args: routeSettings.arguments,
            view: const HomeWrapper());

      //! HOME SCREEN
      case AppRoutes.homeScreenRoute:
        return _getPageRoute(
            routeName: routeSettings.name,
            args: routeSettings.arguments,
            view: const HomeScreen());

      //! ADD DEVICE
      case AppRoutes.addDevice:
        return _getPageRoute(
            routeName: routeSettings.name,
            args: routeSettings.arguments,
            view: const AddDevice());

      //! VIEW DEVICE
      case AppRoutes.viewDevice:
        return _getPageRoute(
            routeName: routeSettings.name,
            args: routeSettings.arguments,
            view: const ViewDeviceScreen());

      //! VIEW DEVICE
      case AppRoutes.deletedDevices:
        return _getPageRoute(
            routeName: routeSettings.name,
            args: routeSettings.arguments,
            view: const DeletedDevices());

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
