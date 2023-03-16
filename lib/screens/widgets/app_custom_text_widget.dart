//! CONSIDERING THE APP THEME, THE TEXT WIDGET;
//! WILL FOLLOW EITHER THE HEADER 1 STYLE OR BODY TEXT 2 STYLE.
//! this theme can be edited to match page design.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_device/shared/utils/type_defs.dart';

class AppTextWidget extends ConsumerWidget {
  final String theText;
  final AppTextType textType;
  final Color? textColour;
  const AppTextWidget(
      {Key? key,
      required this.theText,
      required this.textType,
      this.textColour})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) => Text(theText,
      style: textType == AppTextType.header
          ? Theme.of(context)
              .textTheme
              .displayLarge
              ?.copyWith(color: textColour)
          : textType == AppTextType.subtitle
              ? Theme.of(context)
                  .textTheme
                  .displayMedium
                  ?.copyWith(color: textColour)
              : textType == AppTextType.boldBody
                  ? Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(color: textColour)
                  : Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: textColour));
}
