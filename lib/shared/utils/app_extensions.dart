//! THIS FILE CONTAINS ALL EXTENSIONS USED WITH IN THE APP.
import "dart:developer" as dev_tools show log;
import "package:flutter/material.dart";
import "package:my_device/shared/utils/type_defs.dart";

//! LOG EXTENSION - THIS HELPS TO CALL A .log() ON ANY OBJECT
extension Log on Object {
  void log() => dev_tools.log(toString());
}

//! HELPS TO CALL A .dismissKeyboard ON A WIDGET
extension DismissKeyboard on Widget {
  void dismissKeyboard() => FocusManager.instance.primaryFocus?.unfocus();
}

//! EXTENSION TO ASSIST WITH FILE TYPE
extension CollectionName on FileType {
  String get collectionName {
    switch (this) {
      case FileType.image:
        return "images";
      case FileType.video:
        return "videos";
    }
  }
}
