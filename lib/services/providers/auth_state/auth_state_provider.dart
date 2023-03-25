//! AUTH STATE PROVIDER / AUTH CONTROLLER PROVIDER
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_device/services/controllers/auth_controller.dart';
import 'package:my_device/services/states/auth/auth_state.dart';

final StateNotifierProvider<AuthController, AuthState> authControllerProvider =
    StateNotifierProvider<AuthController, AuthState>((ref) => AuthController());
