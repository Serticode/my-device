import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_device/services/controllers/upload_image/upload_image_controller.dart';
import 'package:my_device/shared/utils/type_defs.dart';

final StateNotifierProvider<UploadImageController, bool> uploadImageProvider =
    StateNotifierProvider<UploadImageController, IsLoading>(
  (ref) => UploadImageController(),
);
