//! IS LOADING PROVIDER
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_device/services/providers/auth_state/auth_state_provider.dart';
import 'package:my_device/services/states/auth/auth_state.dart';

final Provider<bool> isLoadingProvider = Provider<bool>((ref) {
  final AuthState authState = ref.watch(authControllerProvider);

  return authState.isLoading;
});
