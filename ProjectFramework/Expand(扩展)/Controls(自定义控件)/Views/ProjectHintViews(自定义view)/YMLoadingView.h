//
//  YMLoadingView.h
//  YooMath
//
//  Created by Elanking_MacMini on 15/11/12.
//  Copyright © 2015年 ZhangLei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YMLoadingView : UIView

+ (instancetype)shareInstance;

- (void)showWaittingView;
- (void)hideWaittingView;

- (void)showFullWaittingView;

@end
