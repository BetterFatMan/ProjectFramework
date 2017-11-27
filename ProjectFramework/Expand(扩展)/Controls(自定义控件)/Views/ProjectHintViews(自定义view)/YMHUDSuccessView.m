//
//  YMHUDSuccessView.m
//  YMTeacher
//
//  Created by Elanking_MacMini on 16/4/11.
//  Copyright © 2016年 ZhangLei. All rights reserved.
//

#import "YMHUDSuccessView.h"
#import "AppDelegate.h"

#define kHUDViewWidth   150
#define kHUDViewHeight  120

@interface YMHUDSuccessView ()

@property(nonatomic, strong) CAShapeLayer      *shapeLayer;

@property(nonatomic, strong) CAShapeLayer      *errorLayer;

@property(nonatomic, strong) UIImageView                *imageView;
@property(nonatomic, strong) UILabel                    *titleLable;

@end

@implementation YMHUDSuccessView

+ (YMHUDSuccessView *)showYMHUDSuccessView:(NSString *)title hideAfterDuration:(CGFloat)duration
{
    YMHUDSuccessView *HUD = [[YMHUDSuccessView alloc] initWithFrame:CGRectMake(0, 0, kHUDViewWidth, kHUDViewHeight)];
    HUD.center = CGPointMake(kKeyWindow.center.x, kKeyWindow.center.y-20);
    HUD.titleLable.text = title;
    [[kAppDelegate window].rootViewController.view addSubview:HUD];
    [kKeyWindow addSubview:HUD];
    
    if (duration > 0) {
        __weak typeof(HUD) _wself = HUD;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:0.35 animations:^{
                _wself.alpha = 0.0;
            } completion:^(BOOL finished) {
                [_wself removeFromSuperview];
            }];
        });
        
    }
    
    return HUD;
}

- (CAShapeLayer *)shapeLayer
{
    if (_shapeLayer == nil) {
        
        UIBezierPath *checkmarkPath = [UIBezierPath bezierPath];
        
        [checkmarkPath moveToPoint:CGPointMake(10.0, 20)];
        [checkmarkPath addLineToPoint:CGPointMake(26, 36)];
        [checkmarkPath addLineToPoint:CGPointMake(50, 0)];
        
        _shapeLayer = [CAShapeLayer layer];
        _shapeLayer.frame = CGRectMake(10.0, 10.0, 60, 40);
        _shapeLayer.position    = CGPointMake(75, 46);
        _shapeLayer.lineCap     = kCALineCapRound;
        _shapeLayer.lineJoin    = kCALineJoinRound;
        _shapeLayer.lineWidth   = 2.5;
        _shapeLayer.strokeColor = [UIColor whiteColor].CGColor;
        _shapeLayer.fillColor   = [UIColor clearColor].CGColor;
        _shapeLayer.path        = checkmarkPath.CGPath;
        _shapeLayer.strokeStart = 0;
        
        CABasicAnimation *anmation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        anmation.fromValue      = @0;
        anmation.toValue        = @1.0;
        anmation.duration   = 0.40;
        anmation.delegate   = (id <CAAnimationDelegate>)self;
        
        [_shapeLayer addAnimation:anmation forKey:@"checkmarkStrokeAnimation"];
        
    }
    
    return _shapeLayer;
}

- (CAShapeLayer *)errorLayer
{
    if (_errorLayer == nil) {
        
        UIBezierPath *checkmarkPath = [UIBezierPath bezierPath];
        
        [checkmarkPath moveToPoint:CGPointMake(10.0, 0)];
        [checkmarkPath addLineToPoint:CGPointMake(50, 40)];
        [checkmarkPath moveToPoint:CGPointMake(50.0, 0)];
        [checkmarkPath addLineToPoint:CGPointMake(10, 40)];
        
        _errorLayer = [CAShapeLayer layer];
        _errorLayer.frame = CGRectMake(10.0, 10.0, 60, 40);
        _errorLayer.position    = CGPointMake(75, 46);
        _errorLayer.lineCap     = kCALineCapRound;
        _errorLayer.lineJoin    = kCALineJoinRound;
        _errorLayer.lineWidth   = 2.5;
        _errorLayer.strokeColor = [UIColor whiteColor].CGColor;
        _errorLayer.fillColor   = [UIColor clearColor].CGColor;
        _errorLayer.path        = checkmarkPath.CGPath;
        _errorLayer.strokeStart = 0;
        
        CABasicAnimation *anmation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        anmation.fromValue      = @0;
        anmation.toValue        = @1.0;
        anmation.duration   = 0.40;
        anmation.delegate   = (id <CAAnimationDelegate>)self;
        
        [_errorLayer addAnimation:anmation forKey:@"ErrorStrokeAnimation"];
    }
    
    return _errorLayer;
}

- (UILabel *)titleLable
{
    if (_titleLable == nil) {
        _titleLable = [[UILabel  alloc] initWithFrame:CGRectMake(0, 78, kHUDViewWidth, 20)];
        _titleLable.textAlignment = NSTextAlignmentCenter;
        _titleLable.textColor = [UIColor whiteColor];
        _titleLable.font = gFontSystemSize(15);
        _titleLable.text = @"正在注册";
    }
    return _titleLable;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor    = [UIColor colorWithWhite:0.0 alpha:0.6];
        
        self.layer.cornerRadius = 5;
        self.clipsToBounds      = YES;
        
        CGRect rect = CGRectMake(0, 0, 50, 50);
        self.imageView = [[UIImageView alloc] initWithFrame:rect];
        self.imageView.center = CGPointMake(self.center.x, self.center.y-18);
        
        self.imageView.image = [UIImage imageNamed:@"new_loading"];
        
        [self addImageViewAnimation:_imageView];
        
        self.imageView.backgroundColor = [UIColor clearColor];
        [self addSubview:self.imageView];
        
        [self addSubview:self.titleLable];
        
    }
    return self;
}

