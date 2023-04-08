// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_device/screens/home/home_wrapper.dart';
import 'package:my_device/screens/widgets/animated_button.dart';
import 'package:my_device/screens/widgets/app_custom_text_widget.dart';
import 'package:my_device/services/models/device/device_model.dart';
import 'package:my_device/services/models/device/found_device_model.dart';
import 'package:my_device/services/providers/user_devices_controller/user_devices_controller_provider.dart';
import 'package:my_device/shared/constants/app_texts.dart';
import 'package:my_device/shared/utils/app_extensions.dart';
import 'package:my_device/shared/utils/app_fade_animation.dart';
import 'package:my_device/shared/utils/app_multi_value_listenable_builder.dart';
import 'package:my_device/shared/utils/app_screen_utils.dart';
import 'package:my_device/shared/utils/type_defs.dart';
import 'package:my_device/shared/utils/utils.dart';
import 'package:my_device/theme/app_theme.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

ValueNotifier<List<File>>? _securityPersonnelImage = ValueNotifier([]);
List<String> devicePictureNames = [
  "Security personnel picture",
];
ValueNotifier<List<bool>> _arePicturesAdded =
    ValueNotifier([false, false, false, false]);
ValueNotifier<int> _currentSelectedIndex = ValueNotifier(0);

class MarkAsFound extends ConsumerStatefulWidget {
  final DeviceModel theDevice;
  const MarkAsFound({super.key, required this.theDevice});

  @override
  ConsumerState<MarkAsFound> createState() => _MarkAsFoundState();
}

class _MarkAsFoundState extends ConsumerState<MarkAsFound> {
  final ValueNotifier<TextEditingController> serialNumberController =
      ValueNotifier(TextEditingController());
  final ValueNotifier<TextEditingController> modelNumberController =
      ValueNotifier(TextEditingController());
  final ValueNotifier<TextEditingController> colourController =
      ValueNotifier(TextEditingController());
  final ValueNotifier<TextEditingController> brandController =
      ValueNotifier(TextEditingController());
  final ValueNotifier<TextEditingController> deviceNameController =
      ValueNotifier(TextEditingController());
  final ValueNotifier<TextEditingController> deviceTypeController =
      ValueNotifier(TextEditingController());
  final ValueNotifier<TextEditingController> securityPersonnelNameController =
      ValueNotifier(TextEditingController());
  final ValueNotifier<TextEditingController> securityPersonnelIDController =
      ValueNotifier(TextEditingController());

  ValueNotifier<bool> isDeviceTypeTapped = ValueNotifier(false);
  ValueNotifier<DeviceType> selectedDeviceType =
      ValueNotifier(DeviceType.smartPhone);

  ValueNotifier<List<DeviceType>> deviceTypes =
      ValueNotifier(DeviceType.values);
  ValueNotifier<bool> isDeviceTypeSelected = ValueNotifier(false);

  void toggleSelectDeviceType() =>
      isDeviceTypeTapped.value = !isDeviceTypeTapped.value;

  @override
  void initState() {
    super.initState();
    serialNumberController.value.text = widget.theDevice.serialNumber!;
    modelNumberController.value.text = widget.theDevice.modelNumber!;
    colourController.value.text = widget.theDevice.deviceColour!;
    brandController.value.text = widget.theDevice.brand!;
    deviceNameController.value.text = widget.theDevice.deviceName!;
    deviceTypeController.value.text = widget.theDevice.deviceType!;
  }

  @override
  void dispose() {
    serialNumberController.dispose();
    modelNumberController.dispose();
    colourController.dispose();
    brandController.dispose();
    deviceNameController.dispose();
    deviceTypeController.dispose();
    _securityPersonnelImage?.value = [];
    _arePicturesAdded.value = [false, false, false, false];
    _currentSelectedIndex.value = 0;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: false,
            elevation: 0.0.h,
            shadowColor: Colors.transparent,
            title: const AppTextWidget(
                theText: "Mark as found", textType: AppTextType.boldBody)),

