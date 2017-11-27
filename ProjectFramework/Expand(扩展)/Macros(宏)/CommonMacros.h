//
//  CommonMacros.h
//  ProjectFramework
//
//  Created by ElanKing on 2017/11/24.
//  Copyright © 2017年 ElanKing. All rights reserved.
//

#ifndef CommonMacros_h
#define CommonMacros_h

/*------------------------------方法简写-------------------------------*/
#define kAppDelegate                        (AppDelegate *)[[UIApplication sharedApplication] delegate]
#define kKeyWindow                          [[UIApplication sharedApplication] keyWindow]
#define kUserDefaults                       [NSUserDefaults standardUserDefaults]
#define kNotificationCenter                 [NSNotificationCenter defaultCenter]

/*---------------------------------程序相关常数-------------------------------------*/
    //App Id、下载地址、评价地址
#define kAppId                      (@"1107835889")
#define kAppUrl                     [NSString stringWithFormat:@"https://itunes.apple.com/cn/app/you-shu-xue/id%@?mt=8",kAppId]

#define kStudentAppId                (@"1058780031")
#define kStudentAppUrl               [NSString stringWithFormat:@"https://itunes.apple.com/cn/app/you-shu-xue/id%@?mt=8",kStudentAppId]

#define kRateUrl                    [NSString stringWithFormat:@"http://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?id=%@&pageNumber=0&sortOrdering=2&type=Purple+Software&mt=8",kAppId]


/* ----------------------------判断手机的尺寸-------------------------- */
#define kIsIphone5              (((int)[UIScreen mainScreen].bounds.size.height % 568) == 0)

    //判断iphone6
#define kIsIPhone6              ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)

    //判断iphone6+
#define kIsIPhone6Plus          ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(1125, 2001), [[UIScreen mainScreen] currentMode].size) || CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size)) : NO)

#define kDevice_Is_iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)]?CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)


/*---------------------------页面设计相关-----------------------*/

#define kNavBarHeight           44
#define kTabBarHeight           (kDevice_Is_iPhoneX?83:49)
#define kScreenWidth            ([UIScreen mainScreen].bounds.size.width)
#define kScreenHeight           ([UIScreen mainScreen].bounds.size.height)

#define kStatusBarHeight        (CGRectGetHeight([[UIApplication sharedApplication] statusBarFrame]))
#define kNaviViewMargeHeight    (kStatusBarHeight + kNavBarHeight)
#define kViewBottomAreaHeight   (kDevice_Is_iPhoneX?34:0)

    // 屏幕适配
#define kRealValue(rawValue)    floor((rawValue)*(kScreenWidth/375.0f))

/*----------------------------设备系统相关----------------------*/
#define kIsPad                  (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define kIsiPhone               (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)

#define kSystemVersion          ([[UIDevice currentDevice] systemVersion])
#define kCurrentLanguage        ([[NSLocale preferredLanguages] objectAtIndexSafe:0])
#define kAPPVersion             [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]


/*--------------------调试模式下输入NSLog，发布后不再输入-----------------*/
#ifndef __OPTIMIZE__
#define NSLog(...) NSLog(__VA_ARGS__)
#else
#define NSLog(...) {}
#endif

#endif /* CommonMacros_h */
