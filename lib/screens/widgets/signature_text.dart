import 'package:flutter/material.dart';
import 'package:my_device/screens/widgets/app_custom_text_widget.dart';
import 'package:my_device/shared/utils/type_defs.dart';
import 'package:my_device/theme/app_theme.dart';

class SignatureText extends StatelessWidget {
  const SignatureText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppTextWidget(
        theText: "My Device, by Serticode.",
        textType: AppTextType.regularBody,
        textColour: AppColours.lettersAndIconsFaintColour);
  }
}
