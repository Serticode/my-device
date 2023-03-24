// ignore_for_file: body_might_complete_normally_catch_error
//! THE AUTH CONTROLLER IS THE STATE MANAGER OF THE APP
//! IT CONTAINS THE STATE OF AUTHENTICATION RESULTS.
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:my_device/services/models/auth/user_model/user_model.dart';
import 'package:my_device/services/repositories/auth_repository.dart';
import 'package:my_device/services/states/auth/auth_state.dart';
import 'package:my_device/shared/utils/app_extensions.dart';
import 'package:my_device/shared/utils/failure.dart';
import 'package:my_device/shared/utils/type_defs.dart';
import 'package:my_device/shared/utils/utils.dart';

//! AUTH STATE PROVIDER / AUTH CONTROLLER
class AuthController extends StateNotifier<AuthState> {
  final AuthRepository _authRepository = const AuthRepository();

  //! CONSTRUCTOR
  AuthController() : super(const AuthState.logOut()) {
    if (_authRepository.isAlreadyLoggedIn) {
      state = AuthState(
          result: AuthResult.success,
          isLoading: false,
          userId: _authRepository.userId);
    }
  }

  //! UPDATE APP STATE
  void updateAuthStateWithUserDetail({UserId? userId, UserModel? user}) =>
      state = state.copiedWithCurrentUser(userId: userId!);

  //! REGISTER USER
  Future<bool> registerUser(
      {required BuildContext context,
      required String firstName,
      required String lastName,
      required String matricNumber,
      required String email,
      required String department,
      required String hallOfResidence,
      required String phoneNumber,
      required String password,
      required String confirmPassword}) async {
    state = state.copiedWithIsLoading(isLoading: true);

    Either<Failure, AuthResult> result = await _authRepository
        .signUp(
            firstName: firstName,
            lastName: lastName,
            matricNumber: matricNumber,
            email: email,
            department: department,
            hallOfResidence: hallOfResidence,
            phoneNumber: phoneNumber,
            password: password,
            confirmPassword: confirmPassword)
        .catchError((error) {
      state = state.copiedWithIsLoading(isLoading: false);
      error.toString().log();
    });

    state = state.copiedWithIsLoading(isLoading: false);

    result.fold(
        (Failure failedMessage) => AppUtils.showBanner(
            context: context,
            theMessage: failedMessage.message,
            theType: NotificationType.failure),

        //! SUCCESS
        (AuthResult result) {
      if (result == AuthResult.success && _authRepository.userId != null) {
        state = state.copiedWithCurrentUser(userId: _authRepository.userId!);
      }
    });

    return result.isRight();
  }

  Future<bool> login(
      {required BuildContext context,
      required String email,
      required String password}) async {
    state = state.copiedWithIsLoading(isLoading: true);

    Either<Failure, AuthResult> result = await _authRepository
        .login(email: email, password: password)
        .catchError((error) {
      state = state.copiedWithIsLoading(isLoading: false);
      error.toString().log();
    });

    state = state.copiedWithIsLoading(isLoading: false);

    result.fold(
        (Failure failedMessage) => AppUtils.showBanner(
            context: context,
            theMessage: failedMessage.message,
            theType: NotificationType.failure),

        //! SUCCESS
        (AuthResult result) {
      if (result == AuthResult.success && _authRepository.userId != null) {
        state = state.copiedWithCurrentUser(userId: _authRepository.userId!);
      }
    });

    return result.isRight();
  }

  //! LOGOUT
  Future<void> logOut() async {
    state = state.copiedWithIsLoading(isLoading: true);

    await _authRepository.logOut();

    state = const AuthState.logOut();
  }
}
