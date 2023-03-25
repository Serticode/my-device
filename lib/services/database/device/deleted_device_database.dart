import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_device/services/models/device/device_model.dart';
import 'package:my_device/services/models/firebase/firebase_collection_names.dart';
import 'package:my_device/services/models/firebase/firebase_device_field_name.dart';
import 'package:my_device/shared/utils/app_extensions.dart';

class DeletedDevicesDatabase {
  const DeletedDevicesDatabase();
  static final CollectionReference deviceCollection = FirebaseFirestore.instance
      .collection(FirebaseCollectionName.deletedDevices);

  //! SAVE DEVICE INFO
  Future<bool> storeDeletedDevice({required DeviceModel device}) async {
    //! PAYLOAD

    try {
      await deviceCollection.add(device);
      return true;
    } catch (error) {
      error.toString().log();

      return false;
    }
  }

  /* //! DELETE DEVICE
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
  } */
}
