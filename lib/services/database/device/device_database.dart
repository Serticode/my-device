import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_device/services/models/device/device_model.dart';
import 'package:my_device/services/models/firebase/firebase_collection_names.dart';
import 'package:my_device/services/models/firebase/firebase_device_field_name.dart';
import 'package:my_device/shared/utils/app_extensions.dart';

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
      required List<String>? deviceImages}) async {
    //! PAYLOAD
    final DeviceModel device = DeviceModel(
        ownerId: ownerId ?? "",
        deviceName: deviceName ?? "",
        deviceType: deviceType ?? "",
        deviceColour: deviceColour ?? "",
        modelNumber: modelNumber ?? "",
        serialNumber: serialNumber ?? "",
        brand: brand ?? "",
        isLost: false,
        createdAt: createdAt,
        deviceImages: deviceImages ?? []);

    try {
      //! GET DEVICE REFERENCE DOC ,. IF IT EXISTS, UPDATE IT; ELSE ADD A NEW DOC.
      await deviceCollection
          .where(FirebaseDeviceFieldName.ownerId, isEqualTo: ownerId)
          .limit(1)
          .get()
          .then((deviceInfo) async {
        if (deviceInfo.docs.isNotEmpty) {
          await deviceInfo.docs.first.reference.update(device);
          return true;
        }
      });

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
  }) async {
    try {
      FirebaseFirestore.instance
          .runTransaction(maxAttempts: 3, timeout: const Duration(seconds: 30),
              (transaction) async {
            final query = await deviceCollection
                .where(FirebaseDeviceFieldName.serialNumber,
                    isEqualTo: serialNumber)
                .get();
            for (final doc in query.docs) {
              transaction.delete(doc.reference);
            }
          })
          .catchError((error) => error.log())
          .then((value) => value?.log());
      return true;
    } catch (error) {
      error.toString().log();

      return false;
    }
  }
}
