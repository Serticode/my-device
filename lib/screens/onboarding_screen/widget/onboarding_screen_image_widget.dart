import 'package:flutter/material.dart';

class OnboardingScreenImageWidget extends StatelessWidget {
  final String theAssetImageURL;
  const OnboardingScreenImageWidget({Key? key, required this.theAssetImageURL})
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
                backgroundColor: Colors.white,
                child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Image(
                        image: AssetImage(theAssetImageURL),
                        fit: BoxFit.contain)))));
  }
}