- (void)addImageViewAnimation:(UIImageView *)image
{
    CABasicAnimation *animation = [ CABasicAnimation animationWithKeyPath: @"transform" ];
    animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    
        //围绕Z轴旋转，垂直与屏幕
    animation.toValue = [ NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI-0.1, 0.0, 0.0, 1.0) ];
    animation.duration = 0.35;
        //旋转效果累计，先转180度，接着再旋转180度，从而实现360旋转
    animation.cumulative = YES;
    animation.removedOnCompletion = NO;
    animation.repeatCount = HUGE_VALL;
    
    [image.layer setShouldRasterize:YES];//抗锯齿
    [image.layer setRasterizationScale:[[UIScreen mainScreen] scale]];
    [image.layer addAnimation:animation forKey:nil];
    
        //如果暂停了，则恢复动画运行
    if (image.layer.speed == 0.0)
    {
//        [self resumeAnimating];
    }
}

- (void)resumeAnimating
{
    CFTimeInterval pausedTime = [_imageView.layer timeOffset];
    _imageView.layer.speed = 1.0;
    _imageView.layer.timeOffset = 0.0;
    _imageView.layer.beginTime = 0.0;
    CFTimeInterval timeSincePause = [_imageView.layer convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
    _imageView.layer.beginTime = timeSincePause;
}

- (void)changeSuccessType:(NSString *)successTitle
{
    [self.imageView.layer removeAllAnimations];
    self.imageView.hidden = YES;
    
    self.titleLable.text    = successTitle?:@"注册成功";
    
    [self.layer addSublayer:self.shapeLayer];
}

- (void)changedImageSuccess:(NSString *)successTitle
{
    [self.imageView.layer removeAllAnimations];
    _imageView.image = [UIImage imageNamed:@"icon_success"];
    self.titleLable.text    = successTitle?:@"注册成功";
    
    [UIView animateWithDuration:0.25
                          delay:0.8
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         self.alpha = 0.0;
                     }
                     completion:^(BOOL finished) {
                         [self removeFromSuperview];
                     }];
}

- (void)changeErrorType:(NSString *)errorTitle change:(BOOL)isChanged
{
    [self.imageView.layer removeAllAnimations];
    self.imageView.hidden = YES;
    
    self.titleLable.text    = errorTitle?:@"注册失败";
    [self.layer addSublayer:self.errorLayer];
    
}

- (void)hideHUDViewAnimation
{
    [UIView animateWithDuration:0.25 animations:^{
        self.alpha = 0.0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if ([anim isKindOfClass:[CABasicAnimation class]]) {
        CABasicAnimation *baseAni = (CABasicAnimation *)anim;
        if ([baseAni.keyPath isEqualToString:@"strokeEnd"]) {
            
            __weak typeof(self) _wself = self;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.55 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [UIView animateWithDuration:0.25 animations:^{
                    _wself.alpha = 0.0;
                } completion:^(BOOL finished) {
                    [_wself removeFromSuperview];
                }];
            });
        }
    }
    
    
}

@end


@implementation YMHUDSuccessShapeLayer

+ (BOOL)needsDisplayForKey:(NSString *)key
{
    if ([key isEqualToString:@"progress"]) {
        return YES;
    }
    return [super needsDisplayForKey:key];
    
}

- (void)drawInContext:(CGContextRef)ctx
{
    UIBezierPath *checkmarkPath = [UIBezierPath bezierPath];
    
    if ([_type isEqualToString:@"success"]) {
        
        [checkmarkPath moveToPoint:CGPointMake(10.0, 20)];
        
        if (_progress < 0.4) {
            
            [checkmarkPath addLineToPoint:CGPointMake(10+40*_progress, 20+40*_progress)];
        } else {
            [checkmarkPath addLineToPoint:CGPointMake(26, 36)];
            [checkmarkPath addLineToPoint:CGPointMake(26+40*(_progress-0.4), 36-60*(_progress-0.4))];
        }
    } else if ([_type isEqualToString:@"error"]) {
        
        [checkmarkPath moveToPoint:CGPointMake(10.0, 0)];
        
        if (_progress < 0.5) {
            
            [checkmarkPath addLineToPoint:CGPointMake(10+80*_progress, 80*_progress)];
            
        } else {
            [checkmarkPath addLineToPoint:CGPointMake(50, 40)];
            [checkmarkPath moveToPoint:CGPointMake(50.0, 0)];
            
            
            [checkmarkPath addLineToPoint:CGPointMake(50-80*(_progress-0.5), 80*(_progress-0.5))];
        }
    }
    
    CGContextAddPath(ctx, checkmarkPath.CGPath);
    CGContextSetLineWidth(ctx, 2.5);
    CGContextSetLineCap(ctx, kCGLineCapRound);
    CGContextSetLineJoin(ctx, kCGLineJoinRound);
    CGContextSetStrokeColorWithColor(ctx, [UIColor whiteColor].CGColor);
    CGContextStrokePath(ctx);
    
}

@end
