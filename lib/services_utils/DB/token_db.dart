import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

class TokenDB {
  static late var tokenDb;

  static Future<void> openTokenBox() async {
    try {
      tokenDb = await Hive.openBox<String>("tokenDb");
      saveAccessNotification('false');
    } catch (e) {
      debugPrint("UserDB openTokenBox ERROR:$e");
      return;
    }
  }

  static void saveUserToken(String token) {
    try {
      tokenDb.put('token', token);
    } catch (e) {
      debugPrint(e.toString());
      debugPrint("UserDB saveUserToken ERROR:$e");
    }
  }

  static void saveLogID(int logID) {
    try {
      tokenDb.put('logID', logID.toString());
    } catch (e) {
      debugPrint(e.toString());
      debugPrint("UserDB saveLogID ERROR:$e");
    }
  }

  static void saveAccessNotification(String? isConsumed) {
    try {
      tokenDb.put('isConsumed', isConsumed);
    } catch (e) {
      debugPrint(e.toString());
      debugPrint("UserDB saveAccessNotification ERROR:$e");
    }
  }

  static String? getAccessNotification() {
    try {
      return tokenDb.get('isConsumed');
    } catch (e) {
      debugPrint("UserDB getAccessNotification ERROR:$e");
      return null;
    }
  }

  static String? getUserToken() {
    try {
      return tokenDb.get('token');
    } catch (e) {
      debugPrint("UserDB getUserToken ERROR:$e");
      return null;
    }
  }

  static String? getUserLogID() {
    try {
      return tokenDb.get('logID') ?? null;
    } catch (e) {
      debugPrint("UserDB getUserLogID ERROR:$e");
      return null;
    }
  }

  static void clearUserToken() {
    try {
      return tokenDb.put('token', 'null');
    } catch (e) {
      debugPrint("UserDB clearUserToken ERROR:$e");
      return;
    }
  }
}
