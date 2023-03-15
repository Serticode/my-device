//! CONSIDERING THE APP THEME, THE TEXT WIDGET;
//! WILL FOLLOW EITHER THE HEADER 1 STYLE OR BODY TEXT 2 STYLE.
//! this theme can be edited to match page design.
import 'package:flutter/material.dart';
import 'package:my_device/shared/utils/type_defs.dart';

class AppTextWidget extends StatelessWidget {
  final String theText;
  final AppTextType textType;
  const AppTextWidget({Key? key, required this.theText, required this.textType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(theText,
        style: textType == AppTextType.header
            ? Theme.of(context).textTheme.displayLarge
            : textType == AppTextType.subtitle
                ? Theme.of(context).textTheme.displayMedium
                : textType == AppTextType.boldBody
                    ? Theme.of(context).textTheme.bodyLarge
                    : Theme.of(context).textTheme.bodyMedium);
  }
}
