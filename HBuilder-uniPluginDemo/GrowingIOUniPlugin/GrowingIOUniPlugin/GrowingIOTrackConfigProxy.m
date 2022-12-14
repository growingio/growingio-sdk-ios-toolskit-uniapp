//
//  GrowingIOTrackConfigProxy.m
//  GrowingIOUniplugin
//
//  Created by cpacm on 2021/3/12.
//

#import <Foundation/Foundation.h>
#import "GrowingIOTrackConfigProxy.h"
#import <GrowingCoreKit/GrowingCoreKit.h>

@implementation GrowingIOTrackConfigProxy

- (void)onCreateUniPlugin {
    NSLog(@"UniPluginProtocol Func: %@,%s",self,__func__);
}

- (BOOL)application:(UIApplication *_Nullable)application didFinishLaunchingWithOptions:(NSDictionary *_Nullable)launchOptions {
        NSDictionary *plistDic = [[NSBundle mainBundle] infoDictionary];
    
        NSString *delayInit = [plistDic objectForKey:@"growing_ios_delay_init"];
        if (delayInit.length && [delayInit isEqualToString:@"YES"]) {
            return YES;
        }
    
        NSString *readClipBoard = [plistDic objectForKey:@"growing_ios_read_clip_board_enable"];
        if (readClipBoard.length) {
            [Growing setReadClipBoardEnable:[readClipBoard isEqualToString:@"YES"]];
        }

        NSString *isDebug = [plistDic objectForKey:@"growing_ios_debug"];
        if (isDebug.length) {
            [Growing setEnableLog:[isDebug isEqualToString:@"YES"]];
        }

        NSString *zone = [plistDic objectForKey:@"growing_zone"];
        if (zone.length) {
            [Growing setZone:zone];
        }

        NSString *gtaHost = [plistDic objectForKey:@"growing_gta_host"];
        if (gtaHost.length) {
            [Growing setGtaHost:gtaHost];
        }

        NSString *dataHost = [plistDic objectForKey:@"growing_data_host"];
        if (dataHost.length) {
            [Growing setDataHost:dataHost];
        }

        NSString *reportHost = [plistDic objectForKey:@"growing_report_host"];
        if (reportHost.length) {
            [Growing setReportHost:reportHost];
        }

        NSString *wsHost = [plistDic objectForKey:@"growing_ws_host"];
        if (wsHost.length) {
            [Growing setWsHost:wsHost];
        }

        NSString *trackerHost = [plistDic objectForKey:@"growing_tracker_host"];
        if (trackerHost.length) {
            [Growing setTrackerHost:trackerHost];
        }

        NSString *accountId = [plistDic objectForKey:@"growing_ios_account_id"];
        if (accountId.length) {
            [Growing startWithAccountId:accountId];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [Growing track:@"afeter"];
            });
        } else {
            NSLog(@"GrowingIO????????????:accountId????????????");
        }

        return YES;
}

- (void)applicationWillResignActive:(UIApplication * _Nullable)application {
    NSLog(@"UniPluginProtocol Func: %@,%s",self,__func__);
}

- (void)applicationDidBecomeActive:(UIApplication *_Nullable)application {
    NSLog(@"UniPluginProtocol Func: %@,%s",self,__func__);
}

- (void)applicationDidEnterBackground:(UIApplication *_Nullable)application {
    NSLog(@"UniPluginProtocol Func: %@,%s",self,__func__);
}

- (void)applicationWillEnterForeground:(UIApplication *_Nullable)application {
    NSLog(@"UniPluginProtocol Func: %@,%s",self,__func__);
}

- (void)applicationWillTerminate:(UIApplication *_Nullable)application {
    NSLog(@"UniPluginProtocol Func: %@,%s",self,__func__);
}


- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options{
    if ([Growing handleUrl:url]) {
        return YES;
    }
    return NO;
}


@end
