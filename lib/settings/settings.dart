//! THIS IS USED TO HOUSE THE USER AND APP PREFERENCES
//! ONBOARDING SCREEN COUNT HAS BEEN SET. IF VALUE IS GREATER THAN 0 ...
//! ONBOARDING SCREEN HAS BEEN VISITED. ELSE, VALUE IS NULL OR O ...
//! MEANING, ONBOARDING SCREEN HASN'T BEEN VISITED AND HAS BEEN LOADED TO THE USER SCREEN.

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppSettings with ChangeNotifier {
  //! ONBOARDING SCREEN COUNT.
  int _onboardingScreenCount = 0;

  //! LOAD THE SAVED APP & USER PREFERENCES THROUGH THE SETTINGS CONSTRUCTOR.
  //! THIS HELPS TO RESTORE APP STATE TO PREVIOUS VERSION BEFORE APP WAS CLOSED.
  AppSettings() {
    loadPreferences();
  }

  void setOnboardingScreenCount({required int onboardingScreenCount}) {
    _onboardingScreenCount = onboardingScreenCount;
    notifyListeners();
    savePreferences();
  }

  //!SHARED PREFERENCES
  void savePreferences() async {
    SharedPreferences userPreference = await SharedPreferences.getInstance();
    userPreference.setInt("onboardingScreenCount", _onboardingScreenCount);
  }

  void loadPreferences() async {
    SharedPreferences userPreference = await SharedPreferences.getInstance();
    int? onboardingScreenCount =
        userPreference.getInt("onboardingScreenCount") ?? 0;

    setOnboardingScreenCount(onboardingScreenCount: onboardingScreenCount);
  }
}
