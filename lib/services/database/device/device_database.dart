import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_device/services/models/device/device_model.dart';
import 'package:my_device/services/models/firebase/firebase_collection_names.dart';
import 'package:my_device/services/models/firebase/firebase_device_field_name.dart';
import 'package:my_device/shared/utils/app_extensions.dart';
import 'package:my_device/shared/utils/type_defs.dart';

class DeviceDatabase {
  const DeviceDatabase();
  static final CollectionReference deviceCollection =
      FirebaseFirestore.instance.collection(FirebaseCollectionName.students);

  //! UPDATE DEVICE INFO
  Future<bool> saveDeviceInfo(
      {required String? ownerId,
      required String? deviceId,
      required String? deviceName,
      required DeviceType? deviceType,
      required String? serialNumber,
      required String? modelNumber,
      required String? brand,
      required bool? isLost,
      required String? deviceColour,
      required List<String>? deviceImages}) async {
    //! PAYLOAD
    final DeviceModel device = DeviceModel(
        ownerId: ownerId ?? "",
        deviceId: deviceId ?? "",
        deviceName: deviceName ?? "",
        deviceType: deviceType ?? DeviceType.smartPhone,
        deviceColour: deviceColour ?? "",
        modelNumber: modelNumber ?? "",
        serialNumber: serialNumber ?? "",
        brand: brand ?? "",
        isLost: isLost ?? false,
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
}
