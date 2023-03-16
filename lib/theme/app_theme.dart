import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_device/shared/utils/app_screen_utils.dart';

class AppTheme {
  //! CREATE SINGLE INSTANCE
  AppTheme._();
  static final _instance = AppTheme._();

  //! RETRIEVE INSTANCE
  static AppTheme get instance => _instance;

  //! THE THEME
  ThemeData get theTheme => ThemeData(
      //! GENERAL PAGE TRANSITIONS
      pageTransitionsTheme: const PageTransitionsTheme(builders: {
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        TargetPlatform.android: ZoomPageTransitionsBuilder()
      }),

      //! COLOURS
      scaffoldBackgroundColor: AppColours.primaryColour,
      shadowColor: Colors.grey.shade100.withOpacity(0.2),

      //! SNACK BAR THEME
      snackBarTheme: SnackBarThemeData(
          elevation: 8.0,
          backgroundColor: AppColours.snackbarBackgroundColour,
          contentTextStyle: GoogleFonts.poppins(
              fontWeight: FontWeight.w500,
              color: AppColours.lettersAndIconsColour,
              fontSize: 12.0),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(21.0),
                  topRight: Radius.circular(21.0)))),

      //! TEXT
      textTheme: TextTheme(
          displayLarge: GoogleFonts.poppins(
              fontWeight: FontWeight.w700,
              fontSize: 40.0.sp,
              color: AppColours.lettersAndIconsColour),
          displayMedium: GoogleFonts.poppins(
              fontWeight: FontWeight.w700,
              fontSize: 30.0.sp,
              color: AppColours.lettersAndIconsColour),
          bodyLarge: GoogleFonts.poppins(
              fontWeight: FontWeight.w500,
              color: AppColours.lettersAndIconsColour,
              fontSize: 18.0.sp),
          bodyMedium: GoogleFonts.poppins(
              fontWeight: FontWeight.w400,
              color: AppColours.lettersAndIconsColour,
              fontSize: 14.0.sp)),

      //! ELEVATED BUTTON
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              padding: AppScreenUtils.elevatedButtonPadding,
              backgroundColor: AppColours.elevatedButtonBackgroundColour,
              textStyle: GoogleFonts.poppins(
                  fontWeight: FontWeight.w500,
                  color: AppColours.lettersAndIconsColour,
                  fontSize: 13.0.sp),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32.0.r)))),

      //! INPUT DECORATION
      inputDecorationTheme: InputDecorationTheme(
          contentPadding: AppScreenUtils.textFormFieldPadding,
          filled: true,
          fillColor: AppColours.lettersAndIconsFaintColour.withOpacity(0.3),
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(21.0.r)),
          focusColor: AppColours.focusedTextFormFieldColour,
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  width: 1.2, color: AppColours.focusedTextFormFieldColour),
              borderRadius: BorderRadius.circular(21.0.r)),
          hintStyle: GoogleFonts.poppins(
              fontWeight: FontWeight.w500,
              color: AppColours.lettersAndIconsFaintColour,
              fontSize: 14.0.sp)),

      //! COLOUR SCHEME
      colorScheme: ColorScheme.fromSwatch()
          .copyWith(
              primary: AppColours.primaryColour,
              secondary: AppColours.secondaryColour,
              secondaryContainer: AppColours.containersBackgroundColour,
              shadow: Colors.grey.shade100.withOpacity(0.2))
          .copyWith(background: AppColours.primaryColour));
}

//! COLOURS USED THROUGH OUT THE APP
class AppColours {
  static Color primaryColour = const Color(0xFF0B0C0F);
  static Color secondaryColour = const Color(0xFF1A224C);
  static Color tertiaryColour = Colors.white;
  static Color lettersAndIconsColour = Colors.white;
  static const Color lettersAndIconsFaintColour = Color(0xFF565759);
  static Color focusedTextFormFieldColour = const Color(0xFF0B29EF);

  static Color elevatedButtonBackgroundColour = const Color(0xFF0B29EF);
  static Color containersBackgroundColour = const Color(0xFF565759);
  static Color snackbarBackgroundColour = const Color(0xFF0B29EF);

  //! BASIC COLOURS
  static Color appBlue = const Color(0xFF0B29EF);
  static const Color appWhite = Colors.white;
}
