// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_device/screens/widgets/animated_button.dart';
import 'package:my_device/screens/widgets/app_custom_text_widget.dart';
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

ValueNotifier<List<File>>? _devicePictures = ValueNotifier([]);
List<String> devicePictureNames = [
  "Full picture",
  "Full picture - different angle",
  "Serial number",
  "Model number"
];
ValueNotifier<List<bool>> _isDevicePictureAdded =
    ValueNotifier([false, false, false, false]);
ValueNotifier<int> _currentSelectedIndex = ValueNotifier(0);

class AddDevice extends ConsumerStatefulWidget {
  const AddDevice({super.key});

  @override
  ConsumerState<AddDevice> createState() => _AddDeviceState();
}

class _AddDeviceState extends ConsumerState<AddDevice> {
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

  ValueNotifier<bool> isDeviceTypeTapped = ValueNotifier(false);
  ValueNotifier<DeviceType> selectedDeviceType =
      ValueNotifier(DeviceType.smartPhone);

  ValueNotifier<List<DeviceType>> deviceTypes =
      ValueNotifier(DeviceType.values);
  ValueNotifier<bool> isDeviceTypeSelected = ValueNotifier(false);

  void toggleSelectDeviceType() =>
      isDeviceTypeTapped.value = !isDeviceTypeTapped.value;

