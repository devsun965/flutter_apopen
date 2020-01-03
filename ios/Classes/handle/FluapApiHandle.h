//
//  FluApApiHandle.h
//  flutter_apopen
//
//  Created by 孙宇 on 2019/12/17.
//

#import <Foundation/Foundation.h>
#import <Flutter/Flutter.h>

@interface FluApApiHandle : NSObject

- (void)registerApp:(FlutterMethodCall *)call result:(FlutterResult)result;

- (void)isAPAppInstalledWithResult:(FlutterResult)result;
@end

