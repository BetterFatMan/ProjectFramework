//
//  CommonContants.h
//  ProjectFramework
//
//  Created by ElanKing on 2017/11/24.
//  Copyright © 2017年 ElanKing. All rights reserved.
//

#ifndef CommonContants_h
#define CommonContants_h



/*---------------------------------用户相关信息-------------------------------------*/
#define kUserToken                  (@"kUserLoginToken")

/* 上传录音所用的key */
static NSString * const     kYMRecordFileSecretKey = @"kYMUploadRecordFileSecretKeyToken";

#define kUserLoginNameStr           (@"kUserLoginNameStr")//用户名
#define kUserLoginImageUrl          (@"kUserLoginImageUrl")//头像

#define kUserLoginTypeIsSuccess     (@"kUserLoginTypeIsSuccess")

#define kTUserPhaseName             (@"kTUserPhaseName")// 教学阶段－高中／初中
#define kTTBCateName                (@"kTTBCateName")// 教材版本－苏教版


/**
 关于h5页面
 */
static NSString * const kYMAboutPageUrlString   = @"kYMAboutPageUrlString";
/**
 金币获得详情列表h5页面
 */
static NSString * const kYMCoinsPageUrlString   = @"kYMCoinsPageUrlString";
/**
 金币获得更多h5页面
 */
static NSString * const kYMCatchMoreCoinsUrlString  = @"kYMCatchMoreCoinsUrlString";
/**
 成长值获得详情列表h5页面
 */
static NSString * const kYMGrowthPageUrlString  = @"kYMGrowthPageUrlString";
/**
 会员介绍h5页面url
 */
static NSString * const kYMVipPageUrlString     = @"kYMVipPageUrlString";

/**
 会员了解更多的url
 */
static NSString * const kYMVipLearnMoreUrlString    = @"kYMVipLearnMoreUrlString";

/**
 app获取升级信息唯一标识
 */
static NSString * const kYMAppUpgradeDeviceIdString = @"kYMAppUpgradeDeviceIdString";

#endif /* CommonContants_h */
