//! THIS FILE HANDLES THE DEVICE MODEL IN IT"S FULL GLORY.
import 'dart:collection';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_device/services/models/firebase/firebase_device_field_name.dart';
import 'package:my_device/shared/utils/type_defs.dart';

class DeviceModel extends MapView<String, dynamic> {
  //! DEFINITIONS
  late String? ownerId;
  late String? deviceName;
  late String? deviceType;
  late String? serialNumber;
  late String? modelNumber;
  late String? brand;
  late bool? isLost;
  late String? deviceColour;
  late List? deviceImages;
  late DateTime? createdAt;

  //! CONSTRUCTOR
  DeviceModel(
      {this.ownerId,
      this.deviceName,
      this.deviceType,
      this.serialNumber,
      this.modelNumber,
      this.brand,
      this.isLost,
      this.deviceColour,
      this.deviceImages,
      this.createdAt})
      : super({
          FirebaseDeviceFieldName.ownerId: ownerId,
          FirebaseDeviceFieldName.deviceName: deviceName,
          FirebaseDeviceFieldName.deviceType: deviceType,
          FirebaseDeviceFieldName.serialNumber: serialNumber,
          FirebaseDeviceFieldName.modelNumber: modelNumber,
          FirebaseDeviceFieldName.brand: brand,
          FirebaseDeviceFieldName.isLost: isLost,
          FirebaseDeviceFieldName.deviceColour: deviceColour,
          FirebaseDeviceFieldName.deviceImages: deviceImages,
          FirebaseDeviceFieldName.createdAt: createdAt
        });

  //! FROM JSON
  DeviceModel.fromJSON(
    Map<String, dynamic> json, {
    required UserId ownerId,
  }) : this(
          ownerId: ownerId,
          deviceName: json[FirebaseDeviceFieldName.deviceName] ?? "",
          deviceType: json[FirebaseDeviceFieldName.deviceType] ?? "",
          serialNumber: json[FirebaseDeviceFieldName.serialNumber] ?? "",
          modelNumber: json[FirebaseDeviceFieldName.modelNumber] ?? "",
          brand: json[FirebaseDeviceFieldName.brand] ?? "",
          isLost: json[FirebaseDeviceFieldName.isLost] ?? "",
          deviceColour: json[FirebaseDeviceFieldName.deviceColour] ?? "",
          deviceImages: json[FirebaseDeviceFieldName.deviceImages] ?? [],
          createdAt:
              (json[FirebaseDeviceFieldName.createdAt] as Timestamp).toDate(),
        );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DeviceModel &&
          runtimeType == other.runtimeType &&
          ownerId == other.ownerId &&
          deviceName == other.deviceName &&
          deviceType == other.deviceType &&
          serialNumber == other.serialNumber &&
          modelNumber == other.modelNumber &&
          brand == other.brand &&
          isLost == other.isLost &&
          deviceColour == other.deviceColour &&
          deviceImages == other.deviceImages &&
          createdAt == other.createdAt;

  @override
  int get hashCode => Object.hashAll([
        ownerId,
        deviceName,
        deviceType,
        serialNumber,
        modelNumber,
        brand,
        isLost,
        deviceColour,
        deviceImages,
        createdAt
      ]);
}
