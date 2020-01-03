//
//  FluApApiHandle.m
//  flutter_apopen
//
//  Created by 孙宇 on 2019/12/17.
//

#import "FluapApiHandle.h"
#import "APOpenAPI.h"
#import "FluapKeys.h"

@implementation FluApApiHandle

- (void)registerApp:(FlutterMethodCall *)call result:(FlutterResult)result {
    if(!call.arguments[fluapKeyAppid]) {
        result(@{fluapKeyPlatform: fluapKeyIOS, fluapKeyResult: @(NO)});
        return;
    }
    
    BOOL registerBool = [APOpenAPI registerApp: call.arguments[fluapKeyAppid]];
    
    result(@{fluapKeyPlatform: fluapKeyIOS, fluapKeyResult: @(registerBool)});

}

- (void)isAPAppInstalledWithResult:(FlutterResult)result {
    result(@([APOpenAPI isAPAppInstalled]));
}

@end
