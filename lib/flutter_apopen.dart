// import 'dart:async';

// import 'package:flutter/services.dart';

// class FlutterApopen {
//   static const MethodChannel _channel =
//       const MethodChannel('com.sunpub/apopen');

//   static Future<String> get platformVersion async {
//     final String version = await _channel.invokeMethod('getPlatformVersion');
//     return version;
//   }
// }

library apopen;

export './src/apopen_iml.dart';
