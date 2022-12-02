//  The MIT License (MIT)
//
//  Copyright (c) 2007-2011 Jonathan 'Wolf' Rentzsch
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//
//  https://github.com/rentzsch/jrswizzle
//
//  NSObject+GrowingTKSwizzle.h
//  GrowingToolsKit
//
//  Created by YoloMao on 2021/9/1.
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

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (GrowingTKSwizzle)

+ (BOOL)growingtk_swizzleMethod:(SEL)origSel_ withMethod:(SEL)altSel_ error:(NSError **)error_;
+ (BOOL)growingtk_swizzleClassMethod:(SEL)origSel_ withClassMethod:(SEL)altSel_ error:(NSError **)error_;

/**
 ```
 __block NSInvocation *invocation = nil;
 invocation = [self growingtk_swizzleMethod:@selector(initWithCoder:) withBlock:^(id obj, NSCoder *coder) {
 NSLog(@"before %@, coder %@", obj, coder);
 [invocation setArgument:&coder atIndex:2];
 [invocation invokeWithTarget:obj];
 id ret = nil;
 [invocation getReturnValue:&ret];
 NSLog(@"after %@, coder %@", obj, coder);
 return ret;
 } error:nil];
 ```
 */
+ (nullable NSInvocation *)growingtk_swizzleMethod:(SEL)origSel withBlock:(id)block error:(NSError **)error;

/**
 ```
 __block NSInvocation *classInvocation = nil;
 classInvocation = [self growingtk_swizzleClassMethod:@selector(test) withBlock:^() {
 NSLog(@"before");
 [classInvocation invoke];
 NSLog(@"after");
 } error:nil];
 ```
 */
+ (nullable NSInvocation *)growingtk_swizzleClassMethod:(SEL)origSel withBlock:(id)block error:(NSError **)error;

@end

NS_ASSUME_NONNULL_END
