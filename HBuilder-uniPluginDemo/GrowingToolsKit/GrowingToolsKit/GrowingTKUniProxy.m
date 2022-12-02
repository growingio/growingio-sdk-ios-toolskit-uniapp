//
//  GrowingTKUniProxy.m
//  GrowingToolsKit
//
//  Created by YoloMao on 2022/11/30.
//

#import "GrowingTKUniProxy.h"
#import "GrowingToolsKit.h"

@implementation GrowingTKUniProxy

- (void)onCreateUniPlugin {
    NSLog(@"UniPluginProtocol Func: %@,%s", self, __func__);
}

- (BOOL)application:(UIApplication *_Nullable)application didFinishLaunchingWithOptions:(NSDictionary *_Nullable)launchOptions {
    NSDictionary *plistDic = [[NSBundle mainBundle] infoDictionary];
    NSString *delayInit = [plistDic objectForKey:@"growing_ios_giokit_delay_init"];
    if (delayInit.length && [delayInit isEqualToString:@"YES"]) {
        return YES;
    }
    [GrowingToolsKit start];
    return YES;
}

@end
