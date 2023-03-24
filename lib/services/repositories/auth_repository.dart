import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:my_device/services/database/database.dart';
import 'package:my_device/shared/utils/app_extensions.dart';
import 'package:my_device/shared/utils/failure.dart';
import 'package:my_device/shared/utils/type_defs.dart';

final Provider<AuthRepository> authRepositoryProvider =
    Provider((ref) => const AuthRepository());

class AuthRepository {
  //! CONSTRUCTOR
  const AuthRepository();
  final Database database = const Database();

  //! USER MATRIC NUMBER IS
  User? get user => FirebaseAuth.instance.currentUser;
  UserId? get userId => user?.uid;
  bool get isAlreadyLoggedIn => userId != null;
  String get displayName => user?.displayName ?? "";
  String? get email => user?.email;

  //!  SIGN UP
  FutureEither<AuthResult> signUp({
    required String firstName,
    required String lastName,
    required String matricNumber,
    required String email,
    required String department,
    required String hallOfResidence,
    required String phoneNumber,
    required String password,
    required String confirmPassword,
  }) async {
    UserCredential? loggedInUser;

    try {
      loggedInUser = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      if (loggedInUser.user?.uid != null) {
        bool isUpdateSuccessful = await database.saveUserInfo(
            userId: userId,
            firstName: firstName,
            lastName: lastName,
            matricNumber: matricNumber,
            email: email,
            department: department,
            hallOfResidence: hallOfResidence,
            phoneNumber: phoneNumber,
            profilePhoto: "",
            isVerified: "");

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
          .signInWithEmailAndPassword(email: email, password: password)
          .catchError((error) => error.log());

      // ignore: unnecessary_null_comparison
      return loggedInUser != null
          ? right(AuthResult.success)
          : left(Failure(message: "Failed to login"));
    } on FirebaseAuthException catch (error) {
      error.toString().log();

      return left(Failure(message: "Failed to login"));
    }
  }

  //! LOGOUT
  Future<void> logOut() async => await FirebaseAuth.instance.signOut();
}
