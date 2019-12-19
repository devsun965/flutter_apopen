import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

final MethodChannel _channel = const MethodChannel('com.sunpub/apopen')
  ..setMethodCallHandler(_handler);

Future<dynamic> _handler(MethodCall methodCall) {
  return Future.value(true);
}

// register ApOpen
Future registerAP({String appId}) async {
  return await _channel.invokeMethod("registerAp", {
    "appId": appId
  });
}
// ShareText to AliPay
Future shareText(String text) async {
  return await _channel.invokeMethod("shareText", {
    "text": text
  });  
}
// Share Image
Future shareImageData(Uint8List data) async {
  return await _channel.invokeMethod("shareImageData", {
    "imageData": data
  });  
}
Future shareImageUrl(String url) async {
  return await _channel.invokeMethod("shareImageUrl", {
    "imageUrl": url
  });  
}
// Share Web with imageData
Future shareWebAndImgData(
  {
    String title = '',
    String desc = '',
    @required
    String wepageUrl = '',
    @required
    Uint8List imageData
  }
) async {
  return await _channel.invokeMethod("shareWebData", {
    "title": title,
    "desc": desc,
    "wepageUrl": wepageUrl,
    "imageData": imageData
  });  
}
// Share Web with imageUrl
Future shareWebAndImgUrl(
  {
    String title = '',
    String desc = '',
    @required
    String wepageUrl = '',
    @required
    String imageUrl
  }
) async {
  return await _channel.invokeMethod("shareWebUrl", {
    "title": title,
    "desc": desc,
    "wepageUrl": wepageUrl,
    "imageUrl": imageUrl
  });  
}