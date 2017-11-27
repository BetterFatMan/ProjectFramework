//
//  ProjectBaseModel.m
//  ProjectFramework
//
//  Created by ElanKing on 2017/11/27.
//  Copyright © 2017年 ElanKing. All rights reserved.
//

#import "ProjectBaseModel.h"

@implementation ProjectBaseModel

- (instancetype)initWithDict:(NSDictionary *)dict {
    if ([dict isKindOfClass:[NSNull class]] || ![dict isKindOfClass:[NSDictionary class]] || ![dict count]) {
        return nil;
    }
    
    self = [super init];
    if (self) {
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

@end
