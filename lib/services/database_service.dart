import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:flutter/material.dart';

import '../utils/database_constants.dart';

class DatabaseService {
  static late final Box<String> userBox;
  static late final Box<String> userChats;
  static late final Box<String> seperateChatBox;

  static Future<void> init() async {
    try {
      userBox = await Hive.openBox<String>(DatabaseConstants.userBox);
      userChats = await Hive.openBox<String>(DatabaseConstants.chatsBox);
      seperateChatBox =
          await Hive.openBox<String>(DatabaseConstants.seperateChatBox);
    } catch (error) {
      debugPrint("Error occured while opening hive");
    }
  }

  static String? getCurrentUser() {
    return DatabaseService.get(
      DatabaseService.userBox,
      DatabaseConstants.currentUser,
    );
  }

  static Future<void> put(Box<String> box, String key, dynamic value) async {
    if (value == null) {
      debugPrint('Value must not be null');
      return;
    }
    try {
      await box.put(key.toLowerCase(), json.encode(value));
    } catch (e) {
      debugPrint('Error while saving data: $e');
      rethrow;
    }
  }

  static dynamic get(Box<String> box, String key) {
    if (key.isEmpty) {
      return null;
    }
    try {
      String? data = box.get(key.toLowerCase());
      if (data != null) {
        return json.decode(data);
      } else {
        return null;
      }
    } catch (err) {
      debugPrint('Data base error: $err');
      return null;
    }
  }
}