  @override
  void dispose() {
    serialNumberController.dispose();
    modelNumberController.dispose();
    colourController.dispose();
    brandController.dispose();
    deviceNameController.dispose();
    _devicePictures?.value = [];
    _isDevicePictureAdded.value = [false, false, false, false];
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
                theText: "Add Device", textType: AppTextType.boldBody)),

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
                      const AddDeviceImage(),

                      //! SPACER
                      AppScreenUtils.verticalSpaceSmall,

                      //! TRACER
                      SizedBox(
                          width: double.infinity,
                          child: ValueListenableBuilder(
                              valueListenable: _isDevicePictureAdded,
                              builder: (context, value, child) => Column(
                                    children: devicePictureNames
                                        .map((name) => Row(children: [
                                              //! ICON
                                              Icon(PhosphorIcons.checks,
                                                  color: _isDevicePictureAdded
                                                          .value
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
                              theText: "Add device details",
                              textType: AppTextType.regularBody)),

                      //! SPACER
                      AppScreenUtils.verticalSpaceTiny,

                      //! MODEL NUMBER
                      TextFormField(
                          style: Theme.of(context).textTheme.bodyMedium,
                          cursorColor: AppColours.lettersAndIconsColour,
                          controller: modelNumberController.value,
                          decoration: const InputDecoration(
                              hintText: AppTexts.modelNumber)),

                      //! SPACER
                      AppScreenUtils.verticalSpaceTiny,

                      //! SERIAL NUMBER
                      TextFormField(
                          style: Theme.of(context).textTheme.bodyMedium,
                          cursorColor: AppColours.lettersAndIconsColour,
                          controller: serialNumberController.value,
                          decoration: const InputDecoration(
                              hintText: AppTexts.serialNumber)),

                      //! SPACER
                      AppScreenUtils.verticalSpaceTiny,

                      //! DEVICE COLOUR
                      TextFormField(
                          style: Theme.of(context).textTheme.bodyMedium,
                          cursorColor: AppColours.lettersAndIconsColour,
                          controller: colourController.value,
                          decoration:
                              const InputDecoration(hintText: AppTexts.colour)),

                      //! SPACER
                      AppScreenUtils.verticalSpaceTiny,

                      //! BRAND
                      TextFormField(
                          style: Theme.of(context).textTheme.bodyMedium,
                          cursorColor: AppColours.lettersAndIconsColour,
                          controller: brandController.value,
                          decoration: const InputDecoration(
                              hintText: AppTexts.deviceBrand)),

                      //! SPACER
                      AppScreenUtils.verticalSpaceTiny,

                      //! DEVICE NAME
                      TextFormField(
                          style: Theme.of(context).textTheme.bodyMedium,
                          cursorColor: AppColours.lettersAndIconsColour,
                          controller: deviceNameController.value,
                          decoration: const InputDecoration(
                              hintText: AppTexts.deviceName)),

                      //! SPACER
                      AppScreenUtils.verticalSpaceTiny,

                      //! SELECT DEVICE TYPE
                      AppMultiListenableProvider(
                          firstValue: isDeviceTypeTapped,
                          secondValue: isDeviceTypeSelected,
                          child: const SizedBox.shrink(),
                          builder: (context, firstValue, secondValue, child) {
                            return AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                height: firstValue ? 300.0.h : 65.0.h,
                                width: double.infinity,
                                padding: AppScreenUtils.defaultPadding,
                                decoration: BoxDecoration(
                                    color: AppColours.lettersAndIconsFaintColour
                                        .withOpacity(0.3),
                                    borderRadius:
                                        BorderRadius.circular(21.0.r)),
                                child:
                                    //! DEVICE TYPE SELECTED
                                    secondValue
                                        ? Row(children: [
                                            //! DEVICE TYPE IMAGE
                                            Container(
                                                height: 40.0.h,
                                                width: 40.0.w,
                                                decoration: BoxDecoration(
                                                  color: AppColours.appGreyFaint
                                                      .withOpacity(0.2),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12.0.r),
                                                  border: Border.all(
                                                      width: 1.2,
                                                      color: AppColours
                                                          .appGreyFaint),
                                                ),
                                                child: Transform.scale(
                                                    scale: 0.7,
                                                    child: AppUtils.getDeviceIcons(
                                                        index: deviceTypes.value
                                                            .indexOf(
                                                                selectedDeviceType
                                                                    .value)))),

                                            //! SPACER
                                            AppScreenUtils.horizontalSpaceSmall,

                                            //! SELECTED DEVICE TYPE NAME
                                            AppTextWidget(
                                                theText: selectedDeviceType
                                                    .value.name,
                                                textType:
                                                    AppTextType.regularBody),

                                            //! SPACER
                                            const Spacer(),

                                            IconButton(
                                                onPressed: () {
                                                  isDeviceTypeTapped.value =
                                                      false;
                                                  isDeviceTypeSelected.value =
                                                      false;

                                                  selectedDeviceType.value =
                                                      DeviceType.smartPhone;
                                                },
                                                icon: Icon(
                                                  Icons.close,
                                                  size: 22.sp,
                                                  color: AppColours
                                                      .lettersAndIconsFaintColour
                                                      .withOpacity(0.5),
                                                ))
                                          ])
                                        :

                                        //! DEVICE TYPE HAS NOT BEEN SELECTED
                                        !firstValue
                                            ?
                                            //! USER HAS NOT TAPPED ON SELECT DEVICE TYPE
                                            Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                    //! HEART
                                                    Icon(
                                                      PhosphorIcons
                                                          .deviceMobileBold,
                                                      size: 18.sp,
                                                      color: AppColours
                                                          .lettersAndIconsFaintColour
                                                          .withOpacity(0.5),
                                                    ),

                                                    //! SPACER
                                                    AppScreenUtils
                                                        .horizontalSpaceSmall,

                                                    InkWell(
                                                        onTap: () =>
                                                            isDeviceTypeTapped
                                                                    .value =
                                                                !isDeviceTypeTapped
                                                                    .value,
                                                        child: AppTextWidget(
                                                            theText:
                                                                "Select a Device Type",
                                                            textColour: AppColours
                                                                .lettersAndIconsFaintColour
                                                                .withOpacity(
                                                                    0.5),
                                                            textType: AppTextType
                                                                .regularBody)),

                                                    //! SPACER
                                                    AppScreenUtils
                                                        .horizontalSpaceMedium,

                                                    //! ICON
                                                    Icon(
                                                      Icons
                                                          .keyboard_arrow_down_outlined,
                                                      color: AppColours
                                                          .lettersAndIconsFaintColour
                                                          .withOpacity(0.5),
                                                    )
                                                  ])
                                            :

                                            //! DEVICE TYPES
                                            ValueListenableBuilder(
                                                valueListenable: deviceTypes,
                                                builder:
                                                    (context, value, child) {
                                                  return Stack(children: [
                                                    SingleChildScrollView(
                                                        physics:
                                                            const BouncingScrollPhysics(),
                                                        child: Column(
                                                            children: [
                                                              ...deviceTypes
                                                                  .value
                                                                  .map((deviceType) => InkWell(
                                                                      onTap: () {
                                                                        selectedDeviceType.value =
                                                                            deviceType;

                                                                        isDeviceTypeTapped.value =
                                                                            !isDeviceTypeTapped.value;

                                                                        isDeviceTypeSelected.value =
                                                                            !isDeviceTypeSelected.value;
                                                                      },
                                                                      child: Container(
                                                                          height: 55.h,
                                                                          margin: EdgeInsets.only(bottom: 5.h),
                                                                          child: Row(children: [
                                                                            Container(
                                                                              height: 50.0.h,
                                                                              width: 55.0.w,
                                                                              decoration: BoxDecoration(
                                                                                color: AppColours.appGreyFaint.withOpacity(0.2),
                                                                                borderRadius: BorderRadius.circular(12.0.r),
                                                                                border: Border.all(width: 1.2, color: AppColours.appGreyFaint),
                                                                              ),
                                                                              child: AppUtils.getDeviceIcons(
                                                                                index: deviceTypes.value.indexOf(deviceType),
                                                                              ),
                                                                            ),

                                                                            //! SPACER
                                                                            AppScreenUtils.horizontalSpaceSmall,

                                                                            AppTextWidget(
                                                                                theText: deviceType.name,
                                                                                textType: AppTextType.regularBody)
                                                                          ]))))
                                                                  .toList()
                                                            ])),

                                                    //! CLOSE BUTTON
                                                    Positioned(
                                                        right: 0,
                                                        child: IconButton(
                                                            onPressed:
                                                                toggleSelectDeviceType,
                                                            icon: Icon(
                                                                Icons.close,
                                                                size: 22.sp,
                                                                color: AppColours
                                                                    .appBlue)))
                                                  ]);
                                                }));
                          }),

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
                                                        AppTexts.saveDevice,
                                                    textType: AppTextType
                                                        .regularBody)),
                                        onTap: () async {
                                          if (deviceNameController
                                                  .value.text.isNotEmpty &&
                                              serialNumberController
                                                  .value.text.isNotEmpty &&
                                              modelNumberController
                                                  .value.text.isNotEmpty &&
                                              brandController
                                                  .value.text.isNotEmpty &&
                                              colourController
                                                  .value.text.isNotEmpty &&
                                              _devicePictures!.value.length ==
                                                  4) {
                                            await ref
                                                .read(deviceControllerProvider
                                                    .notifier)
                                                .saveDevice(
                                                    createdAt: DateTime.now(),
                                                    deviceName:
                                                        deviceNameController
                                                            .value.text
                                                            .trim(),
                                                    deviceType: selectedDeviceType
                                                        .value.name,
                                                    serialNumber:
                                                        serialNumberController
                                                            .value.text
                                                            .trim(),
                                                    modelNumber:
                                                        modelNumberController
                                                            .value.text
                                                            .trim(),
                                                    brand: brandController
                                                        .value.text
                                                        .trim(),
                                                    deviceColour:
                                                        colourController
                                                            .value.text
                                                            .trim(),
                                                    deviceImages:
                                                        _devicePictures!.value)
                                                .then((value) async => value
                                                        .isRight()
                                                    ? {
                                                        await clearControllers(),
                                                        Navigator.pop(context)
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
          AppScreenUtils.horizontalSpaceSmall,

          AppTextWidget(theText: value, textType: AppTextType.regularBody)
        ]));
  }
}

