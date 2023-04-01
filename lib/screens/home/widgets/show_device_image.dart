import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_device/theme/app_theme.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class ShowDeviceImage extends ConsumerWidget {
  const ShowDeviceImage({required this.devicePictures, super.key});
  final List devicePictures;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CarouselSlider(
        disableGesture: true,
        options: CarouselOptions(
            aspectRatio: 16 / 9,
            viewportFraction: 1,
            initialPage: 0,
            enableInfiniteScroll: true,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 3),
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            autoPlayCurve: Curves.fastOutSlowIn,
            enlargeCenterPage: true,
            enlargeFactor: 0.8,
            scrollDirection: Axis.horizontal),
        items: devicePictures.map((image) {
          return ClipRRect(
              borderRadius: BorderRadius.circular(12.0.r),
              child: CachedNetworkImage(
                  imageUrl: image,
                  fit: BoxFit.cover,
                  progressIndicatorBuilder: (context, url, progress) =>
                      LinearProgressIndicator(
                          value: progress.progress,
                          color: AppColours.appBlue,
                          backgroundColor: AppColours.appWhite),
                  errorWidget: (context, url, error) =>
                      Icon(PhosphorIcons.xBold, size: 18.0.sp)));
        }).toList());
  }
}
