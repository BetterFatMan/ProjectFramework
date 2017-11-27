//
//  AppDelegate+UserNotification.m
//  ProjectFramework
//
//  Created by ElanKing on 2017/11/27.
//  Copyright © 2017年 ElanKing. All rights reserved.
//

#import "AppDelegate+UserNotification.h"

#import <UserNotifications/UserNotifications.h>
#import "XGPush.h"
#import "LoginControl.h"

@implementation AppDelegate (UserNotification)

- (void)registerXGPlartformInfomationWithOptions:(NSDictionary *)launchOptions
{
    [XGPush startApp:kXGACCESSID appKey:kXGACCESSKEY];
    
        //如果变成需要注册状态
    if([XGPush isUnRegisterStatus])
        {
            //iOS8注册push方法
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= _IPHONE80_
        
        float sysVer = [[[UIDevice currentDevice] systemVersion] floatValue];
        if(sysVer < 8){
            [self registerPush];
        }
        else{
            if (sysVer > 10.0) {
                [self registerPushForIOS10];
            } else {
                [self registerPushForIOS8];
            }
        }
#else
            //iOS8之前注册push方法
            //注册Push服务，注册后才能收到推送
        [self registerPush];
#endif
        }
    [XGPush handleLaunching:launchOptions successCallback:nil errorCallback:nil];
    
    
    if (launchOptions && [launchOptions count]>0) {
            //当推送进入时  取消所有通知
        NSDictionary *noDic = [launchOptions objectForKey:@"UIApplicationLaunchOptionsRemoteNotificationKey"];
        NSString   *schemeString = [noDic objectForKey:@"url"];
//        [self.viewController pushVCWithXGInfo:schemeString];
    }
    
        //角标清0
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
        //清除所有通知(包含本地通知)
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    
        //    [[UIApplication sharedApplication] unregisterForRemoteNotifications];
    
        //    [self.viewController clearXGPushMsgList:nil];
}

#pragma mark - 信鸽平台的注册方法
- (void)registerPushForIOS8
{
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= _IPHONE80_
    
        //Types
    UIUserNotificationType types = UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert;
    
        //Actions
    UIMutableUserNotificationAction *acceptAction = [[UIMutableUserNotificationAction alloc] init];
    
    acceptAction.identifier = @"ACCEPT_IDENTIFIER";
    acceptAction.title = @"Accept";
    
    acceptAction.activationMode = UIUserNotificationActivationModeForeground;
    acceptAction.destructive = NO;
    acceptAction.authenticationRequired = NO;
    
        //Categories
    UIMutableUserNotificationCategory *inviteCategory = [[UIMutableUserNotificationCategory alloc] init];
    
    inviteCategory.identifier = @"INVITE_CATEGORY";
    
    [inviteCategory setActions:@[acceptAction] forContext:UIUserNotificationActionContextDefault];
    
    [inviteCategory setActions:@[acceptAction] forContext:UIUserNotificationActionContextMinimal];
    
    NSSet *categories = [NSSet setWithObjects:inviteCategory, nil];
    
    UIUserNotificationSettings *mySettings = [UIUserNotificationSettings settingsForTypes:types categories:categories];
    
    [[UIApplication sharedApplication] registerUserNotificationSettings:mySettings];
    
    
    [[UIApplication sharedApplication] registerForRemoteNotifications];
#endif
}

/* 10.0之后的系统，通知注册方式 */
- (void)registerPushForIOS10
{
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    center.delegate = self;
    [center requestAuthorizationWithOptions:(UNAuthorizationOptionBadge | UNAuthorizationOptionSound | UNAuthorizationOptionAlert | UNAuthorizationOptionCarPlay) completionHandler:^(BOOL granted, NSError *_Nullable error) {
        if (granted) {
            NSLog(@"request authorization succeeded!");
            
                //            UNMutableNotificationContent * content = [UNMutableNotificationContent new];
                //                //设置通知请求发送时 app图标上显示的数字
                //            content.badge = @2;
                //                //设置通知的内容
                //            content.body = @"这是iOS10的新通知内容：普通的iOS通知";
                //                //默认的通知提示音
                //            content.sound = [UNNotificationSound defaultSound];
                //                //设置通知的副标题
                //            content.subtitle = @"这里是副标题";
                //                //设置通知的标题
                //            content.title = @"这里是通知的标题";
                //                //设置从通知激活app时的launchImage图片
                //            content.launchImageName = @"app_share_logo";
                //                //设置5S之后执行
                //            UNTimeIntervalNotificationTrigger * trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:15 repeats:NO];
                //            UNNotificationRequest * request = [UNNotificationRequest requestWithIdentifier:@"NotificationDefault" content:content trigger:trigger];
                //                //添加通知请求
                //            [[UNUserNotificationCenter currentNotificationCenter] addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
                //
                //            }];
        } else {
            /* 通知被关闭了 */
            NSLog(@"通知被关闭了");
        }
    }];
    
    [[UIApplication sharedApplication] registerForRemoteNotifications];
#else // Xcode 7编译会调用
    
    [self registerPushForIOS8];
    
#endif
    
}

