import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_device/services/models/auth/user_model/user_model.dart';
import 'package:my_device/services/models/firebase/firebase_user_field_name.dart';
import 'package:my_device/shared/utils/app_extensions.dart';
import 'package:my_device/shared/utils/type_defs.dart';

class Database {
  const Database();
  static final CollectionReference studentCollection =
      FirebaseFirestore.instance.collection("Students");

  //! UPDATE USER INFO
  Future<bool> saveUserInfo(
      {required UserId? userId,
      required String? matricNumber,
      required String? firstName,
      required String? lastName,
      required String? email,
      required String? department,
      required String? phoneNumber,
      required String? hallOfResidence,
      required String? profilePhoto,
      required String? isVerified}) async {
    //! PAYLOAD
    final UserModel user = UserModel(
        userId: userId,
        matricNumber: matricNumber,
        firstName: firstName,
        lastName: lastName,
        email: email,
        department: department,
        phoneNumber: phoneNumber,
        hallOfResidence: hallOfResidence,
        profilePhoto: profilePhoto,
        isVerified: isVerified);

    try {
      //! GET USER REFERENCE DOC ,. IF IT EXISTS, UPDATE IT; ELSE ADD A NEW DOC.
      await studentCollection
          .where(FirebaseUserFieldName.userId, isEqualTo: userId)
          .limit(1)
          .get()
          .then((userInfo) async {
        if (userInfo.docs.isNotEmpty) {
          await userInfo.docs.first.reference.update(user);
          return true;
        }
      });

      await studentCollection.add(user);
      return true;
    } catch (error) {
      error.toString().log();

      return false;
    }
  }
}
