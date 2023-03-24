//! THIS FILE HANDLES THE DEVICE MODEL IN IT"S FULL GLORY.
import 'package:my_device/shared/utils/type_defs.dart';

class DeviceModel {
  //! DEFINITIONS
  late String? id;
  late String? deviceName;
  late DeviceType? deviceType;
  late String? serialNumber;
  late String? modelNumber;
  late String? brand;
  late bool? isLost;
  late String? deviceColour;
  late List<String>? deviceImages;

  //! CONSTRUCTOR
  DeviceModel(
      {this.id,
      this.deviceName,
      this.deviceType,
      this.serialNumber,
      this.modelNumber,
      this.brand,
      this.isLost,
      this.deviceColour,
      this.deviceImages});

  //! TO JSON
  Map<String, dynamic> toJSON() => {
        "id": id,
        "deviceName": deviceName,
        "deviceType": deviceType,
        "serialNumber": serialNumber,
        "modelNumber": modelNumber,
        "brand": brand,
        "isLost": isLost,
        "deviceColour": deviceColour,
        "deviceImages": deviceImages
      };

  //! FROM JSON
  factory DeviceModel.fromJSON(Map<String, dynamic> json) => DeviceModel(
      id: json["id"] ?? "",
      deviceName: json["deviceName"] ?? "",
      deviceType: json["deviceType"] ?? "",
      serialNumber: json["serialNumber"] ?? "",
      modelNumber: json["modelNumber"] ?? "",
      brand: json["brand"] ?? "",
      isLost: json["isLost"] ?? false,
      deviceColour: json["deviceColour"] ?? "",
      deviceImages: json["deviceImages"] ?? "");
}
