//
//  NSBundle+GrowingTK.m
//  GrowingToolsKit
//
//  Created by YoloMao on 2021/8/11.
//  Copyright (C) 2021 Beijing Yishu Technology Co., Ltd.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.

#import "NSBundle+GrowingTK.h"

@implementation NSBundle (GrowingTK)

+ (NSBundle *)growingtk_currentBundle:(Class)aClass {
    return [NSBundle bundleForClass:aClass];
}

+ (NSBundle *)growingtk_resourcesBundle:(Class)aClass bundleName:(nullable NSString *)bundleName {
#if SWIFT_PACKAGE
    return SWIFTPM_MODULE_BUNDLE;
#else
    // 这里的额外步骤是为了兼容静态集成和动态集成
    NSBundle *bundle = [NSBundle growingtk_currentBundle:aClass];
    if (!bundleName) {
        bundleName = bundle.infoDictionary[@"CFBundleName"];
    }
    NSString *path =
        [bundle.resourcePath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.bundle", bundleName]];
    return [NSBundle bundleWithPath:path];
#endif
}

+ (NSBundle *)growingtk_localizedBundleWithFileName:(NSString *)fileName resourcesBundle:(NSBundle *)bundle {
    NSString *path = [bundle pathForResource:fileName ofType:@"lproj"];
    return [NSBundle bundleWithPath:path];
}

@end
