#import "AppDelegate.h"
#import "GeneratedPluginRegistrant.h"
#import "SCFlutterNativePlugin.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [GeneratedPluginRegistrant registerWithRegistry:self];
    
    [SCFlutterNativePlugin registerWithRegistrar:[self registrarForPlugin:@"FlutterNativePlugin"]];
    

    // Override point for customization after application launch.
    return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

@end
