import 'dart:collection';
import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:device_uuid/device_uuid.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

String buildSign(
  Map<String, dynamic> query,
) {
  debugPrint('query = $query');
  var signMap = SplayTreeMap<String, dynamic>.from(query, (a, b) => a.compareTo(b));
  // debugPrint('signMap = $signMap');
  List<String> signList = [];
  signMap.forEach((key, value) {
    // var val = Uri.encodeQueryComponent(value.toString());  // 编码
    // signList.add('$key=$val');
    signList.add('$key=$value');
  });
  // debugPrint('signMap = $signMap,  signList = $signList');
  var signStr = signList.join("&");
  // debugPrint('signStr = $signStr');
  // signStr = Uri.decodeComponent(signStr);  // 解码
  return md5.convert(utf8.encode(signStr)).toString().toUpperCase();
}

Future<Map<String, dynamic>> mapString({Map<String, dynamic>? data}) async {
  String timeStr = DateTime.now().microsecondsSinceEpoch.toString().substring(0, 10);
  String uuid = await DeviceUuid().getUUID() ?? 'Unknown uuid version';
  Map<String, dynamic> dataMap = data!;
  dataMap['PLAT'] = 'ios';
  dataMap['PLATV'] = '12.0.1';
  dataMap['V'] = '1';
  dataMap['UUID'] = uuid;
  dataMap['NET'] = 'WIFI';
  dataMap['TIME'] = timeStr;

  String sign = buildSign(dataMap);
  // debugPrint('sign = $sign');
  dataMap['SIGN'] = sign;
  debugPrint('dataMap = $dataMap');
  return dataMap;
}

Future<String> uaString () async {
  final PackageInfo info = await PackageInfo.fromPlatform();
  String uuid = await DeviceUuid().getUUID() ?? 'uuid';
  String systemVersion = '';
  final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  if (Platform.isAndroid) {
    AndroidDeviceInfo androidDeviceInfo = await deviceInfoPlugin.androidInfo;
    systemVersion = androidDeviceInfo.version.release;
  } else if (Platform.isIOS) {
    IosDeviceInfo iosDeviceInfo = await deviceInfoPlugin.iosInfo;
    systemVersion = iosDeviceInfo.systemVersion!;
  }
  String str = 'sukan/${info.version}/$uuid/${info.packageName}/${Platform.isIOS ? 'ios' : 'android'}/$systemVersion';
  return str;
}