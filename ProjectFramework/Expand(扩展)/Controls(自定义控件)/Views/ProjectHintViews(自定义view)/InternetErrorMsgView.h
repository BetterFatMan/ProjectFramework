//
//  InternetErrorMsgView.h
//  YooMath
//
//  Created by Elanking_MacMini on 16/2/22.
//  Copyright © 2016年 ZhangLei. All rights reserved.
//

#import "ProjectBaseView.h"

@interface InternetErrorMsgView : ProjectBaseView

+ (instancetype)showInternetErrorMsgView:(NSString *)title hideAfterDuration:(NSTimeInterval)time;

+ (instancetype)showInternetErrorMsgView:(NSString *)title hideAfterDuration:(NSTimeInterval)time isCenter:(BOOL)isCenter;

@end
