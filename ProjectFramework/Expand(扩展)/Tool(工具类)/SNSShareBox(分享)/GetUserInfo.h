//
//  GetUserInfo.h
//  Line0new
//
//  Created by user on 14-8-29.
//  Copyright (c) 2014年 com.line0. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SNSShareBox.h"
@interface GetUserInfo : NSObject

+ (NSDictionary *)sendRequest:(NSURL *)url completeBlock:(void (^)(NSDictionary *resultDict))completeBlock;

+ (void)userInfo:(NSString *)urlString andType:(NSString *)otherType completeBlock:(void (^)(NSMutableArray *arr))completeBlock;

+ (NSDictionary *)sendQQRequest:(NSDictionary *)params completeBlock:(void (^)(NSDictionary *resultDict))completeBlock;

+ (void)sendUserInfoGetBindThings:(NSDictionary *)params completeBlock:(void (^)(NSDictionary *resultDict))block;

@end
