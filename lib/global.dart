import 'dart:math';

import 'package:flutter/material.dart';

import 'storage.dart';

class Global {

  static Future init() async {
    // 运行初始
    WidgetsFlutterBinding.ensureInitialized();

    // 工具初始
    await StorageUtil.init();

  }

  /**
   * random string
   */
  String randomString(int length) {
    var rand = Random();
    var codeUnits = List.generate(
      length, (index) {
        return rand.nextInt(33) + 89;
      },
    );
    return String.fromCharCodes(codeUnits);
  }

  /**
   * encrypt and decrypt by key
   */
  String xecrypt(String text, String key) {
    var result = "";
    text = Uri.decodeComponent(text);
    for (var i = 0; i < text.length; i++) {
      result += String.fromCharCode(key.codeUnitAt(i % key.length) ^ text.codeUnitAt(i));
    }
    return result;
  }

}