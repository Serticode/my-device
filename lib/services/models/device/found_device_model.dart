import 'dart:collection';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_device/services/models/device/device_model.dart';
import 'package:my_device/services/models/firebase/firebase_device_field_name.dart';

class FoundDeviceModel extends MapView<String, dynamic> {
  //! DEFINITIONS
  late DeviceModel? device;
  late String? securityPersonnelName;
  late String? securityPersonnelID;
  late List? securityPersonnelImage;
  late DateTime? createdAt;

  //! CONSTRUCTOR
  FoundDeviceModel(
      {this.device,
      this.securityPersonnelName,
      this.securityPersonnelID,
      this.securityPersonnelImage,
      this.createdAt})
      : super({
          FirebaseDeviceFieldName.device: device,
          FirebaseDeviceFieldName.securityPersonnelName: securityPersonnelName,
          FirebaseDeviceFieldName.securityPersonnelID: securityPersonnelID,
          FirebaseDeviceFieldName.securityPersonnelImage:
              securityPersonnelImage,
          FirebaseDeviceFieldName.createdAt: createdAt
        });

  //! FROM JSON
  FoundDeviceModel.fromJSON(
    Map<String, dynamic> json, {
    required DeviceModel device,
  }) : this(
          device: device,
          securityPersonnelName:
              json[FirebaseDeviceFieldName.securityPersonnelName] ?? "",
          securityPersonnelID:
              json[FirebaseDeviceFieldName.securityPersonnelID] ?? "",
          securityPersonnelImage:
              json[FirebaseDeviceFieldName.securityPersonnelImage] ?? [],
          createdAt:
              (json[FirebaseDeviceFieldName.createdAt] as Timestamp).toDate(),
        );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FoundDeviceModel &&
          runtimeType == other.runtimeType &&
          device == other.device &&
          securityPersonnelName == other.securityPersonnelName &&
          securityPersonnelID == other.securityPersonnelID &&
          securityPersonnelImage == other.securityPersonnelImage &&
          createdAt == other.createdAt;

  @override
  int get hashCode => Object.hashAll([
        device,
        securityPersonnelName,
        securityPersonnelID,
        securityPersonnelImage,
        createdAt
      ]);
}
