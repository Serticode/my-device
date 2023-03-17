import 'package:flutter/foundation.dart' show immutable;
import 'package:my_device/services/models/auth/user_model/user_model.dart';
import 'package:my_device/shared/utils/type_defs.dart';

@immutable
class AuthState {
  final AuthResult? result;
  final bool isLoading;
  final UserModel? theUser;

  const AuthState({
    required this.result,
    required this.isLoading,
    required this.theUser,
  });

  //! LOGOUT STATE - IN THIS STATE, THERE IS NO USER
  const AuthState.logOut()
      : result = null,
        isLoading = false,
        theUser = null;

  //! AUTH STATE WITH IS LOADING
  AuthState copiedWithIsLoading({required bool isLoading}) =>
      AuthState(result: result, isLoading: isLoading, theUser: theUser);

  AuthState copiedWithCurrentUser({required UserModel theUser}) =>
      AuthState(result: result, isLoading: isLoading, theUser: theUser);

  //! IMPLEMENT EQUALITY
  @override
  bool operator ==(covariant AuthState other) =>
      identical(this, other) ||
      (result == other.result &&
          isLoading == other.isLoading &&
          theUser == other.theUser);

  @override
  int get hashCode => Object.hash(result, isLoading, theUser);
}
