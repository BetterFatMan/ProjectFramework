//
//  STUUserDefaultControl.h
//  YooMath
//
//  Created by Elanking_MacMini on 15/11/10.
//  Copyright © 2015年 ZhangLei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface STUUserDefaultControl : NSObject

+ (instancetype)shareInstance;

@property(nonatomic, strong) NSString   *userToken;

@property(nonatomic, strong) NSDate     *cacheLastImgCacheDate;

@property(nonatomic, strong) NSString   *cacheTencentAccessToken;
@property(nonatomic, strong) NSString   *cacheTencentOpenID;

@property(nonatomic, strong) NSString   *cacheWXAccessToken;
@property(nonatomic, strong) NSString   *cacheWXOpenID;

@end
