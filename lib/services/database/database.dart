import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_device/services/models/auth/user_model/user_model.dart';
import 'package:my_device/shared/utils/app_extensions.dart';
import 'package:my_device/shared/utils/type_defs.dart';

class Database {
  final UserId? userId;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Database({required this.userId});

  //! UPDATE USER INFO
  Future<bool> updateUserInfo(
      {required String firstName,
      required String lastName,
      required String matricNumber,
      required String email,
      required String department,
      required String hallOfResidence,
      required String phoneNumber,
      required String password,
      required String confirmPassword}) async {
    bool isSuccessful = false;

    CollectionReference collectionReference = _firestore.collection("Students");

    UserModel user = UserModel()
      ..firstName = firstName
      ..lastName = lastName
      ..matricNumber = matricNumber
      ..email = email
      ..department = department
      ..hallOfResidence = hallOfResidence
      ..phoneNumber = phoneNumber
      ..profilePhoto = ""
      ..listOfDevices = [];

    try {
      await collectionReference.doc(userId).set(user.toJSON());

      isSuccessful = true;

      return isSuccessful;
    } catch (error) {
      error.toString().log();
      isSuccessful = false;

      return isSuccessful;
    }
  }

  //! GET USER INFO
  Future<bool> getUserInfo() async {
    bool isUserDetailsGotten = false;
    DocumentSnapshot? userDocument;
    CollectionReference collectionReference = _firestore.collection("Students");

    try {
      userDocument = await collectionReference.doc(userId).get();

      // ignore: unnecessary_null_comparison
      userDocument != null
          ? isUserDetailsGotten = true
          : isUserDetailsGotten = false;

      return isUserDetailsGotten;
    } on FirebaseAuthException catch (error) {
      error.toString().log();
      isUserDetailsGotten = false;

      return isUserDetailsGotten;
    }
  }
}
