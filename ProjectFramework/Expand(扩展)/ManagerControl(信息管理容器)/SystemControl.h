//
//  SystemControl.h
//  YooMath
//
//  Created by Elanking_MacMini on 15/11/11.
//  Copyright © 2015年 ZhangLei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SystemControl : NSObject

    //app启动
+ (void)preAppLoad;

+ (void)afterAppLoad;

+ (void)appWillEnterForeground;

@end
