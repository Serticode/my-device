import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_device/services/controllers/auth_controller.dart';
import 'package:my_device/services/models/auth/user_model/user_model.dart';
import 'package:my_device/services/models/firebase/firebase_collection_names.dart';
import 'package:my_device/services/models/firebase/firebase_user_field_name.dart';
import 'package:my_device/services/states/auth/auth_state.dart';
import 'package:my_device/shared/utils/type_defs.dart';

//! AUTH STATE PROVIDER / AUTH CONTROLLER PROVIDER
final StateNotifierProvider<AuthController, AuthState> authControllerProvider =
    StateNotifierProvider<AuthController, AuthState>((ref) => AuthController());

//! IS LOGGED IN PROVIDER
final Provider<bool> isLoggedInProvider = Provider<bool>((ref) {
  final authState = ref.watch(authControllerProvider);
  return authState.result == AuthResult.success;
});

//! USER ID PROVIDER
final Provider<UserId?> userIdProvider =
    Provider<UserId?>((ref) => ref.watch(authControllerProvider).userId);

//! IS LOADING PROVIDER
final Provider<bool> isLoadingProvider = Provider<bool>((ref) {
  final AuthState authState = ref.watch(authControllerProvider);

  return authState.isLoading;
});

//! USER INFO PROVIDER
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
