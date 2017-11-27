//
//  ShareActivity.m
//  Line0new
//
//  Created by user on 14-9-1.
//  Copyright (c) 2014年 com.line0. All rights reserved.
//

#import "ShareActivity.h"
#define WINDOW_COLOR                            [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6]
#define ANIMATE_DURATION                                          0.25f

#define CORNER_RADIUS                                      4


#define SHAREBUTTON_WIDTH                                  50
#define SHAREBUTTON_HEIGHT                                 50

#define SHARETITLE_WIDTH                                   50
#define SHARETITLE_HEIGHT                                  20

#define BUTTON_WIDTH                                        200

#import "ShareBtnView.h"

@interface ShareActivity ()<ShareBtnViewDelegate>

@property(nonatomic, strong) UIView *backView;
@property(nonatomic, assign) CGFloat ShareActivityHeight;
@property(nonatomic, weak) id<ShareActivityDelegate> delegate;

@property(nonatomic, strong) ShareBtnView  *btnView;

@end

@implementation ShareActivity

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

- (id)initWithTitle:(NSString *)title delegate:(id<ShareActivityDelegate>)delegate cancelButtonTitle:(NSString *)cancelButtonTitle ShareButtonTitles:(NSArray *)shareButtonTitlesArray withShareButtonImagesName:(NSArray *)shareButtonImagesNameArray;
{
    self = [super init];
    if (self) {
            //初始化背景视图，添加手势
        self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        self.backgroundColor = WINDOW_COLOR;
        self.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedCancel)];
        [self addGestureRecognizer:tapGesture];
        
        if (delegate) {
            self.delegate = delegate;
        }
        
        [self creatButtonsWithTitle:title cancelButtonTitle:cancelButtonTitle shareButtonTitles:shareButtonTitlesArray withShareButtonImagesName:shareButtonImagesNameArray];
        
    }
    return self;
}

- (void)showInView:(UIView *)view
{
    [[UIApplication sharedApplication].delegate.window.rootViewController.view addSubview:self];
}

- (void)showInView:(UIView *)view isSub:(BOOL)isAddSub
{
    if (isAddSub)
    {
        [view addSubview:self];
    }
    else
    {
        [self showInView:view];
    }
}

- (void)creatButtonsWithTitle:(NSString *)title cancelButtonTitle:(NSString *)cancelButtonTitle shareButtonTitles:(NSArray *)shareButtonTitlesArray withShareButtonImagesName:(NSArray *)shareButtonImagesNameArray
{
    self.ShareActivityHeight = 0;
    
        ///生成ShareActionSheetView
    self.backView = [[UIView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, 0)];
    self.backView.backgroundColor = [UIColor whiteColor];
    
        ///给ShareActionSheetView添加响应事件
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedCancel)];
    [self.backView addGestureRecognizer:tapGesture];
    [self addSubview:self.backView];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, self.backView.width, 40)];
    NSString *titleStr = [title stringByReplacingOccurrencesOfString:@" " withString:@""];
    CGSize titleLabelSize = getStringSize(titleStr, [UIFont systemFontOfSize:16.0f], CGSizeMake(self.backView.width, 40));
    titleLabel.font = [UIFont systemFontOfSize:16.0f];
    titleLabel.text = titleStr;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor blackColor];
    self.ShareActivityHeight = titleLabelSize.height;
    [self.backView addSubview:titleLabel];
    
    _btnView = [[ShareBtnView alloc] initWithFrame:CGRectMake(0, titleLabel.bottom, kKeyWindow.width, 80) imagesNameArray:shareButtonImagesNameArray titlesArray:shareButtonTitlesArray];
    _btnView.delegate = self;
    [self.backView addSubview:_btnView];
    
        ///取消分享btn
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelBtn setFrame:CGRectMake((self.backView.width - BUTTON_WIDTH) / 2, _btnView.bottom + 10, BUTTON_WIDTH, 39)];
    cancelBtn.backgroundColor = [UIColor colorWithRed:151/255.0 green:154/255.0 blue:160/255.0 alpha:1.0];
    cancelBtn.layer.masksToBounds = YES;
    cancelBtn.layer.cornerRadius = CORNER_RADIUS;
    [cancelBtn setTitle:cancelButtonTitle forState:UIControlStateNormal];
    cancelBtn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [cancelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(tappedCancel) forControlEvents:UIControlEventTouchUpInside];
    cancelBtn.tag = 10;
    [self.backView addSubview:cancelBtn];

    
    self.ShareActivityHeight = 200;
    [UIView animateWithDuration:ANIMATE_DURATION animations:^{
        [self.backView setFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height-self.ShareActivityHeight, [UIScreen mainScreen].bounds.size.width, self.ShareActivityHeight)];
    } completion:^(BOOL finished) {
    }];
}

- (void)createShareButtonTitles:(NSString *)title shareButtonLabel:(UILabel *)shareButtonLabel
{
    NSString *shareButtonTitleStr = [title stringByReplacingOccurrencesOfString:@" " withString:@""];
    CGSize shareButtonTitleSize = getStringSize(shareButtonTitleStr, [UIFont systemFontOfSize:10.0f], CGSizeMake(SHARETITLE_WIDTH, SHARETITLE_HEIGHT));
    shareButtonLabel.text = shareButtonTitleStr;
    shareButtonLabel.font = [UIFont systemFontOfSize:10.0f];
    shareButtonLabel.textAlignment = NSTextAlignmentCenter;
    shareButtonLabel.textColor = [UIColor blackColor];
    self.ShareActivityHeight = shareButtonTitleSize.height;
    [self.backView addSubview:shareButtonLabel];
}

- (void)tappedCancel
{
    __weak typeof(self) _wself = self;
    [UIView animateWithDuration:ANIMATE_DURATION animations:^{
        [_wself.backView setFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, 0)];
        _wself.alpha = 0;
    } completion:^(BOOL finished) {
        if (finished)
        {
            [_wself removeFromSuperview];
        }
    }];
    
    
}

#pragma mark - ShareBtnViewDelegate
- (void)didClickShareBtn:(NSInteger)btnIndex
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(didClickOnImageIndex:)])
    {
        [self.delegate didClickOnImageIndex:btnIndex];
    }
    [self tappedCancel];
}

@end
