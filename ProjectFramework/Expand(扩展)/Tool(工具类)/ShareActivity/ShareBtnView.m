//
//  ShareBtnView.m
//  YooMath
//
//  Created by Elanking_MacMini on 15/12/23.
//  Copyright © 2015年 ZhangLei. All rights reserved.
//


#import "ShareBtnView.h"

#define SHAREBUTTON_WIDTH                                  50
#define SHAREBUTTON_HEIGHT                                 50

#define SHARETITLE_WIDTH                                   50
#define SHARETITLE_HEIGHT                                  20

@implementation ShareBtnView
- (instancetype)initWithFrame:(CGRect)frame
              imagesNameArray:(NSArray *)shareButtonImagesNameArray
                  titlesArray:(NSArray *)shareButtonTitlesArray
{
    self = [super initWithFrame:frame];
    if (self)
    {
        CGFloat width = CGRectGetWidth(frame);
        
        CGFloat space = (width - shareButtonImagesNameArray.count*SHAREBUTTON_WIDTH)/(shareButtonImagesNameArray.count+1);
        
        CGFloat left = space;
        for (int i = 0; i < shareButtonImagesNameArray.count; i ++) {
            
            CGRect rect = CGRectZero;
            if (i < 9)
            {
                ///新浪微博分享
                UIButton *bbtn = [UIButton buttonWithType:UIButtonTypeCustom];
                [bbtn setFrame:CGRectMake(left, 5, SHAREBUTTON_WIDTH, SHAREBUTTON_HEIGHT)];
                [bbtn setBackgroundImage:[UIImage imageNamed:[shareButtonImagesNameArray objectAtIndexSafe:i]] forState:UIControlStateNormal];
                bbtn.tag = i;
                [bbtn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
                
                [self addSubview:bbtn];
                rect = bbtn.frame;
            }
            else if (i > 9)
            {
                /// 链接复制
                ShareButton *bbtn = [[ShareButton alloc] initWithFrame:CGRectMake(left, 5, SHAREBUTTON_WIDTH, SHAREBUTTON_HEIGHT)];
                bbtn.image = [UIImage imageNamed:[shareButtonImagesNameArray objectAtIndexSafe:i]];
                [self addSubview:bbtn];
                rect = bbtn.frame;
            }
            
            
            UILabel *weiboTitle = [[UILabel alloc] initWithFrame:CGRectMake(rect.origin.x, CGRectGetMaxY(rect), SHARETITLE_WIDTH, SHARETITLE_HEIGHT)];
            [self createShareButtonTitles:[shareButtonTitlesArray objectAtIndexSafe:i] shareButtonLabel:weiboTitle];
            
            left += SHAREBUTTON_WIDTH+space;
            
        }
    }
    return self;
}

- (void)createShareButtonTitles:(NSString *)title shareButtonLabel:(UILabel *)shareButtonLabel
{
    NSString *shareButtonTitleStr = [title stringByReplacingOccurrencesOfString:@" " withString:@""];
//    CGSize shareButtonTitleSize = getStringSize(shareButtonTitleStr, [UIFont systemFontOfSize:10.0f], CGSizeMake(SHARETITLE_WIDTH, SHARETITLE_HEIGHT));
    shareButtonLabel.text = shareButtonTitleStr;
    shareButtonLabel.font = [UIFont systemFontOfSize:10.0f];
    shareButtonLabel.textAlignment = NSTextAlignmentCenter;
    shareButtonLabel.textColor = [UIColor blackColor];
    [self addSubview:shareButtonLabel];
}

- (void)clickBtn:(UIButton *)sender
{
    if (sender.tag == 9)
    {
        
    }
    else
    {
        if (_delegate && [_delegate respondsToSelector:@selector(didClickShareBtn:)])
        {
            [_delegate didClickShareBtn:sender.tag];
        }
    }
    
    
}

@end

@implementation ShareButton

//绑定事件
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self attachTapHandler];
    }
    return self;
}

// default is NO
- (BOOL)canBecomeFirstResponder{
    return YES;
}

//"反馈"关心的功能
-(BOOL)canPerformAction:(SEL)action withSender:(id)sender{
    return (action == @selector(copy:));
}

//针对于copy的实现
-(void)copy:(id)sender{
    UIPasteboard *pboard = [UIPasteboard generalPasteboard];
    pboard.string = kAppUrl;
}

//UILabel默认是不接收事件的，我们需要自己添加touch事件
-(void)attachTapHandler{
    self.userInteractionEnabled = YES;  //用户交互的总开关
    UITapGestureRecognizer *touch = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    touch.numberOfTapsRequired = 1;
    [self addGestureRecognizer:touch];
}


-(void)handleTap:(UIGestureRecognizer*) recognizer{
    [self becomeFirstResponder];
    UIMenuController *menu = [UIMenuController sharedMenuController];
    [menu setTargetRect:self.frame inView:self.superview];
    [menu setMenuVisible:YES animated:YES];
}

@end
