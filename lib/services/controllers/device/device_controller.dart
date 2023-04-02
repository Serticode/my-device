import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:my_device/services/database/device/device_database.dart';
import 'package:my_device/services/models/device/device_model.dart';
import 'package:my_device/services/repositories/auth_repository.dart';
import 'package:my_device/shared/utils/app_extensions.dart';
import 'package:my_device/shared/utils/failure.dart';
import 'package:my_device/shared/utils/type_defs.dart';

class DeviceController extends StateNotifier<IsLoading> {
  //! CONSTRUCTOR
  DeviceController() : super(false);
  set isLoading(bool value) => state = value;
  final DeviceDatabase _database = const DeviceDatabase();
  final AuthRepository _authRepository = const AuthRepository();

  //!  SAVE DEVICE
  FutureEither<bool> saveDevice(
      {required String? deviceName,
      required String? deviceType,
      required String? serialNumber,
      required String? modelNumber,
      required String? brand,
      required String? deviceColour,
      required DateTime createdAt,
      required List<File>? deviceImages}) async {
    try {
      state = true;

      bool isDeviceSaved = await _database
          .saveDeviceInfo(
              ownerId: _authRepository.userId,
              deviceName: deviceName,
              deviceType: deviceType,
              serialNumber: serialNumber,
              modelNumber: modelNumber,
              brand: brand,
              deviceColour: deviceColour,
              createdAt: createdAt,
              deviceImages: deviceImages ?? [])
          .catchError((error) {
        error.toString().log();
        state = false;
        return false;
      });

      state = false;

      return isDeviceSaved
          ? right(true)
          : left(Failure(message: "Device not saved"));
    } catch (error) {
      error.toString().log();

      return left(Failure(message: "Failed to save user device"));
    }
  }

  //! MARK AS LOST
  FutureEither<bool> markAsLost({required DeviceModel device}) async {
    try {
      state = true;

      bool isDeviceDeleted = await _database
          .markAsLost(device: device, userId: _authRepository.userId!)
          .catchError((error) {
        error.toString().log();
        state = false;
        return false;
      });

      state = false;

      return isDeviceDeleted
          ? right(true)
          : left(Failure(message: "Device not saved"));
    } catch (error) {
      error.toString().log();

      return left(Failure(message: "Failed to save user device"));
    }
  }

  //! DELETE DEVICE
  FutureEither<bool> deleteDevice(
      {required String? serialNumber,
      required String? deviceName,
      required UserId? userId}) async {
    try {
      state = true;

      bool isDeviceDeleted = await _database
          .deleteDevice(
              serialNumber: serialNumber,
              deviceName: deviceName,
              userId: userId)
          .catchError((error) {
        error.toString().log();
        state = false;
        return false;
      });

      state = false;

      return isDeviceDeleted
          ? right(true)
          : left(Failure(message: "Device not saved"));
    } catch (error) {
      error.toString().log();

      return left(Failure(message: "Failed to save user device"));
    }
  }
}
