import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_device/shared/constants/app_images.dart';
import 'package:my_device/theme/app_theme.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class ProfilePicture extends StatelessWidget {
  final String imageURL;
  final BoxFit? boxFit;
  final double? largerRadius;
  final double? smallerRadius;
  final double? iconSize;

  const ProfilePicture({
    Key? key,
    required this.imageURL,
    this.boxFit,
    this.largerRadius,
    this.smallerRadius,
    this.iconSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => imageURL.isEmpty
      ?
      //! IMAGE URL HAS NO CONTENT
      CircleAvatar(
          radius: largerRadius ?? 24.0.r,
          backgroundColor: AppColours.primaryColour,
          child: CircleAvatar(
              radius: smallerRadius ?? 21.0.r,
              backgroundColor: AppColours.appGreyFaint,
              child: Transform.scale(
                  scale: 0.6.sp,
                  child: Image.asset(AppImages.defaultUser,
                      filterQuality: FilterQuality.high, fit: BoxFit.contain))))
      :

      //! DISPLAY AWAY !
      CircleAvatar(
          radius: largerRadius ?? 24.0.r,
          backgroundColor: AppColours.primaryColour,
          child: CircleAvatar(
              radius: smallerRadius ?? 21.0.r,
              backgroundColor: AppColours.appGreyFaint,
              child: CachedNetworkImage(
                  imageUrl: imageURL,
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      CircularProgressIndicator(
                          backgroundColor: AppColours.appBlue,
                          color: AppColours.appGreyFaint,
                          value: downloadProgress.progress),
                  errorWidget: (context, url, error) => Icon(
                      PhosphorIcons.circleWavyWarningBold,
                      size: 18.0.sp,
                      color: AppColours.appBlue),
                  fit: boxFit ?? BoxFit.contain)));
}
