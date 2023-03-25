//! USER ID PROVIDER
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_device/services/providers/auth_state/auth_state_provider.dart';
import 'package:my_device/shared/utils/type_defs.dart';

final Provider<UserId?> userIdProvider =
    Provider<UserId?>((ref) => ref.watch(authControllerProvider).userId);
