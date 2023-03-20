import 'package:flutter/foundation.dart' show immutable;
import 'package:my_device/services/models/auth/user_model/user_model.dart';
import 'package:my_device/shared/utils/type_defs.dart';

@immutable
class AuthState {
  final AuthResult? result;
  final bool isLoading;
  final UserId? userId;
  final UserModel? user;

  const AuthState({
    required this.result,
    required this.isLoading,
    required this.userId,
    required this.user,
  });

  const AuthState.unknown()
      : result = null,
        isLoading = false,
        userId = null,
        user = null;

  //! LOGOUT STATE - IN THIS STATE, THERE IS NO USER
  const AuthState.logOut()
      : result = null,
        isLoading = false,
        userId = null,
        user = null;

  //! AUTH STATE WITH IS LOADING
  AuthState copiedWithIsLoading({required bool isLoading}) => AuthState(
      result: result, isLoading: isLoading, userId: userId, user: user);

  AuthState copiedWithCurrentUser(
          {required UserId userId, required UserModel user}) =>
      AuthState(
          result: result, isLoading: isLoading, userId: userId, user: user);

  //! IMPLEMENT EQUALITY
  @override
  bool operator ==(covariant AuthState other) =>
      identical(this, other) ||
      (result == other.result &&
          isLoading == other.isLoading &&
          userId == other.userId &&
          user == other.user);

  @override
  int get hashCode => Object.hash(result, isLoading, userId, user);
}
