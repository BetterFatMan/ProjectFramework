//
//  InternetErrorMsgView.m
//  YooMath
//
//  Created by Elanking_MacMini on 16/2/22.
//  Copyright © 2016年 ZhangLei. All rights reserved.
//

#import "InternetErrorMsgView.h"

static NSInteger const kYMInternetErrorViewTaf = 2008;

@interface InternetErrorMsgView ()

@property(nonatomic, strong) UILabel        *titleLable;

@end

@implementation InternetErrorMsgView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
    
        self.tag = kYMInternetErrorViewTaf;
    
        self.backgroundColor = UICOLOR_RGBA(0, 0, 0, 0.7);
        self.layer.cornerRadius = 5.0;
        self.clipsToBounds = YES;
        self.userInteractionEnabled = NO;
        
        _titleLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(frame), CGRectGetHeight(frame))];
        _titleLable.textAlignment = NSTextAlignmentCenter;
        _titleLable.textColor = [UIColor whiteColor];
        _titleLable.font = gFontSystemSize(15);
        _titleLable.adjustsFontSizeToFitWidth = YES;
    
        [self addSubview:_titleLable];
        
    }
    return self;
}

+ (instancetype)showInternetErrorMsgView:(NSString *)title hideAfterDuration:(NSTimeInterval)time
{
    return [[self class] showInternetErrorMsgView:title hideAfterDuration:time isCenter:YES];
}
+ (instancetype)showInternetErrorMsgView:(NSString *)title hideAfterDuration:(NSTimeInterval)time isCenter:(BOOL)isCenter
{
    CGSize size = getStringSize(title, gFontSystemSize(15), CGSizeMake(1000, 30));
    
    if (size.width+20 > kKeyWindow.width-30) {
        size.width = kKeyWindow.width-30;
    }
    if (size.width < 170) {
        size.width = 170;
    }
    
    InternetErrorMsgView *msg = [[InternetErrorMsgView alloc] initWithFrame:CGRectMake((kKeyWindow.width-size.width-20)/2.0, (kKeyWindow.height-50)/2.0-10, size.width+20, 50)];
    if ([title rangeOfString:@"\n"].location != NSNotFound) {
        msg.titleLable.numberOfLines = 2;
    }
    msg.titleLable.text = title;
    
    if (!isCenter) {
            /* 非页面中心 */
        msg.centerY = kKeyWindow.height*3.0/4.0;
    }
    UIView *internetView = [kKeyWindow viewWithTag:kYMInternetErrorViewTaf];
    if (internetView && [internetView isKindOfClass:[InternetErrorMsgView class]]) {
        internetView.hidden = YES;
    }
    
    [kKeyWindow addSubview:msg];
    __weak typeof(msg) _wmsg = msg;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(time * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.25 animations:^{
            _wmsg.alpha = 0.0;
        } completion:^(BOOL finished) {
            [_wmsg removeFromSuperview];
        }];
    });
    
    return msg;
}

@end
