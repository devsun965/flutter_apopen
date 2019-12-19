#import "FlutterApopenPlugin.h"
#import <flutter_apopen/flutter_apopen-Swift.h>
#import "FluApApiHandle.h"
#import "FluapShareHandle.h"
#import "APOpenAPI.h"
#import "FluapMethod.h"

@implementation FlutterApopenPlugin

FluApApiHandle *_fluApApiHandle;
FluapShareHandle *_fluApShareHandle;

+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
//   [SwiftFlutterApopenPlugin registerWithRegistrar:registrar];

    FlutterMethodChannel *channel = [FlutterMethodChannel
            methodChannelWithName:@"com.sunpub/apopen"
                  binaryMessenger:[registrar messenger]];

    FlutterApopenPlugin *instance = [[FlutterApopenPlugin alloc] initWithRegistrar:registrar methodChannel:channel];
    [registrar addMethodCallDelegate:instance channel:channel];
    [registrar addApplicationDelegate:instance];                    
}

- (instancetype)initWithRegistrar:(NSObject <FlutterPluginRegistrar> *)registrar methodChannel:(FlutterMethodChannel *)flutterMethodChannel {
    self = [super init];
    if (self) {
        _fluApApiHandle = [[FluApApiHandle alloc]init];
        _fluApShareHandle = [[FluapShareHandle alloc]init];
    }

    return self;
}

- (void)handleMethodCall:(FlutterMethodCall *)call result:(FlutterResult)result {
    if([fluapMethodsRegister isEqualToString: call.method]) {
        [_fluApApiHandle registerApp:call result:result];        
    }else if ([fluapMethodsShareText isEqualToString: call.method]) {
        [_fluApShareHandle shareTextWithCall:call result:result];
    }else if ([fluapMethodsShareImageData isEqualToString: call.method]) {
        [_fluApShareHandle shareImageDataWithCall:call result:result];
    }else if ([fluapMethodsShareImageUrl isEqualToString: call.method]) {
        [_fluApShareHandle shareImageUrlWithCall:call result:result];
    }else if ([fluapMethodsShareWebImageData isEqualToString: call.method]) {
        [_fluApShareHandle shareWebAndImageDataWithCall:call result:result];
    }else if ([fluapMethodsShareWebImageUrl isEqualToString: call.method]) {
        [_fluApShareHandle shareWebAndImageUrlWithCall:call result: result];
    }
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    //  处理支付宝通过URL启动App时传递的数据
    return [APOpenAPI handleOpenURL:url delegate:self];
}

/*
 *  收到一个来自支付宝的请求，第三方应用程序处理完后调用sendResp向支付宝发送结果
 *
 *  入参
 *      req : 支付宝向第三方发来的请求类
 */
- (void)onReq:(APBaseReq*)req
{}
/*
 *  第三方应用程序发送一个sendReq后，收到支付宝的响应结果
 *
 *  入参
 *      resp : 第三方应用收到的支付宝的响应结果类，目前支持的类型包括 APSendMessageToAPResp(分享消息)
 */
- (void)onResp:(APBaseResp*)resp
{
    //  Demo内主要是将响应结果通过alert的形式反馈出来，第三方应用可以根据 errCode 进行相应的处理。
    NSString *title = nil;
    NSString *message = nil;
    if (resp.errCode == APSuccess) {
        title = @"成功";
    } else {
        title = @"失败";
        message = [NSString stringWithFormat:@"%@(%d)", resp.errStr, resp.errCode];
    }
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alert show];
}

@end
