//
//  SCFlutterNativePlugin.m
//  Runner
//
//  Created by ly on 2022/10/28.
//

#import "SCFlutterNativePlugin.h"


@implementation SCFlutterNativePlugin

+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar> *)registrar {
    FlutterMethodChannel *methodChannel = [FlutterMethodChannel methodChannelWithName:@"flutter_to_native" binaryMessenger:[registrar messenger]];
    SCFlutterNativePlugin *instance = [[SCFlutterNativePlugin alloc]init];
    [registrar addMethodCallDelegate:instance channel:methodChannel];
    
    
    
    // 发送消息
    // 原生调用 flutter
    // Method : Method 名称
    // arguments : 传递给 flutter 的数据
    // result : 是 flutter 回调回来的数据
    [methodChannel invokeMethod:@"one" arguments:@"来自 ios channel_1 的参数" result:^(id  _Nullable result) {
        NSLog(@"ios: %@", result);
    }];

    
    

    // 接收消息
    // flutter调用原生
    [methodChannel setMethodCallHandler:^(FlutterMethodCall * _Nonnull call, FlutterResult  _Nonnull result) {

        NSLog(@"%@", call.arguments);

        if ([call.method isEqual:@"test1"]) {
            result(@"展示test1");

        } else if ([call.method isEqual:@"test2"]) {
            //result(@"展示test2");
  
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"test2" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                
            }];

            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * action) { }];
            [alert addAction:sureAction];
            [alert addAction:cancelAction];
            UIWindow *window = [[UIApplication sharedApplication].delegate window];
            [window.rootViewController presentViewController:alert animated:YES completion:nil];
        }
    }];

}



@end