        //! CONTENT
        body: SafeArea(
            child: SingleChildScrollView(
                padding: AppScreenUtils.defaultPadding,
                physics: const BouncingScrollPhysics(),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //! DEVICE NAME
                      const AppFadeAnimation(
                          delay: 1.6,
                          child: AppTextWidget(
                              theText: "Add pictures of the device",
                              textType: AppTextType.regularBody)),

                      //! SPACER
                      AppScreenUtils.verticalSpaceTiny,

                      //! ADD DEVICE IMAGE
                      const MarkAsFoundImage(),

                      //! SPACER
                      AppScreenUtils.verticalSpaceSmall,

                      //! TRACER
                      SizedBox(
                          width: double.infinity,
                          child: ValueListenableBuilder(
                              valueListenable: _arePicturesAdded,
                              builder: (context, value, child) => Column(
                                    children: devicePictureNames
                                        .map((name) => Row(children: [
                                              //! ICON
                                              Icon(PhosphorIcons.checks,
                                                  color: _arePicturesAdded.value
                                                          .elementAt(
                                                              devicePictureNames
                                                                  .indexOf(
                                                                      name))
                                                      ? Colors.green
                                                      : AppColours.appWhite),

                                              //! SPACER
                                              AppScreenUtils
                                                  .horizontalSpaceTiny,

                                              //! NAME
                                              Text(name)
                                            ]))
                                        .toList(),
                                  ))),

                      //! SPACER
                      AppScreenUtils.verticalSpaceSmall,

                      //! NOTICE
                      const AppFadeAnimation(
                          delay: 1.6,
                          child: AppTextWidget(
                              theText:
                                  "The device details are already filled and shown below, Kindly provide the security personnel details in the provided box",
                              textType: AppTextType.regularBody)),

                      //! SPACER
                      AppScreenUtils.verticalSpaceSmall,

                      //! SECURITY PERSONNEL NAME
                      TextFormField(
                          style: Theme.of(context).textTheme.bodyMedium,
                          cursorColor: AppColours.lettersAndIconsColour,
                          controller: securityPersonnelNameController.value,
                          decoration: const InputDecoration(
                              hintText: AppTexts.securityPersonnelName)),

                      //! SPACER
                      AppScreenUtils.verticalSpaceTiny,

                      //! SECURITY PERSONNEL NUMBER
                      TextFormField(
                          style: Theme.of(context).textTheme.bodyMedium,
                          cursorColor: AppColours.lettersAndIconsColour,
                          controller: securityPersonnelIDController.value,
                          decoration: const InputDecoration(
                              hintText: AppTexts.securityPersonnelStaffID)),

                      //! SPACER
                      AppScreenUtils.verticalSpaceTiny,

                      Row(children: [
                        //! MODEL NUMBER
                        Expanded(
                            child: TextFormField(
                                enabled: false,
                                style: Theme.of(context).textTheme.bodyMedium,
                                cursorColor: AppColours.lettersAndIconsColour,
                                decoration: InputDecoration(
                                    hintMaxLines: 2,
                                    hintText:
                                        "${AppTexts.modelNumber}: ${modelNumberController.value.text} "))),

                        //! SPACER
                        AppScreenUtils.horizontalSpaceTiny,

                        //! SERIAL NUMBER
                        Expanded(
                            child: TextFormField(
                                enabled: false,
                                style: Theme.of(context).textTheme.bodyMedium,
                                cursorColor: AppColours.lettersAndIconsColour,
                                decoration: InputDecoration(
                                    hintMaxLines: 2,
                                    hintText:
                                        "${AppTexts.serialNumber}: ${serialNumberController.value.text} ")))
                      ]),

                      //! SPACER
                      AppScreenUtils.verticalSpaceTiny,

                      Row(children: [
                        //! DEVICE COLOUR
                        Expanded(
                            child: TextFormField(
                                enabled: false,
                                style: Theme.of(context).textTheme.bodyMedium,
                                cursorColor: AppColours.lettersAndIconsColour,
                                decoration: InputDecoration(
                                    hintMaxLines: 2,
                                    hintText:
                                        "${AppTexts.colour}: ${colourController.value.text} "))),

                        //! SPACER
                        AppScreenUtils.horizontalSpaceTiny,

                        //! BRAND
                        Expanded(
                            child: TextFormField(
                                enabled: false,
                                style: Theme.of(context).textTheme.bodyMedium,
                                cursorColor: AppColours.lettersAndIconsColour,
                                decoration: InputDecoration(
                                    hintMaxLines: 2,
                                    hintText:
                                        "${AppTexts.deviceBrand}: ${brandController.value.text} ")))
                      ]),

                      //! SPACER
                      AppScreenUtils.verticalSpaceTiny,

                      Row(children: [
                        //! DEVICE NAME
                        Expanded(
                            child: TextFormField(
                                enabled: false,
                                style: Theme.of(context).textTheme.bodyMedium,
                                cursorColor: AppColours.lettersAndIconsColour,
                                decoration: InputDecoration(
                                    hintMaxLines: 2,
                                    hintText:
                                        "${AppTexts.deviceName}: ${deviceNameController.value.text} "))),

                        //! SPACER
                        AppScreenUtils.horizontalSpaceTiny,

                        //! DEVICE TYPE
                        Expanded(
                            child: TextFormField(
                                enabled: false,
                                style: Theme.of(context).textTheme.bodyMedium,
                                cursorColor: AppColours.lettersAndIconsColour,
                                decoration: InputDecoration(
                                    hintMaxLines: 2,
                                    hintText:
                                        "${AppTexts.deviceType}: ${deviceTypeController.value.text} ")))
                      ]),

                      //! SPACER
                      AppScreenUtils.verticalSpaceTiny,

                      //! BUTTON
                      Center(
                          child: AppFadeAnimation(
                              delay: 1.6,
                              child: Consumer(builder: (context, ref, child) {
                                final bool isLoading =
                                    ref.watch(deviceControllerProvider);
                                final double width = isLoading
                                    ? 56.w
                                    : MediaQuery.of(context).size.width;
                                final double radius =
                                    isLoading ? 56.0.r : 21.0.r;

                                return IgnorePointer(
                                    ignoring: isLoading,
                                    child: AnimatedButton(
                                        height: 45.0.h,
                                        width: width,
                                        radius: radius,
                                        content: Center(
                                            child: isLoading
                                                ? Transform.scale(
                                                    scale: 0.7,
                                                    child:
                                                        const CircularProgressIndicator(
                                                            color: AppColours
                                                                .appWhite))
                                                : const AppTextWidget(
                                                    theText:
                                                        AppTexts.markAsFound,
                                                    textType: AppTextType
                                                        .regularBody)),
                                        onTap: () async {
                                          if (securityPersonnelIDController
                                                  .value.text.isNotEmpty &&
                                              securityPersonnelNameController
                                                  .value.text.isNotEmpty &&
                                              _securityPersonnelImage!
                                                  .value.isNotEmpty) {
                                            final FoundDeviceModel foundDevice =
                                                FoundDeviceModel(
                                                    createdAt: DateTime.now(),
                                                    device: widget.theDevice,
                                                    securityPersonnelID:
                                                        securityPersonnelIDController
                                                            .value.text,
                                                    securityPersonnelName:
                                                        securityPersonnelNameController
                                                            .value.text,
                                                    securityPersonnelImage:
                                                        _securityPersonnelImage!
                                                            .value);
                                            await ref
                                                .read(deviceControllerProvider
                                                    .notifier)
                                                .markAsFound(
                                                    device: foundDevice)
                                                .then((value) async => value
                                                        .isRight()
                                                    ? {
                                                        await clearControllers(),
                                                        Navigator.of(context)
                                                            .pushAndRemoveUntil(
                                                                MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            const HomeWrapper()),
                                                                (route) =>
                                                                    false)
                                                      }
                                                    : "Add Device failed".log())
                                                // ignore: body_might_complete_normally_catch_error
                                                .catchError((error) {
                                              error.toString.log();
                                            });
                                          } else {
                                            AppUtils.showBanner(
                                                context: context,
                                                theMessage:
                                                    "At lease one field is empty OR you have less than four pictures for your device",
                                                theType: NotificationType.info);
                                          }
                                        }));
                              })))
                    ]))));
  }

  Future<void> clearControllers() async {
    deviceNameController.value.clear();
    serialNumberController.value.clear();
    modelNumberController.value.clear();
    brandController.value.clear();
    colourController.value.clear();
  }
}

