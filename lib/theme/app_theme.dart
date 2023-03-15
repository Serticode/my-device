import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_device/shared/utils/app_screen_utils.dart';

class AppTheme {
  static ThemeData get theTheme {
    return ThemeData(
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
                fontSize: 38.0,
                color: AppColours.lettersAndIconsColour),
            displayMedium: GoogleFonts.poppins(
                fontWeight: FontWeight.w700,
                fontSize: 28.0,
                color: AppColours.lettersAndIconsColour),
            bodyMedium: GoogleFonts.poppins(
                fontWeight: FontWeight.w500,
                color: AppColours.lettersAndIconsColour,
                fontSize: 14.0)),

        //! ELEVATED BUTTON
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
                padding: AppScreenUtils.textFormFieldPadding,
                backgroundColor: AppColours.elevatedButtonBackgroundColour,
                textStyle: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500,
                    color: AppColours.lettersAndIconsColour,
                    fontSize: 16.0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(21.0)))),

        //! INPUT DECORATION
        inputDecorationTheme: InputDecorationTheme(
            contentPadding: AppScreenUtils.textFormFieldPadding,
            filled: true,
            fillColor: AppColours.lettersAndIconsFaintColour.withOpacity(0.5),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(21.0)),
            focusColor: AppColours.focusedTextFormFieldColour,
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    width: 1.2, color: AppColours.focusedTextFormFieldColour),
                borderRadius: BorderRadius.circular(21.0)),
            hintStyle: GoogleFonts.poppins(
                fontWeight: FontWeight.w500,
                color: AppColours.lettersAndIconsFaintColour,
                fontSize: 14.0)),
        colorScheme: ColorScheme.fromSwatch()
            .copyWith(
                primary: AppColours.primaryColour,
                secondary: AppColours.secondaryColour,
                secondaryContainer: AppColours.containersBackgroundColour,
                shadow: Colors.grey.shade100.withOpacity(0.2))
            .copyWith(background: AppColours.primaryColour));
  }
}

//! COLOURS USED THROUGH OUT THE APP
class AppColours {
  static Color primaryColour = const Color(0xFF0B0C0F);
  static Color secondaryColour = const Color(0xFF1A224C);
  static Color tertiaryColour = Colors.white;
  static Color lettersAndIconsColour = Colors.white;
  static Color lettersAndIconsFaintColour = const Color(0xFF565759);
  static Color focusedTextFormFieldColour = const Color(0xFF0B29EF);

  static Color elevatedButtonBackgroundColour = const Color(0xFF0B29EF);
  static Color containersBackgroundColour = const Color(0xFF565759);
  static Color snackbarBackgroundColour = const Color(0xFF0B29EF);
}
