//
//  FluapShareHandle.m
//  flutter_apopen
//
//  Created by 孙宇 on 2019/12/17.
//

#import "FluapShareHandle.h"
#import "APOpenAPI.h"
#import "FluapKeys.h"

@implementation FluapShareHandle

//  发送文本消息到支付宝
- (void)shareTextWithCall:(FlutterMethodCall *)call result:(FlutterResult)result
{
    //  创建消息载体 APMediaMessage 对象
    APMediaMessage *message = [[APMediaMessage alloc] init];
    
    //  创建文本类型的消息对象
    APShareTextObject *textObj = [[APShareTextObject alloc] init];
    textObj.text = call.arguments[fluapKeyText];
    //  回填 APMediaMessage 的消息对象
    message.mediaObject = textObj;
    
    //  创建发送请求对象
    APSendMessageToAPReq *request = [[APSendMessageToAPReq alloc] init];
    //  填充消息载体对象
    request.message = message;
    //  分享场景，0为分享到好友，1为分享到生活圈；支付宝9.9.5版本至现在版本，分享入口已合并，这个scene并没有被使用，用户会在跳转进支付宝后选择分享场景（好友、动态、圈子等），但为保证老版本上无问题、建议还是照常传入
    request.scene = 0;
    //  发送请求
    BOOL apResult = [APOpenAPI sendReq:request];
    result(@{fluapKeyPlatform: fluapKeyIOS, fluapKeyResult: @(apResult)});
    if (!apResult) {
        //失败处理
        NSLog(@"发送失败");
    }
}

- (void)shareImageDataWithCall:(FlutterMethodCall *)call result:(FlutterResult)result {
    if(![call.arguments[fluapKeyImageData] isKindOfClass:[FlutterStandardTypedData class]]) {
        
        return;
    }
    //  创建消息载体 APMediaMessage 对象
    APMediaMessage *message = [[APMediaMessage alloc] init];
    
    //  创建图片类型的消息对象
    APShareImageObject *imgObj = [[APShareImageObject alloc] init];
    //  此处填充图片data数据,例如 UIImagePNGRepresentation(UIImage对象)
    //  此处必须填充有效的image NSData类型数据，否则无法正常分享

    FlutterStandardTypedData *flutterData = call.arguments[fluapKeyImageData];
    imgObj.imageData = flutterData.data;
    //  回填 APMediaMessage 的消息对象
    message.mediaObject = imgObj;
    
    //  创建发送请求对象
    APSendMessageToAPReq *request = [[APSendMessageToAPReq alloc] init];
    //  填充消息载体对象
    request.message = message;
    //  分享场景，0为分享到好友，1为分享到生活圈；支付宝9.9.5版本至现在版本，分享入口已合并，这个scene并没有被使用，用户会在跳转进支付宝后选择分享场景（好友、动态、圈子等），但为保证老版本上无问题、建议还是照常传入
    request.scene = 0;
    //  发送请求
    BOOL apResult = [APOpenAPI sendReq:request];
    result(@{fluapKeyPlatform: fluapKeyIOS, fluapKeyResult: @(apResult)});
    if (!apResult) {
        //失败处理
        NSLog(@"发送失败");
    }
}

- (void)shareImageUrlWithCall:(FlutterMethodCall *)call result:(FlutterResult)result {
    //  创建消息载体 APMediaMessage 对象
    APMediaMessage *message = [[APMediaMessage alloc] init];
    
    //  创建图片类型的消息对象
    APShareImageObject *imgObj = [[APShareImageObject alloc] init];
    imgObj.imageUrl = call.arguments[fluapKeyImageUrl];
    //  回填 APMediaMessage 的消息对象
    message.mediaObject = imgObj;
    
    //  创建发送请求对象
    APSendMessageToAPReq *request = [[APSendMessageToAPReq alloc] init];
    //  填充消息载体对象
    request.message = message;
    //  分享场景，0为分享到好友，1为分享到生活圈；支付宝9.9.5版本至现在版本，分享入口已合并，这个scene并没有被使用，用户会在跳转进支付宝后选择分享场景（好友、动态、圈子等），但为保证老版本上无问题、建议还是照常传入
    request.scene = 0;
    //  发送请求
    BOOL apResult = [APOpenAPI sendReq:request];
    result(@{fluapKeyPlatform: fluapKeyIOS, fluapKeyResult: @(apResult)});
    
    if (!apResult) {
        //失败处理
        NSLog(@"发送失败");
    }
}

- (void)shareWebAndImageDataWithCall:(FlutterMethodCall *)call result:(FlutterResult)result {
    //  创建消息载体 APMediaMessage 对象
    APMediaMessage *message = [[APMediaMessage alloc] init];
    
    message.title = call.arguments[fluapKeyTitle];
    message.desc = call.arguments[fluapKeyDesc];
    //  此处填充缩略图data数据,例如 UIImagePNGRepresentation(UIImage对象)
    //  此处必须填充有效的image NSData类型数据，否则无法正常分享
    FlutterStandardTypedData *flutterData = call.arguments[fluapKeyImageData];
    message.thumbData = flutterData.data;
    
    //  创建网页类型的消息对象
    APShareWebObject *webObj = [[APShareWebObject alloc] init];
    webObj.wepageUrl = call.arguments[fluapKeywebUrl];
    //  回填 APMediaMessage 的消息对象
    message.mediaObject = webObj;
    
    //  创建发送请求对象
    APSendMessageToAPReq *request = [[APSendMessageToAPReq alloc] init];
    //  填充消息载体对象
    request.message = message;
    //  分享场景，0为分享到好友，1为分享到生活圈；支付宝9.9.5版本至现在版本，分享入口已合并，这个scene并没有被使用，用户会在跳转进支付宝后选择分享场景（好友、动态、圈子等），但为保证老版本上无问题、建议还是照常传入
    request.scene = 0;
    //  发送请求
    BOOL apResult = [APOpenAPI sendReq:request];
    result(@{fluapKeyPlatform: fluapKeyIOS, fluapKeyResult: @(apResult)});
    
    if (!apResult) {
        //失败处理
        NSLog(@"发送失败");
    }
}

- (void)shareWebAndImageUrlWithCall:(FlutterMethodCall *)call result:(FlutterResult)result {
    //  创建消息载体 APMediaMessage 对象
    APMediaMessage *message = [[APMediaMessage alloc] init];
    
    message.title = call.arguments[fluapKeyTitle];
    message.desc = call.arguments[fluapKeyDesc];
    message.thumbUrl = call.arguments[fluapKeyImageUrl];
    
    //  创建网页类型的消息对象
    APShareWebObject *webObj = [[APShareWebObject alloc] init];
    webObj.wepageUrl = call.arguments[fluapKeywebUrl];
    //  回填 APMediaMessage 的消息对象
    message.mediaObject = webObj;
    
    //  创建发送请求对象
    APSendMessageToAPReq *request = [[APSendMessageToAPReq alloc] init];
    //  填充消息载体对象
    request.message = message;
    //  分享场景，0为分享到好友，1为分享到生活圈；支付宝9.9.5版本至现在版本，分享入口已合并，这个scene并没有被使用，用户会在跳转进支付宝后选择分享场景（好友、动态、圈子等），但为保证老版本上无问题、建议还是照常传入
    request.scene = 0;
    //  发送请求
    BOOL apResult = [APOpenAPI sendReq:request];
    result(@{fluapKeyPlatform: fluapKeyIOS, fluapKeyResult: @(apResult)});
    
    if (!apResult) {
        //失败处理
        NSLog(@"发送失败");
    }
}



@end