//! DEVICE DETAIL WIDGET
class DeviceDetail extends ConsumerWidget {
  final String label;
  final String value;
  const DeviceDetail({
    super.key,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
        padding: AppScreenUtils.defaultPadding,
        width: double.infinity,
        decoration: BoxDecoration(
            color: AppColours.appGreyFaint.withOpacity(0.1),
            border: Border.all(color: AppColours.appGreyFaint, width: 2.0.sp),
            borderRadius: BorderRadius.circular(12.0.r)),
        child: Row(children: [
          //! LABEL
          AppTextWidget(theText: "$label :", textType: AppTextType.regularBody),

          //! SPACER
          AppScreenUtils.horizontalSpaceTiny,

          AppTextWidget(theText: value, textType: AppTextType.regularBody)
        ]));
  }
}

//!
//! ADD DEVICE IMAGE
class MarkAsFoundImage extends ConsumerWidget {
  const MarkAsFoundImage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
        height: MediaQuery.of(context).size.height * 0.3,
        width: double.infinity,
        decoration: BoxDecoration(
            color: AppColours.appGreyFaint.withOpacity(0.2),
            border: Border.all(
                color: AppColours.appGreyFaint.withOpacity(0.4), width: 2.0.sp),
            borderRadius: BorderRadius.circular(25.0.r)),
        child: Stack(children: [
          //! BOTTOM
          ValueListenableBuilder(
              valueListenable: _securityPersonnelImage!,
              builder: (context, value, child) => CarouselSlider(
                  options: CarouselOptions(
                      height: MediaQuery.of(context).size.height * 0.3,
                      aspectRatio: 16 / 9,
                      viewportFraction: 1,
                      initialPage: 0,
                      enableInfiniteScroll: true,
                      autoPlay: true,
                      autoPlayInterval: const Duration(seconds: 3),
                      autoPlayAnimationDuration:
                          const Duration(milliseconds: 800),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enlargeCenterPage: true,
                      enlargeFactor: 0.5,
                      scrollDirection: Axis.horizontal),
                  items: _securityPersonnelImage!.value.isEmpty
                      ? List.generate(
                          1,
                          (index) => Center(
                              child: Text(devicePictureNames.elementAt(index))))
                      : _securityPersonnelImage!.value.map((image) {
                          return Container(
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      filterQuality: FilterQuality.high,
                                      fit: BoxFit.fitWidth,
                                      image: FileImage(image)),
                                  borderRadius: BorderRadius.circular(25.0.r)),
                              child: Center(
                                  child: Text(
                                      devicePictureNames.elementAt(
                                          _securityPersonnelImage!.value
                                              .indexOf(image)),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(fontSize: 18.0.sp))));
                        }).toList())),

