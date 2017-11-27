//
//  STUErrorReloadView.m
//  YooMath
//
//  Created by Elanking_MacMini on 16/6/22.
//  Copyright © 2016年 ZhangLei. All rights reserved.
//

#import "STUErrorReloadView.h"

#import "CameraLoadingView.h"

@interface STUErrorReloadView ()
{
    UIImageView     *_errorImage;
    UILabel *lableText;
    UILabel *lableContent;
}

@property(nonatomic, strong) UIButton       *button;

@property(nonatomic, copy) reloadRequestBlock   reloadBlock;

@end

@implementation STUErrorReloadView

- (void)dealloc
{
    _reloadBlock = nil;
}

- (instancetype)initWithFrame:(CGRect)frame name:(NSString *)imageName reloadBlock:(reloadRequestBlock)block
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIImage *image = [UIImage imageNamed:imageName];
        
        UIImageView *view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, image.size.width, image.size.height)];
        view.image = image;
        [self addSubview:view];
        view.center = CGPointMake(CGRectGetWidth(frame)/2.0, CGRectGetHeight(frame)/2.0-image.size.height/2.0);
        _errorImage = view;
        
        UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(0, view.bottom+8, CGRectGetWidth(frame), 13)];
        lable.textAlignment = NSTextAlignmentCenter;
        lable.textColor = kLLBBlackColor;
        lable.font = gFontSystemSize(12);
        [self addSubview:lable];
        lable.text = @"当前手机网络异常";
        lableText = lable;
        
        UILabel *lable1 = [[UILabel alloc] initWithFrame:CGRectMake(0, lable.bottom+5, CGRectGetWidth(frame), 13)];
        lable1.textAlignment = NSTextAlignmentCenter;
        lable1.textColor = kLLBBlackColor;
        lable1.font = gFontSystemSize(12);
        [self addSubview:lable1];
        lable1.text = @"点击图标重新加载";
        lableContent = lable1;
        
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        _button.frame = CGRectMake(0, 0, CGRectGetWidth(frame), CGRectGetHeight(frame));
        [self addSubview:_button];
        [_button addTarget:self action:@selector(clickreloadBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        _reloadBlock = [block copy];
    }
    return self;
}

- (void)changedErrorTitle
{
    [self.loadingView changedSearchMsg];
    self.loadingView.hidden = YES;
}

- (void)changedErrorTitles:(NSString *)info
{
    [self.loadingView changedSearchMsgs:info];
    _loadingView.hidden = YES;
}

- (void)changedErrorTitleColor:(UIColor *)color
{
    [_loadingView changedTextColor:color];
}

- (void)beginViewLoading
{
    self.loadingView.hidden = NO;
    _errorImage.hidden = lableText.hidden = lableContent.hidden = YES;
    _button.enabled = NO;
    
//    [self.loadingView addLoadingAnimation];
    [self.loadingView.imageView startAnimating];
}

- (void)endViewLoading
{
    [self.loadingView.imageView stopAnimating];
    self.loadingView.hidden = YES;
    _errorImage.hidden = lableText.hidden = lableContent.hidden = NO;
    _button.enabled = YES;
}

- (void)clickreloadBtn:(UIButton *)btn
{
    [self beginViewLoading];
    
    if (_reloadBlock) {
        _reloadBlock();
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        btn.enabled = YES;
    });
    
}

- (CameraLoadingView *)loadingView
{
    if (_loadingView == nil) {
        _loadingView = [[CameraLoadingView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
        _loadingView.center = CGPointMake(self.width/2.0, self.height/2.0);
        [self addSubview:_loadingView];
    }
    return _loadingView;
}

@end
