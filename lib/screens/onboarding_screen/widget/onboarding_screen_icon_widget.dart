import 'package:flutter/material.dart';

class AppOnboardingScreenIconWidget extends StatelessWidget {
  final IconData theIcon;
  final Color theIconBGColour;
  const AppOnboardingScreenIconWidget(
      {Key? key, required this.theIcon, required this.theIconBGColour})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
        elevation: 10.0,
        borderRadius: BorderRadius.circular(70),
        color: Colors.transparent,
        child: CircleAvatar(
            radius: 50.0,
            backgroundColor: Theme.of(context).colorScheme.secondary,
            child: CircleAvatar(
                radius: 45.0,
                backgroundColor: theIconBGColour,
                child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Icon(theIcon,
                        size: 42.0,
                        color: Theme.of(context).colorScheme.secondary)))));
  }
}
