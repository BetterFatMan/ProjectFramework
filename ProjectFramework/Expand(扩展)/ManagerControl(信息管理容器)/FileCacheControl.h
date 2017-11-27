//
//  FileCacheControl.h
//  Line0new
//
//  Created by trojan on 14-8-21.
//  Copyright (c) 2014年 com.line0. All rights reserved.
//  当前类是文件类型缓存的控制类, 所有文件型缓存的统一管理器, 当前类为单例模式(注意不是"伪单例")

#import <Foundation/Foundation.h>
//#import "STUPhaseEntity.h"
//#import "UserEntity.h"
//
//@class YMActivityEntity, YMEntranceModel;
@interface FileCacheControl : NSObject

+ (instancetype)shareInstance;
    /// 设置文件缓存的namespace, 所有文件缓存都将在此namespace目录下  注意程序运行中这里只允许被修改一次
+ (void)fileCacheNameSpace:(NSString *)ns;
    /// 清除所有文件缓存
+ (void)cleanFileCache;


    /// 注意 这里的所有属性最好全部以 cacheXxx方式(即开头包含"cache")

    ///读取与写入闪屏
//@property(nonatomic, strong) STUTBCateEntity    *cacheCateEntity;
//
//@property(nonatomic, strong) UserEntity         *cacheUserEntity;
//
//    // 首页活动对象
//@property(nonatomic, strong) YMActivityEntity   *cacheActivityEntity;
//
//    /* 启动页介绍图片缓存对象 */
//@property(nonatomic, strong) YMEntranceModel    *cachePreloadingImageModel;
//    ///----------------
//
//@property(nonatomic, strong) NSArray            *cacheWaitIssueHomeworkIdList;
//
///**
// 客户端的url管理列表
// */
//@property(nonatomic, strong) NSDictionary       *cacheUserCenterUrlInfo;

#pragma mark 读取与写入缓存的方法

    ///读取与写入用户头像
//- (void)setCacheUserHeadImage:(NSString *)userToken headImage:(UIImage *)userHeadImage;
//- (UIImage *)cacheUserHeadImage:(NSString *)userToken;


@end

/*
 userAPIMethodResultList.cache
 line0ViewAppear.txt
 searchShopKeyWordsHistory.cache
 */
