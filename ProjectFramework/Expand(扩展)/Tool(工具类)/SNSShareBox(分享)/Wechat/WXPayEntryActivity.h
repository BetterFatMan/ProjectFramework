//
//  WXPayEntryActivity.h
//  Line0new
//
//  Created by line0 on 14-6-27.
//  Copyright (c) 2014年 zhanglei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WXApi.h"
#import "WXApiObject.h"

#define kWeixinPaySuccessNotification   (@"kWeixinPaySuccessNotification")
#define kWeixinPayFailedNotification    (@"kWeixinPayFailedNotification")

@interface WXPayEntryActivity : NSObject{
    enum WXScene _scene;
}

+(void)payOrderStringAtWXWithDetail:(NSDictionary *)orderString;

@end

