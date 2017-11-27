//
//  STUUserDefaultControl.m
//  YooMath
//
//  Created by Elanking_MacMini on 15/11/10.
//  Copyright © 2015年 ZhangLei. All rights reserved.
//

#import "STUUserDefaultControl.h"

static STUUserDefaultControl *_STUUserDefaultControl = nil;

@implementation STUUserDefaultControl

+ (instancetype)shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _STUUserDefaultControl = [[STUUserDefaultControl alloc] init];
    });
    return _STUUserDefaultControl;
}

- (void)setUserToken:(NSString *)userToken
{
    [kUserDefaults setObject:userToken forKey:kUserToken];
    [kUserDefaults synchronize];
}

- (NSString *)userToken
{
    return [kUserDefaults stringForKey:kUserToken];
}


- (NSString *)cacheTencentAccessToken
{
    return [kUserDefaults stringForKey:@"cacheTencentAccessToken"];
}

- (void)setCacheTencentAccessToken:(NSString *)cacheTencentAccessToken
{
    [kUserDefaults setObject:cacheTencentAccessToken forKey:@"cacheTencentAccessToken"];
    [kUserDefaults synchronize];
}

- (NSString *)cacheTencentOpenID
{
    return [kUserDefaults stringForKey:@"cacheTencentOpenID"];
}

- (void)setCacheTencentOpenID:(NSString *)cacheTencentOpenID
{
    [kUserDefaults setObject:cacheTencentOpenID forKey:@"cacheTencentOpenID"];
    [kUserDefaults synchronize];
}

- (NSString *)cacheWXOpenID
{
    return [kUserDefaults stringForKey:@"cacheWXOpenID"];
}

- (void)setCacheWXOpenID:(NSString *)cacheWXOpenID
{
    [kUserDefaults setObject:cacheWXOpenID forKey:@"cacheWXOpenID"];
    [kUserDefaults synchronize];
}

- (NSString *)cacheWXAccessToken
{
    return [kUserDefaults stringForKey:@"cacheWXAccessToken"];
}

- (void)setCacheWXAccessToken:(NSString *)cacheWXAccessToken
{
    [kUserDefaults setObject:cacheWXAccessToken forKey:@"cacheWXAccessToken"];
    [kUserDefaults synchronize];
}

- (void)setCacheLastImgCacheDate:(NSDate *)cacheLastImgCacheDate
{
    if (!cacheLastImgCacheDate)
    {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"cacheLastImgCacheDateString"];
    }
    else
    {
        NSData *cacheImgCacheDateData = [NSKeyedArchiver archivedDataWithRootObject:cacheLastImgCacheDate];
        if (cacheImgCacheDateData)
        {
            [[NSUserDefaults standardUserDefaults] setObject:cacheImgCacheDateData forKey:@"cacheLastImgCacheDateString"];
        }
    }
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSDate *)cacheLastImgCacheDate
{
    NSData *cacheImgCacheDateData = [[NSUserDefaults standardUserDefaults] objectForKey:@"cacheLastImgCacheDateString"];
    if (cacheImgCacheDateData)
    {
        NSDate *cacheImgCacheDate = [NSKeyedUnarchiver unarchiveObjectWithData:cacheImgCacheDateData];
        if (cacheImgCacheDate && [cacheImgCacheDate isKindOfClass:[NSDate class]])
        {
            return cacheImgCacheDate;
        }
    }
    return nil;
}

@end
