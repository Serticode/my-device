import 'package:flutter/foundation.dart' show immutable;
import 'package:my_device/shared/utils/type_defs.dart';

@immutable
class AuthState {
  final AuthResult? result;
  final bool isLoading;
  final UserId? userId;

  const AuthState({
    required this.result,
    required this.isLoading,
    required this.userId,
  });

  //! LOGOUT STATE - IN THIS STATE, THERE IS NO USER
  const AuthState.logOut()
      : result = null,
        isLoading = false,
        userId = null;

  //! AUTH STATE WITH IS LOADING
  AuthState copiedWithIsLoading({required bool isLoading}) =>
      AuthState(result: result, isLoading: isLoading, userId: userId);

  AuthState copiedWithCurrentUser({required UserId userId}) =>
      AuthState(result: result, isLoading: isLoading, userId: userId);

  //! IMPLEMENT EQUALITY
  @override
  bool operator ==(covariant AuthState other) =>
      identical(this, other) ||
      (result == other.result &&
          isLoading == other.isLoading &&
          userId == other.userId);

  @override
  int get hashCode => Object.hash(result, isLoading, userId);
}
