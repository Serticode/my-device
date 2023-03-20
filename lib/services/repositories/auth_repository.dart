import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:my_device/services/database/database.dart';
import 'package:my_device/services/models/auth/user_model/user_model.dart';
import 'package:my_device/shared/utils/app_extensions.dart';
import 'package:my_device/shared/utils/failure.dart';
import 'package:my_device/shared/utils/type_defs.dart';

final Provider<AuthRepository> authRepositoryProvider =
    Provider((ref) => AuthRepository());

class AuthRepository {
  //! USER MATRIC NUMBER IS
  User? get user => FirebaseAuth.instance.currentUser;
  UserId? get userId => user?.uid;
  UserModel? signedInUser;
  bool get isAlreadyLoggedIn => userId != null;
  String get displayName => user?.displayName ?? "";
  String? get email => user?.email;

  //! CONSTRUCTOR
  AuthRepository();

  //!  SIGN UP
  FutureEither<AuthResult> signUp(
      {required String firstName,
      required String lastName,
      required String matricNumber,
      required String email,
      required String department,
      required String hallOfResidence,
      required String phoneNumber,
      required String password,
      required String confirmPassword}) async {
    UserCredential? loggedInUser;

    try {
      loggedInUser = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      if (loggedInUser.user?.uid != null) {
        final Database database = Database(userId: loggedInUser.user?.uid);

        bool isUpdateSuccessful = await database.updateUserInfo(
            firstName: firstName,
            lastName: lastName,
            matricNumber: matricNumber,
            email: email,
            department: department,
            hallOfResidence: hallOfResidence,
            phoneNumber: phoneNumber,
            password: password,
            confirmPassword: confirmPassword);

        isUpdateSuccessful
            ? {
                signedInUser = UserModel.fromJSON({
                  firstName: firstName,
                  lastName: lastName,
                  matricNumber: matricNumber,
                  email: email,
                  department: department,
                  hallOfResidence: hallOfResidence,
                  phoneNumber: phoneNumber,
                  password: password,
                  confirmPassword: confirmPassword
                })
              }
            : {};

        return isUpdateSuccessful
            ? right(AuthResult.success)
            : left(Failure(message: "Failed to register user"));
      } else {
        return left(Failure(message: "Failed to register user"));
      }
    } on FirebaseAuthException catch (error) {
      error.toString().log();

      return left(Failure(message: "Failed to register user"));
    }
  }

  //! LOGIN IN
  FutureEither<AuthResult> login({
    required String email,
    required String password,
  }) async {
    UserCredential? loggedInUser;

    try {
      loggedInUser = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      final Database database = Database(userId: loggedInUser.user?.uid);
      bool isGetSuccessful = await database.getUserInfo();

      return isGetSuccessful
          ? right(AuthResult.success)
          : left(Failure(message: "Failed to login"));
    } on FirebaseAuthException catch (error) {
      error.toString().log();

      return left(Failure(message: "Failed to login"));
    }
  }

  /* //! ANONYMOUS SIGN IN
  Future<AuthResult> anonSignIn() async {
    UserCredential? loggedInUser;
    DocumentSnapshot<Map<String, dynamic>>? userDocument;

    try {
      loggedInUser = await FirebaseAuth.instance.signInAnonymously();

      // ignore: unnecessary_null_comparison
      return loggedInUser != null ? AuthResult.success : AuthResult.failure;
    } on FirebaseAuthException catch (error) {
      error.toString().log();

      return AuthResult.failure;
    }
  } */

  //! LOGOUT
  Future<void> logOut() async => await FirebaseAuth.instance.signOut();
}
