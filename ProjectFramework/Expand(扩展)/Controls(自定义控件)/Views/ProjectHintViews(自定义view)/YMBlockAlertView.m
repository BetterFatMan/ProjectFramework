//
//  YMBlockAlertView.m
//  YooMath
//
//  Created by Elanking_MacMini on 15/11/27.
//  Copyright © 2015年 ZhangLei. All rights reserved.
//

#import "YMBlockAlertView.h"

#define kAlertWidth        270
#define kAlertHeight       180

@interface YMBlockAlertView ()
{
    UIView          *_bgView;
    
    UIView          *_alertView;
    blockYMAlertViewCallBackBlock _callbackBlock;
}

@end

@implementation YMBlockAlertView

- (void)dealloc
{
    _callbackBlock = nil;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(frame), CGRectGetHeight(frame))];
        _bgView.backgroundColor = UICOLOR_RGBA(1, 1, 1, 0.6);
        [self addSubview:_bgView];
        
        _alertView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kAlertWidth, kAlertHeight)];
        _alertView.backgroundColor = [UIColor whiteColor];
        _alertView.layer.cornerRadius   = 10;
        _alertView.clipsToBounds        = YES;
        _alertView.center = CGPointMake(CGRectGetWidth(frame)/2, CGRectGetHeight(frame)/2);
        [self addSubview:_alertView];
        
        _type = 0;
    }
    return self;
}

- (void)showAlertWithTitle:(NSString *)title
                       msg:(NSString *)msg
             callbackBlock:(blockYMAlertViewCallBackBlock)block
         cancelButtonTitle:(NSString *)cancelBtnTitle cancelColor:(UIColor *)cancelColor
         otherButtonTitles:(NSString *)otherButtonTitles otherColor:(UIColor *)otherColor
                   subView:(UIView *)subview
{
    UILabel *titleLable = [self createLable];
    titleLable.frame = CGRectMake(0, 0, _alertView.width, 60);
    titleLable.textColor = kLBBlackColor;
    titleLable.font      = [UIFont boldSystemFontOfSize:18];
    titleLable.text      = title;
    [_alertView addSubview:titleLable];
    
    UILabel *msgLable = [self createLable];
    msgLable.frame = CGRectMake(10, 0, _alertView.width-20, 100);
    msgLable.textColor = kLBBlackColor;
    msgLable.font      = [UIFont systemFontOfSize:15];
    msgLable.numberOfLines = 0;
    [_alertView addSubview:msgLable];
    msgLable.center = CGPointMake(kAlertWidth/2, kAlertHeight/2-15);
    msgLable.text      = msg;
    
    if (!msg.length) {
        titleLable.top += 40;
    }
    
    UIButton *cancleBtn = [self createButton];
    [cancleBtn setTitle:cancelBtnTitle forState:UIControlStateNormal];
    [cancleBtn setTitleColor:cancelColor forState:UIControlStateNormal];
    cancleBtn.tag = 0;
    cancleBtn.frame = CGRectMake(-1, kAlertHeight-50, kAlertWidth+2, 51);
    [_alertView addSubview:cancleBtn];
    
    if (otherButtonTitles.length)
    {
        UIButton *otherBtn = [self createButton];
        [otherBtn setTitle:otherButtonTitles forState:UIControlStateNormal];
        otherBtn.tag = 1;
        [otherBtn setTitleColor:otherColor forState:UIControlStateNormal];
        
        cancleBtn.frame = CGRectMake(-1, kAlertHeight-50, kAlertWidth/2+1, 51);
        otherBtn.frame  = CGRectMake(kAlertWidth/2-0.5, kAlertHeight-50, kAlertWidth/2+1.5, 51);
        [_alertView addSubview:otherBtn];
        
        if ([otherColor isEqual:cancelColor]) {
            if (_type == 0) {
                cancleBtn.titleLabel.font = gBoldFontSysSize(16);
            } else if (_type == 1) {
                otherBtn.titleLabel.font = gBoldFontSysSize(16);
            }
        }
    }
    
    _callbackBlock = nil;
    _callbackBlock = [block copy];
    
    [subview addSubview:self];
    [self showInView:subview];
}

- (void)showInView:(UIView *)subview
{
    _bgView.alpha = 0;
    _alertView.center = CGPointMake(_alertView.center.x, -kAlertHeight/2-55);
    [self addAlertDampAnimation];
    
    [UIView animateWithDuration:0.15 animations:^{
        _bgView.alpha = 1.0;
    } completion:^(BOOL finished) {
        
    }];
    __weak typeof(self) _wself = self;
    [UIView animateWithDuration:0.45 delay:0.10 usingSpringWithDamping:0.6 initialSpringVelocity:0.9 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        _alertView.center = CGPointMake(_alertView.center.x, CGRectGetHeight(_wself.bounds)/2);
    } completion:^(BOOL finished) {
//        [_alertView.layer removeAnimationForKey:@"transformRotate"];
    }];
}

- (void)addAlertDampAnimation
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    animation.fromValue = [ NSValue valueWithCATransform3D:CATransform3DMakeRotation(-M_PI/8, 0.0, 0.0, 1.0) ];
    
    //围绕Z轴旋转，垂直与屏幕
    animation.toValue = [ NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI/8, 0.0, 0.0, 1.0) ];
    animation.duration = 0.25;
    //旋转效果累计，先转180度，接着再旋转180度，从而实现360旋转
    animation.autoreverses = YES;
    animation.removedOnCompletion = YES;
    animation.repeatCount = 1;
    
    [_alertView.layer setShouldRasterize:YES];//抗锯齿
    [_alertView.layer setRasterizationScale:[[UIScreen mainScreen] scale]];
    [_alertView.layer addAnimation:animation forKey:@"transformRotate"];
}

- (UILabel *)createLable
{
    UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectNull];
    titleLable.textAlignment = NSTextAlignmentCenter;
    titleLable.font          = gFontSystemSize(15);
    
    return titleLable;
}

- (UIButton *)createButton
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.layer.borderColor = kProgressBgColor.CGColor;
    button.layer.borderWidth = kIsIPhone6Plus?0.25:0.5;
    button.titleLabel.font = gFontSystemSize(16);
    [button addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    return button;
}

#pragma mark - UIButton Actions
- (void)clickButton:(UIButton *)btn
{
    if (_callbackBlock)
    {
        _callbackBlock(btn.tag);
    }
    
    [UIView animateWithDuration:0.25 animations:^{
        self.alpha = 0.0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

@end
