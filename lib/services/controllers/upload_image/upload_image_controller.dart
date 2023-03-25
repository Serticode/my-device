import 'dart:io' show File;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_device/services/models/auth/user_model/user_model.dart';
import 'package:my_device/services/models/firebase/firebase_collection_names.dart';
import 'package:my_device/services/models/firebase/firebase_user_field_name.dart';
import 'package:my_device/services/models/firebase/firestore_file_field_names.dart';
import 'package:my_device/shared/utils/app_extensions.dart';
import 'package:my_device/shared/utils/type_defs.dart';

class UploadImageController extends StateNotifier<IsLoading> {
  UploadImageController() : super(false);
  final Reference _storageReference = FirebaseStorage.instance.ref();

  set isLoading(bool value) => state = value;

  Future<bool> uploadProfilePhoto({
    required UserId userId,
    required File profilePhoto,
    required FileType fileType,
    required UserModel loggedInUser,
  }) async {
    try {
      isLoading = true;

      final Reference fileRef = _storageReference
          .child(userId)
          .child(fileType.collectionName)
          .child(FirestoreFileFieldNames.profilePhoto);

      final TaskSnapshot profilePhotoUploadTask =
          await fileRef.putFile(profilePhoto);
      final String fileUrl = await profilePhotoUploadTask.ref.getDownloadURL();

      await FirebaseFirestore.instance
          .collection(FirebaseCollectionName.students)
          .where(FirebaseUserFieldName.userId, isEqualTo: userId)
          .limit(1)
          .get()
          .then((userInfo) async {
        final Map<String, dynamic> userData = userInfo.docs.first.data();
        userData.update(FirebaseUserFieldName.profilePhoto, (value) => fileUrl);

        loggedInUser = UserModel.fromJSON(userData, userId: userId);

        await userInfo.docs.first.reference.update(loggedInUser);
        return true;
      });

      isLoading = false;

      return true;
    } catch (error) {
      isLoading = false;
      error.toString().log();
      return false;
    }
  }
}
