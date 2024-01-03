// Dart imports:

// Package imports:
import 'package:flutter_guid/flutter_guid.dart';
import 'package:get_storage/get_storage.dart';

// Project imports:

// Project imports:

class Box {
  //#region BASE METHODS
  static Future<void> setString(String key, String value) async {
    final box = GetStorage();
    await box.write(key, value);
  }

  static String getString({required String key, String? defaultVal}) {
    final box = GetStorage();
    return box.read(key) ?? (defaultVal ?? "");
  }

  static Future<void> setInt(String key, int value) async {
    final box = GetStorage();
    await box.write(key, value);
  }

  static int getInt(String key) {
    final box = GetStorage();
    return box.read(key) ?? 0;
  }

  static Future<void> setBool(String key, bool value) async {
    final box = GetStorage();
    await box.write(key, value);
  }

  static bool getBool(String key) {
    final box = GetStorage();
    return box.read(key) ?? false;
  }
  //#endregion

  static String get deviceId {
    String id = getString(key: "deviceId", defaultVal: "");
    if (id.isNotEmpty) {
      return id;
    } else {
      String newId = Guid.newGuid.toString();
      setString("deviceId", newId);
      return newId;
    }
  }
}
