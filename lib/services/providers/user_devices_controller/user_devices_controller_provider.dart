//! AUTH STATE PROVIDER / AUTH CONTROLLER PROVIDER
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_device/services/controllers/auth_controller.dart';
import 'package:my_device/services/controllers/device/device_controller.dart';
import 'package:my_device/services/states/auth/auth_state.dart';

final StateNotifierProvider<DeviceController, bool> deviceControllerProvider =
    StateNotifierProvider<DeviceController, bool>((ref) => DeviceController());
