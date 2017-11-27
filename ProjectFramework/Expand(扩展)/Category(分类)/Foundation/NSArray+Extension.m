//
//  NSArray+Extension.m
//  YMTeacher
//
//  Created by Elanking_MacMini on 16/4/7.
//  Copyright © 2016年 ZhangLei. All rights reserved.
//

#import "NSArray+Extension.h"

@implementation NSArray (Extension)

- (id)objectAtIndexSafe:(NSUInteger)index {
    if ([self count] > index) {
        return [self objectAtIndex:index];
    }
    return nil;
}

@end
