//
//  SystemControl.m
//  YooMath
//
//  Created by Elanking_MacMini on 15/11/11.
//  Copyright © 2015年 ZhangLei. All rights reserved.
//

#import "SystemControl.h"
#import "STUUserDefaultControl.h"
#import "LoginControl.h"
//#import "STUDataBaseControl.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation SystemControl

    //app启动
+ (void)preAppLoad
{
    /// 设置注册时间的初始值
//    [kUserDefaults setDouble:0.0 forKey:kUserRegisterTime];
//    [kUserDefaults synchronize];
    
    dispatch_main_sync_safe(^{
        [[self class] checkIsNeedClearLocalCacheImg];
    });
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        /// 创建数据库的表
//        [[STUDataBaseControl shareInstance] createDatabase];
    });
}

+ (void)afterAppLoad
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
//        [LoginControl shareInstance].shareBox = [SNSShareBox new];
    });

}

+ (void)appWillEnterForeground
{
    
}

/// 检查是否需要清楚缓存了的图片缓存
+ (void)checkIsNeedClearLocalCacheImg
{
    //检查SDWebImg缓存的图片是否超过七天
    if ([[NSDate date] timeIntervalSince1970] - [[STUUserDefaultControl shareInstance].cacheLastImgCacheDate timeIntervalSince1970] > 7 * 24 * 60 * 60) {
        
        NSLog(@"清楚缓存了的图片缓存");
        [[SDImageCache sharedImageCache] clearMemory];
        [[SDImageCache sharedImageCache] clearDisk];
        [STUUserDefaultControl shareInstance].cacheLastImgCacheDate = [NSDate date];
    }
}

@end
