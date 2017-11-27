//
//  popAnimation.m
//  UIScreenEdgePanGestureRecognizer
//
//  Created by Jazys on 15/3/25.
//  Copyright (c) 2015年 Jazys. All rights reserved.
//

#import "PopAnimation.h"

@interface PopAnimation ()
@property (nonatomic, strong) id <UIViewControllerContextTransitioning> transitionContext;
@end

@implementation PopAnimation

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext {
    //这个方法返回动画执行的时间
    return 0.35;
}

/**
 *  transitionContext你可以看作是一个工具，用来获取一系列动画执行相关的对象，并且通知系统动画是否完成等功能。
 */
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    /**
     *  获取动画来自的那个控制器
     */
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    /**
     *  获取转场到的那个控制器
     */
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    /**
     *  转场动画是两个控制器视图时间的动画，需要一个containerView来作为一个“舞台”，让动画执行。
     */
    UIView *containerView = [transitionContext containerView];
    [containerView insertSubview:toViewController.view belowSubview:fromViewController.view];
    
    NSTimeInterval duration = [self transitionDuration:transitionContext];

    /**
     *  执行动画，我们让fromVC的视图移动到屏幕最右侧
     */
    
    UIView *shadowView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, toViewController.view.bounds.size.width, toViewController.view.bounds.size.height)];
    shadowView.backgroundColor = UICOLOR_RGBA(0, 0, 0, 0.5);
    
    [toViewController.view addSubview:shadowView];
    
    fromViewController.view.layer.shadowColor = [UIColor blackColor].CGColor;
    fromViewController.view.layer.shadowRadius = 4;
    fromViewController.view.layer.shadowOffset = CGSizeMake(0, 2);
    fromViewController.view.layer.shadowOpacity = 0.6;
    
    [UIView animateWithDuration:duration animations:^{
        fromViewController.view.transform = CGAffineTransformMakeTranslation([UIScreen mainScreen].bounds.size.width, 0);
        shadowView.backgroundColor = [UIColor clearColor];
    }completion:^(BOOL finished) {
        /**
         *  当你的动画执行完成，这个方法必须要调用，否则系统会认为你的其余任何操作都在动画执行过程中。
         */
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
        [shadowView removeFromSuperview];
    }];
    
//    _transitionContext = transitionContext;
//    ----------------pop动画一-------------------------//
    
    CABasicAnimation *toAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
    toAnimation.fromValue = [NSValue valueWithCATransform3D:CATransform3DTranslate(CATransform3DMakeScale(0.90, 0.90, 1.0), 0, 0, -2)];
    toAnimation.toValue   = [NSValue valueWithCATransform3D:CATransform3DTranslate(CATransform3DMakeScale(1.0, 1.0, 1.0), 0, 0, 0)];
    
    
    CABasicAnimation *color = [CABasicAnimation animationWithKeyPath:@"backgroundColor"];
    color.fromValue         = (id)kLLBBlackColor.CGColor;
    color.toValue           = (id)[UIColor whiteColor].CGColor;
    
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.duration  = duration;
    group.fillMode  = kCAFillModeForwards;
    group.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    group.removedOnCompletion = YES;
    group.animations = @[ toAnimation ];
    
    [toViewController.view.layer addAnimation:group forKey:@"toViewControllerAnimation"];
    
}

- (void)animationDidStop:(CATransition *)anim finished:(BOOL)flag {
    [_transitionContext completeTransition:!_transitionContext.transitionWasCancelled];
}
@end
