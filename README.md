## official documents
Before use Apopen,please read the [official documents](https://docs.open.alipay.com/215/105279/ "official documents").

## support
- Share Text
- Share ImageUrl
- Share Image with UInt8List(byte[])
- Share WebPage(ImageUrl)
- Share WebPage(Image with UInt8List(byte[]))

## Dependencies

Add the following dependencies in your `pubspec.yaml` file:

```yaml
dependencies:
  flutter_apopen: ^${latestVersion}
```
## Register ApOpenSDK via flutter_apopen
 ```dart
    import 'package:flutter_apopen/flutter_apopen.dart' as apopen;
    apopen.registerAP(appId: "2019111369123863");
 ```
 ## Share
 ### ShareText
  ```dart
  void shareText() async {
    var result = await apopen.shareText('This is a Share Text');
    print(result);
  } 
 ```
  ### ShareText
  ```dart
  void shareText() async {
    var result = await apopen.shareText('This is a Share Text');
    print(result);
  } 
 ```
  ### ShareImageUrl
  ```dart
  void shareImageUrl() async{
    var result = await apopen.shareImageUrl('http://XXX.jpg');
    print(result);
  }
 ```
  ### ShareImageData
  ```dart
  void shareImageData() async{
    String assetPath = 'images/test.png';
    ByteData byteData = await rootBundle.load(assetPath);
    Uint8List pngBytes = byteData.buffer.asUint8List();

    var result = await apopen.shareImageData(pngBytes);
    print(result);
  }
 ```
  ### ShareWebWithImageData
  ```dart
    String assetPath = 'images/test.png';
    ByteData byteData = await rootBundle.load(assetPath);
    Uint8List pngBytes = byteData.buffer.asUint8List();

    var result = await apopen.shareWebAndImgData(
      imageData: pngBytes,
      wepageUrl: 'https://www.XXX.com',
      title: 'Text Title',
      desc: 'Text desc',
      );
    print(result);
 ```

   ### ShareWebWithImageUrl
  ```dart
    var result = await apopen.shareWebAndImgUrl(
      imageUrl: 'http://XXX.jpg',
      wepageUrl: 'https://www.XXX.com',
      title: 'Text Title',
      desc: 'Text desc',
      );
    print(result);
 ```