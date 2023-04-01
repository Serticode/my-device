import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_device/services/models/device/device_model.dart';
import 'package:my_device/services/models/firebase/firebase_collection_names.dart';
import 'package:my_device/services/models/firebase/firebase_device_field_name.dart';
import 'package:my_device/services/providers/user_id/user_id_provider.dart';

final AutoDisposeStreamProvider<Iterable<DeviceModel>>
    userDeletedDevicesProvider =
    StreamProvider.autoDispose<Iterable<DeviceModel>>(
  (ref) {
    final userId = ref.watch(userIdProvider);

    final controller = StreamController<Iterable<DeviceModel>>();

    controller.onListen = () {
      controller.sink.add([]);
    };

    final sub = FirebaseFirestore.instance
        .collection(FirebaseCollectionName.deletedDevices)
        .orderBy(FirebaseDeviceFieldName.createdAt, descending: true)
        .where(FirebaseDeviceFieldName.ownerId, isEqualTo: userId)
        .snapshots(includeMetadataChanges: true)
        .listen((snapshot) {
      final List<QueryDocumentSnapshot<Map<String, dynamic>>> documents =
          snapshot.docs;
      final Iterable<DeviceModel> devices = documents
          .where((doc) => !doc.metadata.hasPendingWrites)
          .map((doc) => DeviceModel.fromJSON(doc.data(), ownerId: doc.id));
      controller.sink.add(devices);
    });

    ref.onDispose(() {
      sub.cancel();
      controller.close();
    });

    return controller.stream;
  },
);
