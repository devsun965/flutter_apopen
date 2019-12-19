import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_apopen/flutter_apopen.dart' as apopen;


void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
    registerApOpen();
  }
  registerApOpen() async{
    var result = await apopen.registerAP(appId: "2019111369123863");
    print(result);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('AliPay Share'),
        ),
        body: new Container(
          child: new ListView(
            children: <Widget>[
              ListTile(
                title: new Text(
                  'Share Text'
                ),
                onTap: shareText,
              ),
              ListTile(
                title: new Text(
                  'Share Image with URL'
                ),
                onTap: shareImageUrl,
              ),
              ListTile(
                title: new Text(
                  'Share Image with Data'
                ),
                onTap: shareImageData,
              ),
              ListTile(
                title: new Text(
                  'Share Image with URL'
                ),
                onTap: shareWebWithImageData,
              ),
              ListTile(
                title: new Text(
                  'Share Image with Data'
                ),
                onTap: shareWebWithImageUrl,
              ),              
            ],
          ),
        )
      ),
    );
  }

  void shareText() async {
    var result = await apopen.shareText('这是一条分享信息');
    print(result);
  } 

  void shareImageUrl() async{
    var result = await apopen.shareImageUrl('http://cdn6.hbimg.cn/store/tuku/310_999/bigfiles/200948/887EDAB4E8C49EB182F1D5CF4AAF88.jpg');
    print(result);    
  }

  void shareImageData() async{
    String assetPath = 'images/test.png';
    ByteData byteData = await rootBundle.load(assetPath);
    Uint8List pngBytes = byteData.buffer.asUint8List();

    var result = await apopen.shareImageData(pngBytes);
    print(result);    
  }  

  void shareWebWithImageData() async{
    String assetPath = 'images/test.png';
    ByteData byteData = await rootBundle.load(assetPath);
    Uint8List pngBytes = byteData.buffer.asUint8List();
    
    var result = await apopen.shareWebAndImgData(
      imageData: pngBytes,
      wepageUrl: 'https://www.baidu.com',
      title: '测试标题',
      desc: '测试描述',
      );
    print(result);        
  }
  void shareWebWithImageUrl() async{
    var result = await apopen.shareWebAndImgUrl(
      imageUrl: 'http://cdn6.hbimg.cn/store/tuku/310_999/bigfiles/200948/887EDAB4E8C49EB182F1D5CF4AAF88.jpg',
      wepageUrl: 'https://www.baidu.com',
      title: '测试标题',
      desc: '测试描述',
      );
    print(result);  
  }
}
