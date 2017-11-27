//
//  BaseDataModel.m
//  ProjectFramework
//
//  Created by ElanKing on 2017/11/27.
//  Copyright © 2017年 ElanKing. All rights reserved.
//

#import "BaseDataModel.h"

@implementation BaseDataModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    NSArray *properties = [self serializeProperties];
    for (NSString *propertyName in properties) {
        if ([self respondsToSelector:NSSelectorFromString(propertyName)]) {
            id value = [self valueForKey:propertyName];
            if (value) {
                    //兼容short, ushort, char, uchar, int, uint, long, ulong, long long, unsinged long long, enum, NSInteger, Class
                    //float, double 等基础类型属性
                [aCoder encodeObject:value forKey:propertyName];
            }
        } else {
            NSLog(@"encodeWithCoder error %@", propertyName);
        }
    }
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        if (aDecoder) {
            NSArray *properties = [self serializeProperties];
            for (NSString *propertyName in properties) {
                if ([self respondsToSelector:NSSelectorFromString(propertyName)]) {
                        //兼容short, ushort, char, uchar, int, uint, long, ulong, long long, unsinged long long, enum, NSInteger, Class
                        //float, double 等基础类型属性
                    id value = [aDecoder decodeObjectForKey:propertyName];
                    if (value) {
                        [self setValue:value forKey:propertyName];
                    }
                } else {
                    NSLog(@"initWithCoder error %@", propertyName);
                }
            }
        }
    }
    return self;
}

- (NSArray *)serializeProperties {
    return nil;
}

@end