- (void)registerPush
{
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound)];
}

-(void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    CGFloat system = [[[UIDevice currentDevice] systemVersion] floatValue];
    if (system > 10.0) {
        
        [[UNUserNotificationCenter currentNotificationCenter] removeAllPendingNotificationRequests];
    } else {
        [[UIApplication sharedApplication] cancelLocalNotification:notification];
        
            //清空推送列表
        [[UIApplication sharedApplication] cancelAllLocalNotifications];
    }
}

#if __IPHONE_OS_VERSION_MAX_ALLOWED >= _IPHONE80_

    //注册UserNotification成功的回调
- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings
{
        //用户已经允许接收以下类型的推送
        //UIUserNotificationType allowedTypes = [notificationSettings types];
    
}

    //按钮点击事件回调
- (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forRemoteNotification:(NSDictionary *)userInfo completionHandler:(void (^)())completionHandler{
    if([identifier isEqualToString:@"ACCEPT_IDENTIFIER"]){
        NSLog(@"ACCEPT_IDENTIFIER is clicked");
    }
    
    completionHandler();
}

#endif

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    
    NSString * deviceTokenStr = [XGPush registerDevice:deviceToken successCallback:nil errorCallback:nil];
    
    [LoginControl shareInstance].XGDeviceToken = deviceTokenStr;
        //打印获取的deviceToken的字符串
    NSLog(@"[XGPush Demo] deviceTokenStr is %@",deviceTokenStr);
    
    NSString *userToken = [kUserDefaults stringForKey:kUserToken];
    if (userToken.length) {
//        [kNotificationCenter postNotificationName:kXGRegisterDeviceInfo object:nil];
    }
}

    //如果deviceToken获取不到会进入此事件
- (void)application:(UIApplication *)app didFailToRegisterForRemoteNotificationsWithError:(NSError *)err
{
    
#ifdef DEBUG
    NSString *errstring = [NSString stringWithFormat: @"Error: %@",err];
    NSLog(@"[XGPush Demo]didFailToRegisterForRemoteNotificationsWithError:%@",errstring);
#endif
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    NSLog(@"userInfouserInfo----%@",userInfo);
    
    [self application:application handelNotificationUserinfo:userInfo];
    
    completionHandler(UIBackgroundFetchResultNewData);
}

- (void)application:(UIApplication *)application handelNotificationUserinfo:(NSDictionary *)userInfo
{
    int num=[[[userInfo objectForKey:@"aps"] safeBindStringValue:@"badge"]intValue];
    [[UIApplication  sharedApplication] setApplicationIconBadgeNumber:num];
    
    
    if ([userInfo.allKeys containsObject:@"url"]) {
        NSString *pString = [userInfo safeBindStringValue:@"url"];
        
        NSString *tempString = [pString stringByReplacingOccurrencesOfString:@"math_teacher://yoomath.com/" withString:@""];
        
        if (application.applicationState == UIApplicationStateActive) {
                //            NSDictionary *aps = [userInfo valueForKey:@"aps"];
                //            NSString *content = [aps valueForKey:@"alert"]; //推送显示的内容
                //            __weak typeof(self) _wself = self;
                //            YMBlockAlertView *alert = [[YMBlockAlertView alloc] initWithFrame:self.window.bounds];
                //            [alert showAlertWithTitle:@"提示" msg:content callbackBlock:^(NSInteger btnIndex) {
                //                if (btnIndex == 1) {
                //                    [_wself.viewController pushVCWithXGInfo:pString];
                //                }
                //            } cancelButtonTitle:@"忽略" cancelColor:kLLBBlackColor otherButtonTitles:@"查看" otherColor:kYMRedColor subView:self.viewController.view];
            
//            [self.viewController pushVCWithXGInfo:tempString applicationIsActive:YES];
        } else {
//            [self.viewController pushVCWithXGInfo:tempString];
        }
    }
    
//    [self.viewController clearXGPushMsgList:nil];
        //推送反馈(app运行时)
    [XGPush handleReceiveNotification:userInfo successCallback:nil errorCallback:nil];
}

#pragma mark - UNUserNotificationCenterDelegate

#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0
- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler __IOS_AVAILABLE(10.0) __TVOS_AVAILABLE(10.0) __WATCHOS_AVAILABLE(3.0)
{
    completionHandler(UNNotificationPresentationOptionNone);
}

- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void(^)())completionHandler __IOS_AVAILABLE(10.0) __WATCHOS_AVAILABLE(3.0) __TVOS_PROHIBITED
{
    NSDictionary *userInfo = response.notification.request.content.userInfo;
    
    UIApplication *application = [UIApplication sharedApplication];
    [self application:application handelNotificationUserinfo:userInfo];
    
    completionHandler();
}
#endif

@end