//!
//! ADD DEVICE IMAGE
class AddDeviceImage extends ConsumerWidget {
  const AddDeviceImage({super.key});

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
              valueListenable: _devicePictures!,
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
                  items: _devicePictures!.value.isEmpty
                      ? List.generate(
                          4,
                          (index) => Center(
                              child: Text(devicePictureNames.elementAt(index))))
                      : _devicePictures!.value.map((image) {
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
                                          _devicePictures!.value
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
                    if (_devicePictures!.value.isNotEmpty) {
                      --_currentSelectedIndex.value;
                      _devicePictures!.value
                          .removeAt(_currentSelectedIndex.value);
                      _isDevicePictureAdded.value[_currentSelectedIndex.value] =
                          false;

                      _isDevicePictureAdded.notifyListeners();
                      _devicePictures!.notifyListeners();
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
                    if (_devicePictures!.value.length < 4) {
                      await AppUtils.pickImage().then((devicePicture) {
                        if (devicePicture == null) {
                          return;
                        } else {
                          _devicePictures!.value.add(devicePicture);
                          _isDevicePictureAdded
                              .value[_currentSelectedIndex.value] = true;
                          _currentSelectedIndex.value++;

                          _isDevicePictureAdded.notifyListeners();
                          _devicePictures!.notifyListeners();
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
