//! USER INFO PROVIDER
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_device/services/models/auth/user_model/user_model.dart';
import 'package:my_device/services/models/firebase/firebase_collection_names.dart';
import 'package:my_device/services/models/firebase/firebase_user_field_name.dart';
import 'package:my_device/shared/utils/type_defs.dart';

final loggedInUserDetailsProvider =
    StreamProvider.family.autoDispose<UserModel, UserId>(
  (ref, UserId userId) {
    final controller = StreamController<UserModel>();

    final StreamSubscription<QuerySnapshot<Map<String, dynamic>>> subscription =
        FirebaseFirestore.instance
            .collection(FirebaseCollectionName.students)
            .where(
              FirebaseUserFieldName.userId,
              isEqualTo: userId,
            )
            .limit(1)
            .snapshots()
            .listen((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        final QueryDocumentSnapshot<Map<String, dynamic>> doc =
            snapshot.docs.first;
        final Map<String, dynamic> json = doc.data();
        final UserModel loggedInUser = UserModel.fromJSON(
          json,
          userId: userId,
        );
        controller.add(loggedInUser);
      }
    });

    ref.onDispose(() {
      subscription.cancel();
      controller.close();
    });

    return controller.stream;
  },
);
