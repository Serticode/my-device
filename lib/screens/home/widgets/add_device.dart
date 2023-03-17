import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_device/screens/widgets/app_custom_text_widget.dart';
import 'package:my_device/shared/constants/app_texts.dart';
import 'package:my_device/shared/utils/app_fade_animation.dart';
import 'package:my_device/shared/utils/app_screen_utils.dart';
import 'package:my_device/shared/utils/type_defs.dart';
import 'package:my_device/theme/app_theme.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

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
                    Container(
                        height: MediaQuery.of(context).size.height * 0.3,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: AppColours.appGreyFaint.withOpacity(0.2),
                            border: Border.all(
                                color: AppColours.appGreyFaint.withOpacity(0.4),
                                width: 2.0.sp),
                            borderRadius: BorderRadius.circular(25.0.r)),
                        child:
                            Icon(PhosphorIcons.imageSquareBold, size: 32.0.sp)),

                    //! SPACER
                    AppScreenUtils.verticalSpaceTiny,

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

                    //! BUTTON
                    AppFadeAnimation(
                        delay: 1.6,
                        child: SizedBox(
                            width: double.infinity,
                            height: 45.0.h,
                            child: ElevatedButton(
                                onPressed: () => Navigator.of(context).pop(),
                                child: const AppTextWidget(
                                    theText: AppTexts.saveDevice,
                                    textType: AppTextType.regularBody)))),

                    //! SPACER
                    AppScreenUtils.verticalSpaceTiny,

                    AppFadeAnimation(
                        delay: 1.6,
                        child: SizedBox(
                            width: double.infinity,
                            height: 45.0.h,
                            child: ElevatedButton(
                                onPressed: () => Navigator.of(context).pop(),
                                child: const AppTextWidget(
                                    theText: AppTexts.goBack,
                                    textType: AppTextType.regularBody))))
                  ],
                ))));
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
