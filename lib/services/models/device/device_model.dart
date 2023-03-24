//! THIS FILE HANDLES THE DEVICE MODEL IN IT"S FULL GLORY.
import 'dart:collection';

import 'package:my_device/services/models/firebase/firebase_device_field_name.dart';
import 'package:my_device/shared/utils/type_defs.dart';

class DeviceModel extends MapView<String, dynamic> {
  //! DEFINITIONS
  late String? ownerId;
  late String? deviceId;
  late String? deviceName;
  late DeviceType? deviceType;
  late String? serialNumber;
  late String? modelNumber;
  late String? brand;
  late bool? isLost;
  late String? deviceColour;
  late List<String>? deviceImages;

  //! CONSTRUCTOR
  DeviceModel({
    this.ownerId,
    this.deviceId,
    this.deviceName,
    this.deviceType,
    this.serialNumber,
    this.modelNumber,
    this.brand,
    this.isLost,
    this.deviceColour,
    this.deviceImages,
  }) : super({
          FirebaseDeviceFieldName.ownerId: ownerId,
          FirebaseDeviceFieldName.deviceId: deviceId,
          FirebaseDeviceFieldName.deviceName: deviceName,
          FirebaseDeviceFieldName.deviceType: deviceType,
          FirebaseDeviceFieldName.serialNumber: serialNumber,
          FirebaseDeviceFieldName.modelNumber: modelNumber,
          FirebaseDeviceFieldName.brand: brand,
          FirebaseDeviceFieldName.isLost: isLost,
          FirebaseDeviceFieldName.deviceColour: deviceColour,
          FirebaseDeviceFieldName.deviceImages: deviceImages,
        });

  //! FROM JSON
  DeviceModel.fromJSON(
    Map<String, dynamic> json, {
    required UserId ownerId,
  }) : this(
          ownerId: ownerId,
          deviceId: json[FirebaseDeviceFieldName.deviceId] ?? "",
          deviceName: json[FirebaseDeviceFieldName.deviceName] ?? "",
          deviceType: json[FirebaseDeviceFieldName.deviceType] ?? "",
          serialNumber: json[FirebaseDeviceFieldName.serialNumber] ?? "",
          modelNumber: json[FirebaseDeviceFieldName.modelNumber] ?? "",
          brand: json[FirebaseDeviceFieldName.brand] ?? "",
          isLost: json[FirebaseDeviceFieldName.isLost] ?? "",
          deviceColour: json[FirebaseDeviceFieldName.deviceColour] ?? "",
          deviceImages: json[FirebaseDeviceFieldName.deviceImages] ?? "",
        );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DeviceModel &&
          runtimeType == other.runtimeType &&
          ownerId == other.ownerId &&
          deviceId == other.deviceId &&
          deviceName == other.deviceName &&
          deviceType == other.deviceType &&
          serialNumber == other.serialNumber &&
          modelNumber == other.modelNumber &&
          brand == other.brand &&
          isLost == other.isLost &&
          deviceColour == other.deviceColour &&
          deviceImages == other.deviceImages;

  @override
  int get hashCode => Object.hashAll([
        ownerId,
        deviceId,
        deviceName,
        deviceType,
        serialNumber,
        modelNumber,
        brand,
        isLost,
        deviceColour,
        deviceImages,
      ]);
}
