// ignore_for_file: body_might_complete_normally_catch_error
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

final authControllerProvider =
    StateNotifierProvider<AuthController, AuthState>((ref) => AuthController());

class AuthController extends StateNotifier<AuthState> {
  final AuthRepository _authRepository = AuthRepository();

  //! CONSTRUCTOR
  AuthController() : super(const AuthState.logOut()) {
    UserId? userId = _authRepository.userId;
    UserModel? user = _authRepository.signedInUser;
    bool? isAlreadyLoggedIn = _authRepository.isAlreadyLoggedIn;

    // ignore: unnecessary_null_comparison
    if (isAlreadyLoggedIn != null && isAlreadyLoggedIn == true) {
      state = AuthState(
          result: AuthResult.success,
          isLoading: false,
          userId: userId,
          user: user);
    }
  }

  //! UPDATE APP STATE
  void updateAuthStateWithUserDetail({UserId? userId, UserModel? user}) =>
      state = state.copiedWithCurrentUser(userId: userId!, user: user!);

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
        (AuthResult result) => result.log());

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
        (AuthResult result) => result.log());

    return result.isRight();
  }

  //! LOGOUT
  Future<void> logOut() async {
    state = state.copiedWithIsLoading(isLoading: true);

    await _authRepository.logOut();

    state = const AuthState.logOut();
  }
}
