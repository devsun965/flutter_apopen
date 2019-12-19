//
//  FluapShareHandle.h
//  flutter_apopen
//
//  Created by 孙宇 on 2019/12/17.
//

#import <Foundation/Foundation.h>
#import <Flutter/Flutter.h>

@interface FluapShareHandle : NSObject

/// Send Text to AliPay
/// @param text shareText
- (void)shareTextWithCall:(FlutterMethodCall *)call result:(FlutterResult)result;

- (void)shareImageDataWithCall:(FlutterMethodCall *)call result:(FlutterResult)result;

- (void)shareImageUrlWithCall:(FlutterMethodCall *)call result:(FlutterResult)result;

- (void)shareWebAndImageDataWithCall:(FlutterMethodCall *)call result:(FlutterResult)result;

- (void)shareWebAndImageUrlWithCall:(FlutterMethodCall *)call result:(FlutterResult)result;

@end

