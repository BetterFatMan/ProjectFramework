//
//  MJYooMathRefreshHeader.m
//  YooMath
//
//  Created by Elanking_MacMini on 16/2/22.
//  Copyright © 2016年 ZhangLei. All rights reserved.
//

#import "MJYooMathRefreshHeader.h"

@interface MJYooMathRefreshHeader ()
{
    __weak UIImageView *_arrowView;
}
@property (weak, nonatomic) UIActivityIndicatorView *loadingView;

//@property(nonatomic, strong) UILabel            *successLable;

@end

@implementation MJYooMathRefreshHeader

#pragma mark - 懒加载子控件
- (UIImageView *)arrowView
{
    if (!_arrowView) {
        UIImage *image = [UIImage imageNamed:MJRefreshSrcName(@"arrow.png")];
        if (!image) {
            image = [UIImage imageNamed:MJRefreshFrameworkSrcName(@"arrow.png")];
        }
        UIImageView *arrowView = [[UIImageView alloc] initWithImage:image];
        [self addSubview:_arrowView = arrowView];
    }
    return _arrowView;
}

- (UIImageView *)successImageView
{
    if (!_successImageView) {
        UIImage *image = [UIImage imageNamed:MJRefreshSrcName(@"icon_refresh03.png")];
        if (!image) {
            image = [UIImage imageNamed:MJRefreshFrameworkSrcName(@"icon_refresh03.png")];
        }
        UIImageView *arrowView = [[UIImageView alloc] initWithImage:image];
        [self addSubview:_successImageView = arrowView];
        _successImageView.hidden = YES;
    }
    return _successImageView;
}

//- (UILabel *)successLable
//{
//    if (!_successLable) {
//        [self addSubview:_successLable = [UILabel label]];
//        _successLable.text = @"加载成功";
//        _successLable.hidden = YES;
//    }
//    return _successLable;
//}

- (UIActivityIndicatorView *)loadingView
{
    if (!_loadingView) {
        UIActivityIndicatorView *loadingView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:self.activityIndicatorViewStyle];
        loadingView.hidesWhenStopped = YES;
        [self addSubview:_loadingView = loadingView];
    }
    return _loadingView;
}

#pragma mark - 公共方法
- (void)setActivityIndicatorViewStyle:(UIActivityIndicatorViewStyle)activityIndicatorViewStyle
{
    _activityIndicatorViewStyle = activityIndicatorViewStyle;
    
    self.loadingView = nil;
    [self setNeedsLayout];
}

#pragma makr - 重写父类的方法
- (void)prepare
{
    [super prepare];
    
    self.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
}

- (void)placeSubviews
{
    [super placeSubviews];
    
        // 箭头
    self.arrowView.mj_size = self.arrowView.image.size;
    CGFloat arrowCenterX = self.mj_w * 0.5;
    if (!self.stateLabel.isHidden) {
        arrowCenterX -= 60;
    }
    CGFloat arrowCenterY = self.mj_h * 0.5;
    self.arrowView.center = CGPointMake(arrowCenterX, arrowCenterY);
    
        // 圈圈
    self.loadingView.frame = self.arrowView.frame;
    self.successImageView.center = CGPointMake(self.mj_w * 0.5-50, arrowCenterY);
//    self.successLable.frame = self.stateLabel.frame;
}

- (void)setState:(MJRefreshState)state
{
    MJRefreshCheckState
    
        // 根据状态做事情
    if (state == MJRefreshStateIdle) {
        if (oldState == MJRefreshStateRefreshing) {
            CGFloat animationTime = 0.0;
            if (self.isShowSuccessType) {
                animationTime = 1.0;
                self.successImageView.alpha = 0.0;
                self.successImageView.hidden = NO;
                self.arrowView.hidden = YES;
            }
            
            self.arrowView.transform = CGAffineTransformIdentity;
            
            [UIView animateWithDuration:MJRefreshSlowAnimationDuration animations:^{
                self.loadingView.alpha = 0.0;
                if (self.isShowSuccessType) {
                    self.stateLabel.text = @"加载成功";
                    self.successImageView.alpha = 1.0;
                }
            } completion:^(BOOL finished) {
                    // 如果执行完动画发现不是idle状态，就直接返回，进入其他状态
                if (self.state != MJRefreshStateIdle) return;
                
                self.loadingView.alpha = 1.0;
                [self.loadingView stopAnimating];
                
                if (!self.isShowSuccessType) {
                    self.arrowView.hidden = NO;
                }
            }];
            
            if (self.isShowSuccessType) {
                __weak typeof(self) _wself = self;
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(animationTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        // 恢复inset和offset
                    [UIView animateWithDuration:MJRefreshSlowAnimationDuration animations:^{
                        
                            /*
                             * 多次下拉刷新之后存在将滚动页面裁剪的问题
                             */
                        _wself.scrollView.mj_insetT -= _wself.mj_h;
                        
                            // 自动调整透明度
                        if (_wself.isAutomaticallyChangeAlpha) _wself.alpha = 0.0;
                    } completion:^(BOOL finished) {
                        _wself.pullingPercent = 0.0;
                        
                        _wself.successImageView.hidden = YES;
                            // 设置状态文字
                        _wself.stateLabel.text = _wself.stateTitles[@(state)];
                        _wself.arrowView.hidden = NO;
                        
                    }];
                    self.isShowSuccessType = NO;
                });
            }
            
        } else {
            [self.loadingView stopAnimating];
            self.arrowView.hidden = NO;
            [UIView animateWithDuration:MJRefreshFastAnimationDuration animations:^{
                self.arrowView.transform = CGAffineTransformIdentity;
            }];
        }
    } else if (state == MJRefreshStatePulling) {
        [self.loadingView stopAnimating];
        self.arrowView.hidden = NO;
        [UIView animateWithDuration:MJRefreshFastAnimationDuration animations:^{
            self.arrowView.transform = CGAffineTransformMakeRotation(0.000001 - M_PI);
        }];
    } else if (state == MJRefreshStateRefreshing) {
        self.loadingView.alpha = 1.0; // 防止refreshing -> idle的动画完毕动作没有被执行
        [self.loadingView startAnimating];
        self.arrowView.hidden = YES;
    }
}

@end
