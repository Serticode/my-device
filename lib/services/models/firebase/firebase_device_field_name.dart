import "package:flutter/foundation.dart" show immutable;
import "package:my_device/shared/utils/type_defs.dart";

@immutable
class FirebaseDeviceFieldName {
  static const String ownerId = "ownerId";
  static const String deviceId = "deviceId";
  static const String createdAt = "created_at";
  static const String date = "date";
  static const String deviceName = "deviceName";
  static const String deviceType = "deviceType";
  static const String serialNumber = "serialNumber";
  static const String modelNumber = "modelNumber";
  static const String brand = "brand";
  static const String isLost = "isLost";
  static const String deviceColour = "deviceColour";
  static const String deviceImages = "deviceImages";
  const FirebaseDeviceFieldName._();
}
