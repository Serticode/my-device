import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_device/services/models/device/device_model.dart';
import 'package:my_device/services/models/device/found_device_model.dart';
import 'package:my_device/services/models/firebase/firebase_collection_names.dart';
import 'package:my_device/services/models/firebase/firebase_device_field_name.dart';
import 'package:my_device/services/providers/user_id/user_id_provider.dart';

final AutoDisposeStreamProvider<Iterable<FoundDeviceModel>>
    foundDevicesProvider =
    StreamProvider.autoDispose<Iterable<FoundDeviceModel>>(
  (ref) {
    final userId = ref.watch(userIdProvider);

    final controller = StreamController<Iterable<FoundDeviceModel>>();

    controller.onListen = () {
      controller.sink.add([]);
    };

    final sub = FirebaseFirestore.instance
        .collection(FirebaseCollectionName.foundDevices)
        .orderBy(FirebaseDeviceFieldName.createdAt, descending: true)
        .where(FirebaseDeviceFieldName.ownerId, isEqualTo: userId)
        .snapshots(includeMetadataChanges: true)
        .listen((snapshot) {
      final List<QueryDocumentSnapshot<Map<String, dynamic>>> documents =
          snapshot.docs;
      final Iterable<FoundDeviceModel> devices = documents
          .where((doc) => !doc.metadata.hasPendingWrites)
          .map((doc) => FoundDeviceModel.fromJSON(doc.data(),
              device: DeviceModel.fromJSON(doc.data()["device"],
                  ownerId: userId!)));
      controller.sink.add(devices);
    });

    ref.onDispose(() {
      sub.cancel();
      controller.close();
    });

    return controller.stream;
  },
);
