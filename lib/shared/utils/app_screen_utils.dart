import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

//! SCREEN UTILS
class AppScreenUtils {
  //! APP SPACERS
  //! HORIZONTAL SPACES
  static Widget horizontalSpaceTiny = SizedBox(width: 10.0.w);
  static Widget horizontalSpaceSmall = SizedBox(width: 20.0.w);
  static Widget horizontalSpaceMedium = SizedBox(width: 30.0.w);
  static Widget horizontalSpaceLarge = SizedBox(width: 60.0.w);

  //! VERTICAL SPACES
  static Widget verticalSpaceTiny = SizedBox(height: 10.0.h);
  static Widget verticalSpaceSmall = SizedBox(height: 20.0.h);
  static Widget verticalSpaceMedium = SizedBox(height: 30.0.h);
  static Widget verticalSpaceLarge = SizedBox(height: 60.0.h);

  //! APP CONSTANT PADDING
  static final EdgeInsets defaultPadding =
      EdgeInsets.symmetric(horizontal: 18.0.w, vertical: 6.0.h);
  static final EdgeInsets textFormFieldPadding =
      EdgeInsets.symmetric(horizontal: 21.0.w, vertical: 21.0.h);
  static final EdgeInsets elevatedButtonPadding =
      EdgeInsets.symmetric(horizontal: 32.0.w, vertical: 4.0.h);
}

//! UI UTILS
class SertidriveUIUtils {
  static void showSnackBar(
      {required theBuildContext, required String theMessage}) {
    ScaffoldMessenger.of(theBuildContext).showSnackBar(SnackBar(
        content: Text(theMessage, textAlign: TextAlign.center),
        padding: AppScreenUtils.elevatedButtonPadding,
        duration: const Duration(seconds: 2)));
  }
}
