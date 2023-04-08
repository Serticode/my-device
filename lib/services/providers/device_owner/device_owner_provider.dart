import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_device/services/models/auth/user_model/user_model.dart';
import 'package:my_device/services/models/firebase/firebase_collection_names.dart';
import 'package:my_device/services/models/firebase/firebase_user_field_name.dart';

Future<UserModel> deviceOwnerProvider({required String deviceOwnerId}) async {
  late UserModel user;
  final document = await FirebaseFirestore.instance
      .collection(FirebaseCollectionName.students)
      .where(FirebaseUserFieldName.userId, isEqualTo: deviceOwnerId)
      .limit(1)
      .get();

  for (var element in document.docs) {
    user = UserModel.fromJSON(element.data(), userId: deviceOwnerId);
  }

  return user;
}
