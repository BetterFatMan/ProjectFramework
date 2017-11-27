//
//  ThirdMacros.h
//  ProjectFramework
//
//  Created by ElanKing on 2017/11/24.
//  Copyright © 2017年 ElanKing. All rights reserved.
//

#ifndef ThirdMacros_h
#define ThirdMacros_h

/*----------------------------------社区帐号------------------------------------*/
    /// 微信帐号ID
#define kWXAppID                    @"wx994dc22fb0b754fa"
#define kWXAppSecret                @"b8362c9650af16083b4ef1e1b81ac2d1"

    /// 新浪微博
#define kSinaWeiboAppKey            @"3622719705"
    /// 企业包时用到的新浪微博key
#define kSinaWeiboAppKeyEnterprise  @"416885450"
    //#define kSinaWeiboAppSecret         @"750b8b81b9b32ae49e964531e275c963"
#define kSinaWeiboRedicrctURI       @"http://www.line0.com"

    /// QQ
#define kTencentAppID               @"101261664"
#define kTencentAppKey              @"e8cffa43dde8da402d8dfd64514f9517"

    /// 信鸽push的注册信息
#define kXGACCESSID                 (2200215072)
#define kXGACCESSKEY                (@"IDHR46J1F24C")
#define kXGSECRETKEY                (@"f030d8b2a30f8d041e7228bdfe230481")

#define kXGDeviceType               (@"IOS")

/*-------------------------------程序数据库路径----------------------------------*/
#define kDocuments                  [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]
#define kYooMathDBPath              [NSString stringWithFormat:@"%@/%@", kDocuments, @"YooMath.db"]


#endif /* ThirdMacros_h */
