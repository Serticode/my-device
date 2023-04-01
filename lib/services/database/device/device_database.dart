import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_device/services/models/device/device_model.dart';
import 'package:my_device/services/models/firebase/firebase_collection_names.dart';
import 'package:my_device/services/models/firebase/firebase_device_field_name.dart';
import 'package:my_device/shared/utils/app_extensions.dart';
import 'package:my_device/shared/utils/type_defs.dart';

class DeviceDatabase {
  const DeviceDatabase();
  static final CollectionReference deviceCollection =
      FirebaseFirestore.instance.collection(FirebaseCollectionName.devices);

  //! SAVE DEVICE INFO
  Future<bool> saveDeviceInfo(
      {required String? ownerId,
      required String? deviceName,
      required String? deviceType,
      required String? serialNumber,
      required String? modelNumber,
      required String? brand,
      required String? deviceColour,
      required DateTime createdAt,
      required List<File>? deviceImages}) async {
    try {
      //! PLACE HOLDER
      List<String> deviceImageDownloadUrls = [];

      final Reference deviceImageRef = FirebaseStorage.instance
          .ref()
          .child(ownerId!)
          .child(FirebaseCollectionName.deviceImages)
          .child(deviceName!);

      for (var element in deviceImages!) {
        await deviceImageRef
            .child(element.path.split("/").last)
            .putFile(element)
            .then((snapshot) async => deviceImageDownloadUrls
                .add(await snapshot.ref.getDownloadURL()))
            .catchError((error) {
          error.toString().log();
        });
      }

      //! PAYLOAD
      final DeviceModel device = DeviceModel(
          ownerId: ownerId,
          deviceName: deviceName,
          deviceType: deviceType ?? "",
          deviceColour: deviceColour ?? "",
          modelNumber: modelNumber ?? "",
          serialNumber: serialNumber ?? "",
          brand: brand ?? "",
          isLost: false,
          createdAt: createdAt,
          deviceImages: deviceImageDownloadUrls);

      await deviceCollection.add(device);
      return true;
    } catch (error) {
      error.toString().log();

      return false;
    }
  }

  //! DELETE DEVICE
  Future<bool> deleteDevice({
    required String? serialNumber,
    required String? deviceName,
    required UserId? userId,
  }) async {
    try {
      await FirebaseFirestore.instance
          .runTransaction(maxAttempts: 3, timeout: const Duration(seconds: 30),
              (transaction) async {
            final QuerySnapshot<Object?> query = await deviceCollection
                .where(FirebaseDeviceFieldName.serialNumber,
                    isEqualTo: serialNumber)
                .get();
            for (final doc in query.docs) {
              transaction.delete(doc.reference);
            }
          })
          .catchError((error) => error.log())
          .then((value) => value?.log());

      await FirebaseStorage.instance
          .ref()
          .child(userId!)
          .child(FirebaseCollectionName.deviceImages)
          .child(deviceName!)
          .listAll()
          .then((value) {
        for (var element in value.items) {
          FirebaseStorage.instance.ref(element.fullPath).delete();
        }
      });

      return true;
    } catch (error) {
      error.toString().log();

      return false;
    }
  }
}
