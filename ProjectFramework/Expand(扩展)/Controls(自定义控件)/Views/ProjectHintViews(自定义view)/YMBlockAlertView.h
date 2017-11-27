//
//  YMBlockAlertView.h
//  YooMath
//
//  Created by Elanking_MacMini on 15/11/27.
//  Copyright © 2015年 ZhangLei. All rights reserved.
//  针对弹出框的alert

#import <UIKit/UIKit.h>

typedef void (^blockYMAlertViewCallBackBlock)(NSInteger btnIndex);

@interface YMBlockAlertView : UIView

- (void)showAlertWithTitle:(NSString *)title
                       msg:(NSString *)msg
             callbackBlock:(blockYMAlertViewCallBackBlock)block
         cancelButtonTitle:(NSString *)cancelBtnTitle cancelColor:(UIColor *)cancelColor
         otherButtonTitles:(NSString *)otherButtonTitles otherColor:(UIColor *)otherColor
                   subView:(UIView *)subview;

@property(nonatomic, assign) NSInteger   type;

@end
