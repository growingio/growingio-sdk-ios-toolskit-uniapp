//
//  GrowingIOTrackModule.m
//  GrowingIOUniplugin
//
//  Created by cpacm on 2021/3/18.
//

#import <Foundation/Foundation.h>
#import "GrowingIOTrackModule.h"
#import <GrowingCoreKit/GrowingCoreKit.h>

@implementation GrowingIOTrackModule

// 通过宏 UNI_EXPORT_METHOD 将异步方法暴露给 js 端
UNI_EXPORT_METHOD(@selector(track:))
UNI_EXPORT_METHOD(@selector(setEvar:))
UNI_EXPORT_METHOD(@selector(setPeopleVariable:))
UNI_EXPORT_METHOD(@selector(setUserId:))
UNI_EXPORT_METHOD(@selector(clearUserId))
UNI_EXPORT_METHOD(@selector(setVisitor:))
UNI_EXPORT_METHOD(@selector(printLog:))
UNI_EXPORT_METHOD(@selector(enableDataCollect))
UNI_EXPORT_METHOD(@selector(disableDataCollect))
UNI_EXPORT_METHOD(@selector(startWithAccountId:withConfiguration:))

NS_INLINE NSString *GROWGetTimestampFromTimeInterval(NSTimeInterval timeInterval) {
    return [NSNumber numberWithUnsignedLongLong:timeInterval * 1000.0].stringValue;
}

NS_INLINE NSString *GROWGetTimestamp() {
    return GROWGetTimestampFromTimeInterval([[NSDate date] timeIntervalSince1970]);
}

static NSString *pageName;

- (void)printLog:(NSString *)log
{
    NSLog(@"%@", log);
}

- (void)track:(NSDictionary *)event
{
    if (![event isKindOfClass:[NSDictionary class]]) {
        NSLog(@"Method(track) Argument error, The Argument event must be object type");
        return;
    }
    
    if (event.count == 0) {
        NSLog(@"Method(track) Argument error, The Argument event can not be empty");
        return;
    }
    
    NSString *eventId = event[@"eventId"];
    
    if (![eventId isKindOfClass:[NSString class]]) {
        NSLog(@"Method(track) Argument error, The eventId value must be string type");
        return;
    }
    
    if (eventId.length == 0) {
        NSLog(@"Method(track) Argument error, The eventId value can not be empty");
        return;
    }
    
    NSDictionary *eventLevelVariable = event[@"eventLevelVariable"];
    NSNumber *number = event[@"number"];
    
    if (!eventLevelVariable && !number) {
        [self dispatchInMainThread:^{
            [Growing track:eventId];
        }];
        
    } else if (eventLevelVariable && number) {
        if (![eventLevelVariable isKindOfClass:[NSDictionary class]]) {
            NSLog(@"Method(track) Argument error, The eventLevelVariable value must be object type");
            return;
        }
        if (![number isKindOfClass:[NSNumber class]]) {
            NSLog(@"Method(track) Argument error, The number value must be number type");
            return;
        }
        [self dispatchInMainThread:^{
            [Growing track:eventId withNumber:number andVariable:eventLevelVariable];
        }];
        
    } else if (eventLevelVariable) {
        if (![eventLevelVariable isKindOfClass:[NSDictionary class]]) {
            NSLog(@"Method(track) Argument error, The eventLevelVariable value must be object type");
            return;
        }
        [self dispatchInMainThread:^{
            [Growing track:eventId withVariable:eventLevelVariable];
        }];
    } else if (number) {
        if (![number isKindOfClass:[NSNumber class]]) {
            NSLog(@"Method(track) Argument error, The number value must be number type");
            return;
        }
        [self dispatchInMainThread:^{
            [Growing track:eventId withNumber:number];
        }];
    }
}

- (void)setEvar:(NSDictionary *)conversionVariables
{
    if (![conversionVariables isKindOfClass:[NSDictionary class]]) {
        NSLog(@"Method(setEvar) Argument error, The Argument conversionVariables must be object type");
        return;
    }
    
    if (conversionVariables.count == 0) {
        NSLog(@"Method(setEvar) Argument error, The Argument conversionVariables can not be empty");
        return;
    }
    
    [self dispatchInMainThread:^{
        [Growing setEvar:conversionVariables];
    }];
}

- (void)setVisitor:(NSDictionary *)visitorVariables
{
    if (![visitorVariables isKindOfClass:[NSDictionary class]]) {
        NSLog(@"Method(setVisitor) Argument error, The Argument visitorVariables must be object type");
        return;
    }
    
    if (visitorVariables.count == 0) {
        NSLog(@"Method(setVisitor) Argument error, The Argument visitorVariables can not be empty");
        return;
    }
    
    [self dispatchInMainThread:^{
        [Growing setVisitor:visitorVariables];
    }];
}


- (void)setPeopleVariable:(NSDictionary *)peopleVariables
{
    if (![peopleVariables isKindOfClass:[NSDictionary class]]) {
        NSLog(@"Method(setPeopleVariable) Argument error, The Argument peopleVariables must be object type");
        return;
    }
    
    if (peopleVariables.count == 0) {
        NSLog(@"Method(setPeopleVariable) Argument error, The Argument peopleVariables can not be empty");
        return;
    }
    
    [self dispatchInMainThread:^{
        [Growing setPeopleVariable:peopleVariables];
    }];
}

- (void)setUserId:(NSString *)userId
{
    if (![userId isKindOfClass:[NSString class]] && ![userId isKindOfClass:[NSNumber class]]) {
        NSLog(@"Method(setUserId) Argument error, The Argument userId must be string type");
        return;
    }
    
    if ([userId isKindOfClass:[NSNumber class]]) {
        userId = ((NSNumber *)userId).stringValue;
    }
    
    if (userId.length == 0 || userId.length > 1000) {
        NSLog(@"Method(setUserId) Argument error, The Argument userId length can not > 1000 or = 0");
        return;
    }
    
    [self dispatchInMainThread:^{
        [Growing setUserId:userId];
    }];
}

- (void)clearUserId
{
    [self dispatchInMainThread:^{
        [Growing clearUserId];
    }];
}


- (void)dispatchInMainThread:(void (^)(void))block
{
    if ([NSThread isMainThread]) {
        block();
    } else {
        dispatch_async(dispatch_get_main_queue(), block);
    }
}

- (void)enableDataCollect {
    [self dispatchInMainThread:^{
        [Growing enableDataCollect];
    }];
}

- (void)disableDataCollect {
    [self dispatchInMainThread:^{
        [Growing disableDataCollect];
    }];
}


#define ENABLE_LOG @"enableLog"
#define ENABLE_REAND_CLIP_BOARD @"enableReadClipBoard"
- (void)startWithAccountId:(NSString *)accountId withConfiguration:(NSDictionary *) params {
    [self dispatchInMainThread:^{
        if (params && params[ENABLE_LOG]) {
            [Growing setEnableLog:[params[ENABLE_LOG] boolValue]];
        }
        if (params && params[ENABLE_REAND_CLIP_BOARD]) {
            [Growing setReadClipBoardEnable:[params[ENABLE_REAND_CLIP_BOARD] boolValue]];
        }
        [Growing startWithAccountId:accountId];
    }];
}
    

@end

