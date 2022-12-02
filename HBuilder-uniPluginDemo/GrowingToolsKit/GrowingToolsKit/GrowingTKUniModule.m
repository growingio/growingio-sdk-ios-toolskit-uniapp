//
//  GrowingTKUniModule.m
//  GrowingToolsKit
//
//  Created by YoloMao on 2022/11/30.
//

#import "GrowingTKUniModule.h"
#import "GrowingToolsKit.h"

@implementation GrowingTKUniModule

UNI_EXPORT_METHOD(@selector(start))
UNI_EXPORT_METHOD(@selector(startWithPosition:autoDock:))
UNI_EXPORT_METHOD_SYNC(@selector(version))

- (void)start {
    [GrowingToolsKit start];
}

- (void)startWithPosition:(NSDictionary *)position autoDock:(BOOL)autoDock {
    if (!position[@"x"]
        || !position[@"y"]
        || ![position[@"x"] isKindOfClass:[NSNumber class]]
        || ![position[@"y"] isKindOfClass:[NSNumber class]]) {
        [GrowingToolsKit start];
        return;
    }
    float x = ((NSNumber *)position[@"x"]).floatValue;
    float y = ((NSNumber *)position[@"y"]).floatValue;
    [GrowingToolsKit startWithPosition:CGPointMake(x, y) autoDock:autoDock];
}

- (NSString *)version {
    NSString *version = [GrowingToolsKit version];
    return version;
}

@end
