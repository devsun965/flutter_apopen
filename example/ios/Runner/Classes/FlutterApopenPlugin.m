#import "FlutterApopenPlugin.h"
#import <flutter_apopen/flutter_apopen-Swift.h>

@implementation FlutterApopenPlugin
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
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(handleOpenURL:)
//                                                 name:@"WeChat"
//                                               object:nil];
    if (self) {

    }

    return self;
}

- (void)handleMethodCall:(FlutterMethodCall *)call result:(FlutterResult)result {
    if([@"registerAp" isEqualToString: call.method]) {
        
    }
}
@end
