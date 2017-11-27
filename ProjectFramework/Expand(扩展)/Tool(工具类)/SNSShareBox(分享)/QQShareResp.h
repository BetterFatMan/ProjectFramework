//
//  QQShareResp.h
//  YooMath
//
//  Created by Elanking_MacMini on 15/12/22.
//  Copyright © 2015年 ZhangLei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <TencentOpenAPI/QQApiInterface.h>

@protocol QQShareRespDelegate <NSObject>

@optional
- (void)showQQShareResult:(NSInteger)tyepe;

@end

@interface QQShareResp : NSObject<QQApiInterfaceDelegate>

@property(nonatomic, weak) id<QQShareRespDelegate>delegate;

@end
