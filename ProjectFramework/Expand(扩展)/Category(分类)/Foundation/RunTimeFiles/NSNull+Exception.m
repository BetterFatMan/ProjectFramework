//
//  NSNull+Exception.m
//  TestDemo
//
//  Created by Bruce on 16/12/27.
//  Copyright © 2016年 Bruce. All rights reserved.
//

#import "NSNull+Exception.h"
#import "NSObject+Swizzling.h"
#import <objc/runtime.h>

@implementation NSNull (Exception)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        @autoreleasepool {
            [objc_getClass("NSNull") swizzleMethod:@selector(length) swizzledSelector:@selector(replace_length)];
            [objc_getClass("NSNull") swizzleMethod:@selector(methodSignatureForSelector:) swizzledSelector:@selector(YF_methodSignatureForSelector:)];
            [objc_getClass("NSNull") swizzleMethod:@selector(forwardInvocation:) swizzledSelector:@selector(YF_forwardInvocation:)];
        }
    });
}

- (NSInteger)replace_length {
    return 0;
}

- (id)fetchedObjects
{
    return nil;
}

- (NSMethodSignature *)YF_methodSignatureForSelector:(SEL)aSelector {
    NSMethodSignature *sig = [self YF_methodSignatureForSelector:aSelector];
    if (sig) {
        return sig;
    }
    return [NSMethodSignature signatureWithObjCTypes:@encode(void)];
}

- (void)YF_forwardInvocation:(NSInvocation *)anInvocation {
    NSUInteger returnLength = [[anInvocation methodSignature] methodReturnLength];
    if (!returnLength) {
            // nothing to do
        return;
    }
    
        // set return value to all zero bits
    char buffer[returnLength];
    memset(buffer, 0, returnLength);
    
    [anInvocation setReturnValue:buffer];
}

@end
