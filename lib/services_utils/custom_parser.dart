import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';

class CustomParser {
  static List<dynamic> listParser({
    required String res,
    dynamic object,
    List<String>? path,
    bool doubleDecode = false,
  }) {
    try {
      // log(res);
      if (res.isEmpty) return [];
      var js = json.decode(res);
      if (path == null) if (!(js is List)) return [];
      if (doubleDecode) js = json.decode(js as String);
      if (path != null) {
        path.forEach((element) {
          js = js[element];
        });
      }
      Iterable itr = js;
      return List<dynamic>.from(
        itr.map((model) => object.fromJson(model)),
      );
    } catch (e) {
      debugPrint('listParser error $e');

      return [];
    }
  }

  static objectParser(
      {required String res,
      dynamic object,
      List<String>? path,
      int? objectIndexFromList}) {
    try {
      if (res.isEmpty) return object;
      var js = json.decode(res);
      if (path != null) {
        path.forEach((element) {
          js = js[element];
        });
      }
      if (objectIndexFromList != null) js = js[objectIndexFromList];
      return object.fromJson(js);
    } catch (e) {
      debugPrint('ObjectParser error $e');
      return object;
    }
  }

  static String? stringParser(
    String? res,
    List<String> path,
  ) {
    try {
      debugPrint(res);
      if (res == null || res.isEmpty) return null;
      var js = json.decode(res);
      if (path != null) {
        path.forEach((element) {
          js = js[element];
        });
      }
      return js.toString();
    } catch (e) {
      debugPrint('StudentParser parseStudentCertificate error $e');
      return null;
    }
  }
}
