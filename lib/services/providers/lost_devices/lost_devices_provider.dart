import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_device/services/models/device/device_model.dart';
import 'package:my_device/services/models/firebase/firebase_collection_names.dart';
import 'package:my_device/services/models/firebase/firebase_device_field_name.dart';
import 'package:my_device/services/providers/user_id/user_id_provider.dart';
import 'package:my_device/shared/utils/app_extensions.dart';

final AutoDisposeStreamProvider<Iterable<DeviceModel>> lostDevicesProvider =
    StreamProvider.autoDispose<Iterable<DeviceModel>>(
  (ref) {
    final controller = StreamController<Iterable<DeviceModel>>();

    controller.onListen = () {
      controller.sink.add([]);
    };

    final sub = FirebaseFirestore.instance
        .collection(FirebaseCollectionName.lostDevices)
        .orderBy(FirebaseDeviceFieldName.createdAt, descending: true)
        .snapshots(includeMetadataChanges: true)
        .listen((snapshot) {
      final List<QueryDocumentSnapshot<Map<String, dynamic>>> documents =
          snapshot.docs;
      final Iterable<DeviceModel> devices = documents
          .where((doc) => !doc.metadata.hasPendingWrites)
          .map((doc) =>
              DeviceModel.fromJSON(doc.data(), ownerId: doc.data()["ownerId"]));
      controller.sink.add(devices);
    });

    ref.onDispose(() {
      sub.cancel();
      controller.close();
    });

    return controller.stream;
  },
);
