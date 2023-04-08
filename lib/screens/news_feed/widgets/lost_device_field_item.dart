import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_device/screens/home/widgets/show_device_image.dart';
import 'package:my_device/screens/news_feed/widgets/lost_device_field_data.dart';
import 'package:my_device/screens/widgets/profile_picture.dart';
import 'package:my_device/services/models/auth/user_model/user_model.dart';
import 'package:my_device/services/models/device/device_model.dart';
import 'package:my_device/services/providers/device_owner/device_owner_provider.dart';
import 'package:my_device/shared/utils/app_screen_utils.dart';
import 'package:my_device/theme/app_theme.dart';

class LostDeviceFieldsItem extends ConsumerStatefulWidget {
  final DeviceModel lostDevice;
  const LostDeviceFieldsItem({super.key, required this.lostDevice});

  @override
  ConsumerState<LostDeviceFieldsItem> createState() =>
      _LostDeviceFieldsItemState();
}

class _LostDeviceFieldsItemState extends ConsumerState<LostDeviceFieldsItem> {
  UserModel? deviceOwnerDetails;

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    deviceOwnerDetails =
        await deviceOwnerProvider(deviceOwnerId: widget.lostDevice.ownerId!);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      //! OWNER DEVICE
      ProfilePicture(
          imageURL: deviceOwnerDetails?.profilePhoto ?? "",
          largerRadius: 40.0.r,
          smallerRadius: 37.0.r,
          boxFit: BoxFit.contain),

      //! SPACER
      AppScreenUtils.verticalSpaceSmall,

      Align(
          alignment: Alignment.centerLeft,
          child: Text("Device Images",
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: AppColours.appBlack))),

      //! SPACER
      AppScreenUtils.verticalSpaceTiny,

      //! DEVICE IMAGES
      Container(
          height: MediaQuery.of(context).size.height * 0.2,
          width: double.infinity,
          decoration: BoxDecoration(
              color: AppColours.appGreyFaint,
              borderRadius: BorderRadius.circular(6.0.r),
              border: Border.all(color: Colors.black, width: 1.5)),
          child:
              ShowDeviceImage(devicePictures: widget.lostDevice.deviceImages!)),

      //! SPACER
      AppScreenUtils.verticalSpaceSmall,

      //! OWNER NAME
      LostDeviceFieldsData(
          theKey: "Owner",
          value: deviceOwnerDetails == null
              ? "User"
              : "${deviceOwnerDetails?.lastName} ${deviceOwnerDetails?.firstName}"),

      //! SPACER
      AppScreenUtils.verticalSpaceSmall,

      //! OWNER HALL
      LostDeviceFieldsData(
          theKey: "Hall of residence",
          value: deviceOwnerDetails?.hallOfResidence ?? "Fetching Residence"),

      //! SPACER
      AppScreenUtils.verticalSpaceSmall,

      //! CONTACT
      LostDeviceFieldsData(
          theKey: "Contact",
          value: deviceOwnerDetails?.phoneNumber ?? "Fetching contact"),

      //! SPACER
      AppScreenUtils.verticalSpaceSmall,

      //! DEVICE NAME
      LostDeviceFieldsData(
          theKey: "Device name", value: widget.lostDevice.deviceName!),

      //! SPACER
      AppScreenUtils.verticalSpaceSmall,

      //! DEVICE SERIAL NUMBER
      LostDeviceFieldsData(
          theKey: "Serial number", value: widget.lostDevice.serialNumber!),

      //! SPACER
      AppScreenUtils.verticalSpaceSmall
    ]);
  }
}
