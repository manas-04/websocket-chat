import 'package:hive/hive.dart';
import 'package:flutter/material.dart';

import '../utils/database_constants.dart';

class DatabaseService {
  static late final Box<String> userBox;

  static Future<void> init() async {
    try {
      userBox = await Hive.openBox<String>(DatabaseConstants.userBox);
    } catch (error) {
      debugPrint("Error occured while opening hive");
    }
  }

  static Future<void> put(Box<String> box, dynamic key, dynamic value) async {
    if (value == null) {
      debugPrint('Value must not be null');
      return;
    }
    try {
      await box.put(key, value);
    } catch (e) {
      debugPrint('Failed to save data: $e');
      rethrow;
    }
  }

  static dynamic get(Box<String> box, dynamic key) {
    if (key == null) {
      return null;
    }
    try {
      return box.get(key);
    } catch (err) {
      debugPrint('Data base error: $err');
      return null;
    }
  }
}
