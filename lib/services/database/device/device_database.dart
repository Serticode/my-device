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
  static final CollectionReference deletedDeviceCollection = FirebaseFirestore
      .instance
      .collection(FirebaseCollectionName.deletedDevices);
  static final CollectionReference lostDevicesCollection =
      FirebaseFirestore.instance.collection(FirebaseCollectionName.lostDevices);

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

  //! MARK AS LOST
  Future<bool> markAsLost(
      {required UserId userId, required DeviceModel device}) async {
    try {
      device.update("isLost", (value) => value = true);
      device.update("ownerId", (value) => value = userId);

      await lostDevicesCollection.add(device);

      await FirebaseFirestore.instance
          .runTransaction(maxAttempts: 3, timeout: const Duration(seconds: 30),
              (transaction) async {
            final QuerySnapshot<Object?> query = await deviceCollection
                .where(FirebaseDeviceFieldName.serialNumber,
                    isEqualTo: device.serialNumber)
                .get();
            for (final doc in query.docs) {
              transaction.delete(doc.reference);
            }
          })
          .catchError((error) => error.log())
          .then((value) => value?.log());

      return true;
    } catch (error) {
      error.log();
      return false;
    }
  }

  //! DELETE DEVICE -
  //! FIRST, ADD THE DELETED DEVICE TO THE LIST OF DELETED DEVICES SAME WAY IT WAS SAVED USING THE USERS ID
  //!  THEN DELETE THE DOCUMENT FROM THE USERS LIST OF DEVICES
  //! KEEP THE DEVICE IN STORAGE, FOR SCHOOL SECURITY PERSONNEL TO DELETE AT THE END OF THE SEMESTER OR SESSION
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
              final DeviceModel device = DeviceModel.fromJSON(
                  doc.data()! as Map<String, dynamic>,
                  ownerId: userId!);

              await deletedDeviceCollection.add(device);

              transaction.delete(doc.reference);
            }
          })
          .catchError((error) => error.log())
          .then((value) => value?.log());

      //! THE BELOW IS COMMENTED OUT, TO KEEP A REFERENCE TO THE METHOD OF DELETING THE DEVICE IMAGE DATA FROM
      //! FIREBASE STORAGE
      // await FirebaseStorage.instance
      //     .ref()
      //     .child(userId!)
      //     .child(FirebaseCollectionName.deviceImages)
      //     .child(deviceName!)
      //     .listAll()
      //     .then((value) {
      //   for (var element in value.items) {
      //     FirebaseStorage.instance.ref(element.fullPath).delete();
      //   }
      // });

      return true;
    } catch (error) {
      error.toString().log();

      return false;
    }
  }
}
