//
//  CameraLoadingView.m
//  YooMath
//
//  Created by Elanking_MacMini on 16/6/17.
//  Copyright © 2016年 ZhangLei. All rights reserved.
//

#import "CameraLoadingView.h"
#import "UIView+Layer.h"

@interface CameraLoadingView ()
{
    UIView      *_tempView;
    UILabel     *_changedLable;
}

@property(nonatomic, strong) CameraLoadingLayer         *loadingLayer;

//@property(nonatomic, strong) CameraLoadingLayer         *loadingLayerTwo;

@end

@implementation CameraLoadingView

+ (CameraLoadingView *)sharedInstance
{
    return nil;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _tempView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        _tempView.center = CGPointMake(CGRectGetWidth(frame)/2.0, CGRectGetHeight(frame)/2.0-10);
        [self addSubview:_tempView];
        
        NSArray *magesArray = [NSArray arrayWithObjects:
                               [UIImage imageNamed:@"loading_001"],
                               [UIImage imageNamed:@"loading_002"],
                               [UIImage imageNamed:@"loading_003"],
                               [UIImage imageNamed:@"loading_004"],
                               [UIImage imageNamed:@"loading_005"],
                               [UIImage imageNamed:@"loading_006"],
                               [UIImage imageNamed:@"loading_007"],
                               [UIImage imageNamed:@"loading_008"],
                               [UIImage imageNamed:@"loading_009"],
                               [UIImage imageNamed:@"loading_010"],
                               [UIImage imageNamed:@"loading_011"],
                               [UIImage imageNamed:@"loading_012"],
                               [UIImage imageNamed:@"loading_013"],
                               [UIImage imageNamed:@"loading_014"],
                               [UIImage imageNamed:@"loading_015"],
                               [UIImage imageNamed:@"loading_016"],
                               [UIImage imageNamed:@"loading_017"],
                               [UIImage imageNamed:@"loading_018"],
                               [UIImage imageNamed:@"loading_019"],
                               [UIImage imageNamed:@"loading_020"],
                               [UIImage imageNamed:@"loading_021"],
                               [UIImage imageNamed:@"loading_022"],
                               [UIImage imageNamed:@"loading_023"],
                               [UIImage imageNamed:@"loading_024"],
                               [UIImage imageNamed:@"loading_025"],
                               [UIImage imageNamed:@"loading_026"],
                               [UIImage imageNamed:@"loading_027"],
                               [UIImage imageNamed:@"loading_028"],
                               [UIImage imageNamed:@"loading_029"],
                               [UIImage imageNamed:@"loading_020"],
                               [UIImage imageNamed:@"loading_031"],
                               [UIImage imageNamed:@"loading_032"],
                               [UIImage imageNamed:@"loading_033"],
                               [UIImage imageNamed:@"loading_034"],
                               [UIImage imageNamed:@"loading_035"],
                               [UIImage imageNamed:@"loading_036"],nil];
        UIImageView *animationImageView = [[UIImageView alloc]init];
        animationImageView.animationImages = magesArray;
        animationImageView.animationDuration = 2.5;
        animationImageView.animationRepeatCount = 0;
        animationImageView.frame = CGRectMake(0, 0, 30, 30);
        [_tempView addSubview:animationImageView];
        _imageView = animationImageView;
//        _loadingLayer = [CameraLoadingLayer layer];
//        _loadingLayer.frame = CGRectMake(0, 0, 40, 40);
//        _loadingLayer.progress = 1.0;
//        [_tempView.layer addSublayer:_loadingLayer];
//        
//        [_loadingLayer setShouldRasterize:YES];//抗锯齿
//        [_loadingLayer setRasterizationScale:[[UIScreen mainScreen] scale]];
     
        UILabel *templable = [[UILabel alloc] initWithFrame:CGRectMake(5, _tempView.bottom+6, CGRectGetWidth(frame)-10, 13)];
        templable.textAlignment = NSTextAlignmentCenter;
        templable.textColor = kLLBBlackColor;
        templable.font = gFontSystemSize(12);
        templable.text = @"正在加载...";
        [self addSubview:templable];
        _changedLable = templable;
        
//        [_tempView startRotationAnimatingWithDuration:0.45];
        
    }
    return self;
}

- (void)changedSearchMsg
{
    _changedLable.text = @"正在搜索...";
}

- (void)changedSearchMsgs:(NSString *)msg
{
    _changedLable.text = msg;
}

- (void)changedTextColor:(UIColor *)color
{
    _changedLable.textColor = color;
}

- (void)addLoadingAnimation
{
    
//    [_loadingLayer removeAnimationForKey:@"animationProgress"];
//    
//    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"progress"];
//    animation.fromValue = @0;
//    animation.toValue = @1.0;
//    animation.duration = 0.5;
//    animation.removedOnCompletion = NO;
//    animation.autoreverses = YES;
//    animation.repeatCount  = LONG_MAX;
//    animation.fillMode = kCAFillModeBoth;
//    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//    
//    [_loadingLayer addAnimation:animation forKey:@"animationProgress"];
}

@end


@implementation CameraLoadingLayer

+ (BOOL)needsDisplayForKey:(NSString *)key
{
    if ([key isEqualToString:@"progress"]) {
        return YES;
    }
    return [super needsDisplayForKey:key];
}

- (void)drawInContext:(CGContextRef)ctx
{
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    CGFloat radius = MIN(CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds)) / 2-7;
    CGPoint center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    
        // O
    CGFloat originStart = M_PI;
    CGFloat originEnd = M_PI * (1-0.88*self.progress);
    
        // D
    CGFloat destStart = 0;
    CGFloat destEnd = - M_PI * 0.88 * self.progress;
    
    [path addArcWithCenter:center radius:radius startAngle:originStart endAngle:originEnd clockwise:NO];
    
    UIBezierPath *path2 = [UIBezierPath bezierPath];
    [path2 addArcWithCenter:center radius:radius startAngle:destStart endAngle:destEnd clockwise:NO];
    
    [path appendPath:path2];
    
    CGContextAddPath(ctx, path.CGPath);
    CGContextSetLineWidth(ctx, 3.0);
    CGContextSetLineCap(ctx, kCGLineCapRound);
    CGContextSetLineJoin(ctx, kCGLineJoinRound);
    CGContextSetStrokeColorWithColor(ctx, kNormalBlueColor.CGColor);
    CGContextStrokePath(ctx);
    
}

@end
