/* // ignore_for_file: body_might_complete_normally_catch_error
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:my_device/router/router.dart';
import 'package:my_device/router/routes.dart';
import 'package:my_device/services/models/auth/user_model/user_model.dart';
import 'package:my_device/services/repositories/auth_repository.dart';
import 'package:my_device/services/states/auth/auth_state.dart';
import 'package:my_device/shared/utils/failure.dart';
import 'package:my_device/shared/utils/type_defs.dart';

final authControllerProvider =
    StateNotifierProvider<AuthController, AuthState>((ref) => AuthController());

class AuthController extends StateNotifier<AuthState> {
  final AuthRepository _authRepository = const AuthRepository();

  //! CONSTRUCTOR
  AuthController() : super(const AuthState.logOut()) {
    UserModel? user;
    bool? isAlreadyLoggedIn = false;
    _authRepository.isAlreadyLoggedIn
        .then((value) => isAlreadyLoggedIn = value);
    _authRepository.loggedInUser.then((value) => user = value);

    if (isAlreadyLoggedIn != null && isAlreadyLoggedIn == true) {
      state = AuthState(
          result: AuthResult.success, isLoading: false, theUser: user);
    }
  }

  //! UPDATE APP STATE
  void updateAuthStateWithUserDetail(UserModel? theUser) {
    state = state.copiedWithCurrentUser(theUser: theUser!);
  }

  //!
  //! SIGN UP
  Future<bool> signUpUser(BuildContext context, String firstname,
      String lastname, String email, String password) async {
    state = state.copiedWithIsLoading(isLoading: true);

    Either<Failure, AuthResult> user = await _authRepository
        .signUpUser(
            firstName: firstname,
            lastName: lastname,
            email: email,
            password: password)
        .catchError((error) {
      state = state.copiedWithIsLoading(isLoading: false);
      log("Error encountered: $error");
    });

    state = state.copiedWithIsLoading(isLoading: false);

    user.fold((Failure failure) {
      failure.message.toLowerCase().contains("failed host lookup")
          ? failure.message =
              "Could not connect to our system,  please try again"
          : {};
    },

        //! USE WATCH TO RECREATE THE USER STATE
        (AuthResult result) async {
      UserModel? user = await _authRepository.loggedInUser;

      state = state.copiedWithCurrentUser(theUser: user!);
    });
    return user.isRight();
  }

  //!
  //!
  //! SIGN IN
  Future<AuthResult> signInUser(
      {required BuildContext context,
      required String email,
      required String password}) async {
    state = state.copiedWithIsLoading(isLoading: true);

    Either<Failure, AuthResult> authResponse = await _authRepository
        .signInUser(email: email, password: password)
        .catchError((error) {
      state = state.copiedWithIsLoading(isLoading: false);
      log("Error encountered: $error");
    });

    state = state.copiedWithIsLoading(isLoading: false);

    authResponse.fold((Failure failure) {
      failure.message.toLowerCase().contains("failed host lookup")
          ? failure.message =
              "Could not connect to our system,  please try again"
          : {};
    },

        //! END POINT DOESN'T RETURN A USER DATA, SO DO NOTHING
        (AuthResult result) async => state = AuthState(
            result: result,
            isLoading: false,
            theUser: await _authRepository.loggedInUser));

    return authResponse.getOrElse((Failure l) => AuthResult.failure);
  }

  //!
  //! CHANGE PASSWORD
  Future<bool> changePassword(
      {required String oldPassword,
      required String newPassword,
      required BuildContext context}) async {
    state = state.copiedWithIsLoading(isLoading: true);

    Either<Failure, String> response = await _authRepository
        .changePassword(oldPassword: oldPassword, newPassword: newPassword)
        .catchError((error) {
      state = state.copiedWithIsLoading(isLoading: false);
      log("Error encountered: $error");
    });

    state = state.copiedWithIsLoading(isLoading: false);

    response.fold((Failure failure) {
      failure.message.toLowerCase().contains("failed host lookup")
          ? failure.message =
              "Could not connect to our system,  please try again"
          : {};
    }, (String successStatement) {});

    return response.isRight();
  }

  //!
  //!
  //! FORGOT PASSWORD
  Future<bool> forgotPassword(
      {required String theUserEmail, required BuildContext context}) async {
    state = state.copiedWithIsLoading(isLoading: true);

    Either<Failure, String> response = await _authRepository
        .forgotPassword(email: theUserEmail)
        .catchError((error) {
      state = state.copiedWithIsLoading(isLoading: false);
      log("Error encountered: $error");
    });

    state = state.copiedWithIsLoading(isLoading: false);

    response.fold((Failure failure) {
      failure.message.toLowerCase().contains("failed host lookup")
          ? failure.message =
              "Could not connect to our system,  please try again"
          : {};
    }, (String successStatement) {});

    return response.isRight();
  }

  //!
  //!
  //! RESET PASSWORD
  Future<bool> resetPassword(
      {required String theUserEmail,
      required String password,
      required String emailedToken,
      required BuildContext context}) async {
    state = state.copiedWithIsLoading(isLoading: true);

    Either<Failure, String> response = await _authRepository
        .resetPassword(
            email: theUserEmail, emailedToken: emailedToken, password: password)
        .catchError((error) {
      state = state.copiedWithIsLoading(isLoading: false);
      log("Error encountered: $error");
    });

    state = state.copiedWithIsLoading(isLoading: false);

    response.fold((Failure failure) {
      failure.message.toLowerCase().contains("failed host lookup")
          ? failure.message =
              "Could not connect to our system,  please try again"
          : {};
    }, (String successStatement) {});

    return response.isRight();
  }

  //!
  //!
  //! RE AUTHENTICATE WITH PIN
  Future<bool> reauthenticateWithPin(
      {required String pin, required BuildContext context}) async {
    state = state.copiedWithIsLoading(isLoading: true);

    Either<Failure, String> response = await _authRepository
        .reauthenticateWithPin(pin: pin)
        .catchError((error) {
      state = state.copiedWithIsLoading(isLoading: false);
      log("Error encountered: $error");
    });

    state = state.copiedWithIsLoading(isLoading: false);

    response.fold((Failure failure) {}, (successStatement) {});

    return response.isRight();
  }

  //!
  //!
  //! LOG OUT
  Future<void> logout({required BuildContext context}) async {
    state = state.copiedWithIsLoading(isLoading: true);

    //! CALL LOG OUT FUNCTION
    await _authRepository
        .logout()
        .then((value) => value.fold(
                //! LOG OUT METHOD RETURNED A FALSE VALUE
                () => null,

                //! LOG OUT METHOD RETURNED A TRUE VALUE; GO TO AUTH WRAPPER SCREEN
                () {
              //! UPDATE THE APP STATE
              state = const AuthState.logOut();

              //! NAVIGATE TO AUTH WRAPPER
              AppNavigator.navigateToReplacementPage(
                  thePageRouteName: AppRoutes.authWrapperRoute,
                  context: context);
            }))
        .catchError((error) {
      state = state.copiedWithIsLoading(isLoading: false);
      log("Logout Error: $error");
    });
  }
}
 */