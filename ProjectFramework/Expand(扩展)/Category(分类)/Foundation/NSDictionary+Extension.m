//
//  NSDictionary+Extension.m
//  YMTeacher
//
//  Created by Elanking_MacMini on 16/4/7.
//  Copyright © 2016年 ZhangLei. All rights reserved.
//

#import "NSDictionary+Extension.h"

@implementation NSObject (entity)

- (id)safeBindValue:(NSString *)key
{
    NSLog(@"错误对象调用 safeBindValue 调用路径 %@", [NSThread callStackSymbols]);
    return nil;
}

- (NSString *)safeBindStringValue:(NSString *)key
{
    NSLog(@"错误对象调用 safeBindStringValue 调用路径 %@", [NSThread callStackSymbols]);
    return nil;
}


@end


@implementation NSDictionary (Extension)

- (id)safeBindValue:(NSString *)key {
    id result = nil;
    if ([self.allKeys containsObject:key]) {
        result = [self objectForKey:key];
        result = [result isKindOfClass:[NSNull class]] ? nil : result;
    }
    return result;
}

- (NSString *)safeBindStringValue:(NSString *)key {
    id result = [self safeBindValue:key];
    if (result) {
        return [NSString stringWithFormat:@"%@", result];
    }
    return nil;
}

@end
