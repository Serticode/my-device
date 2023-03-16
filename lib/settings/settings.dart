//! THIS IS USED TO HOUSE THE USER AND APP PREFERENCES
//! ONBOARDING SCREEN COUNT HAS BEEN SET. IF VALUE IS GREATER THAN 0 ...
//! ONBOARDING SCREEN HAS BEEN VISITED. ELSE, VALUE IS NULL OR O ...
//! MEANING, ONBOARDING SCREEN HASN'T BEEN VISITED AND HAS BEEN LOADED TO THE USER SCREEN.

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppSettings with ChangeNotifier {
  //! CREATE SINGLE INSTANCE
  AppSettings._();
  static final _instance = AppSettings._();

  //! RETRIEVE INSTANCE
  static AppSettings get instance => _instance;

  //! SHARED PREF INSTANCE
  static final Future<SharedPreferences> pref = SharedPreferences.getInstance();

  //! SET SHOW HOME
  static Future<void> setShowHome({required bool showHome}) async =>
      await pref.then((value) => value.setBool("showHome", showHome));

  //! GET SHOW HOME
  static Future<bool?> getShowHome() async =>
      await pref.then((value) => value.getBool("showHome"));
}
