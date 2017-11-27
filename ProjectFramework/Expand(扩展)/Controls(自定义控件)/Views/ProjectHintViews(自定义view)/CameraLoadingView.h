//
//  CameraLoadingView.h
//  YooMath
//
//  Created by Elanking_MacMini on 16/6/17.
//  Copyright © 2016年 ZhangLei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CameraLoadingView : UIView

+ (CameraLoadingView *)sharedInstance;

- (void)changedSearchMsg;
- (void)changedSearchMsgs:(NSString *)msg;
- (void)changedTextColor:(UIColor *)color;

- (void)addLoadingAnimation;
@property (nonatomic, strong) UIImageView *imageView;

@end


@interface CameraLoadingLayer : CAShapeLayer

@property(nonatomic, assign) CGFloat        progress;

@end