          //! BOTTOM / DELETE BUTTON
          Positioned(
              right: 2.0.w,
              bottom: 60.0.h,
              child: FloatingActionButton(
                  mini: true,
                  heroTag: "Delete FAB",
                  onPressed: () async {
                    if (_securityPersonnelImage!.value.isNotEmpty) {
                      --_currentSelectedIndex.value;
                      _securityPersonnelImage!.value
                          .removeAt(_currentSelectedIndex.value);
                      _arePicturesAdded.value[_currentSelectedIndex.value] =
                          false;

                      _arePicturesAdded.notifyListeners();
                      _securityPersonnelImage!.notifyListeners();
                    } else {
                      AppUtils.showBanner(
                          context: context,
                          theMessage: "No pictures to delete",
                          theType: NotificationType.info);
                    }
                  },
                  backgroundColor: AppColours.appWhite,
                  child: Icon(PhosphorIcons.trashBold,
                      color: AppColours.appRed, size: 18.0.sp))),

          //! BOTTOM / ADD BUTTON
          Positioned(
              right: 2.0.w,
              bottom: 2.0.h,
              child: FloatingActionButton(
                  mini: true,
                  onPressed: () async {
                    if (_securityPersonnelImage!.value.isEmpty) {
                      await AppUtils.pickImage().then((devicePicture) {
                        if (devicePicture == null) {
                          return;
                        } else {
                          _securityPersonnelImage!.value.add(devicePicture);
                          _arePicturesAdded.value[_currentSelectedIndex.value] =
                              true;
                          _currentSelectedIndex.value++;

                          _arePicturesAdded.notifyListeners();
                          _securityPersonnelImage!.notifyListeners();
                        }
                      }).catchError((error) => error.log());
                    } else {
                      AppUtils.showBanner(
                          context: context,
                          theMessage: "You cannot add any more pictures",
                          theType: NotificationType.info);
                    }
                  },
                  backgroundColor: AppColours.appWhite,
                  child: Icon(PhosphorIcons.plusBold,
                      color: AppColours.appBlue, size: 18.0.sp)))
        ]));
  }
}
