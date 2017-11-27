//
//  YMLoadingView.m
//  YooMath
//
//  Created by Elanking_MacMini on 15/11/12.
//  Copyright © 2015年 ZhangLei. All rights reserved.
//

#import "YMLoadingView.h"
#import "UIView+Layer.h"
#import "AppDelegate.h"

@interface YMLoadingView ()

@property (strong, nonatomic) UIImageView   *imgView;
@property(nonatomic, strong) UILabel        *titleLable;

@end



@implementation YMLoadingView

static YMLoadingView *__ymloadingView = nil;

+ (instancetype)shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __ymloadingView = [[YMLoadingView alloc] init];
    });
    return __ymloadingView;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:CGRectMake(0, 64, kKeyWindow.width, kKeyWindow.height)];
    if (self)
    {
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.15];
        self.hidden = YES;
        [[kAppDelegate window] addSubview:self];
        
        CGRect rect = CGRectMake(0, 0, 50, 50);
        self.imgView = [[UIImageView alloc] initWithFrame:rect];
        self.imgView.center = CGPointMake(self.center.x, (kKeyWindow.height-64.0)/2.0-28);
        
        self.imgView.image = [UIImage imageNamed:@"new_loading"];
        
        [self.imgView startRotationAnimatingWithDuration:0.25];
        self.imgView.backgroundColor = [UIColor clearColor];
        
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
        bgView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.6];
        bgView.layer.cornerRadius = 5.0;
        bgView.clipsToBounds = YES;
        bgView.center = self.imgView.center;
        [self addSubview:bgView];
        
        [self addSubview:self.imgView];
        
    }
    return self;
}

- (void)showWaittingView
{
    self.frame = CGRectMake(0, 64, kKeyWindow.width, kKeyWindow.height);
    if (![[kAppDelegate window].subviews containsObject:self])
    {
        [[kAppDelegate window] addSubview:self];
    }
    
    self.alpha = 0.0;
    self.hidden = NO;
    
    [self.imgView startAnimating];
    [UIView animateWithDuration:0.45 animations:^
     {
         self.alpha = 1.0;
     }];
}

- (void)showFullWaittingView
{
    self.frame = CGRectMake(0, 0, kKeyWindow.width, kKeyWindow.height);
    if (![[kAppDelegate window].subviews containsObject:self])
    {
        [[kAppDelegate window] addSubview:self];
    }
    
    self.alpha = 0.0;
    self.hidden = NO;
    
    [self.imgView startAnimating];
    [UIView animateWithDuration:0.75 animations:^
     {
         self.alpha = 1.0;
     }];
}

- (void)hideWaittingView
{
    self.alpha = 1.0;
    [UIView animateWithDuration:0.05
                     animations:^{
                         self.alpha = 0.0;
                     }
                     completion:^(BOOL finished)
     {
         self.hidden = YES;
         [self.imgView stopAnimating];
         if ([[kAppDelegate window].subviews containsObject:self])
         {
             [self removeFromSuperview];
         }
     }];
}

@end
