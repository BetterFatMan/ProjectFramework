//
//  BaseNavigationController.m
//  Line0new
//
//  Created by line0 on 15/6/4.
//  Copyright (c) 2015年 com.line0. All rights reserved.
//

#import "BaseNavigationController.h"
#import "NavigationInteractiveTransition.h"

#import "HWorkRegulatorVC.h"

@interface BaseNavigationController () <UIGestureRecognizerDelegate>
@property (nonatomic, weak) UIPanGestureRecognizer *popRecognizer;
/**
 *  方案一不需要的变量
 */
@property (nonatomic, strong) NavigationInteractiveTransition *navT;
@end

@implementation BaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIGestureRecognizer *gesture = self.interactivePopGestureRecognizer;
    gesture.enabled = NO;
    UIView *gestureView = gesture.view;
    
    UIScreenEdgePanGestureRecognizer *popRecognizer = [[UIScreenEdgePanGestureRecognizer alloc] init];
    popRecognizer.delegate = self;
    popRecognizer.edges = UIRectEdgeLeft;
    popRecognizer.maximumNumberOfTouches = 1;
    [gestureView addGestureRecognizer:popRecognizer];

    
    _navT = [[NavigationInteractiveTransition alloc] initWithViewController:self];
    [popRecognizer addTarget:_navT action:@selector(handleControllerPop:)];
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    /**
     *  这里有两个条件不允许手势执行，1、当前控制器为根控制器；2、如果这个push、pop动画正在执行（私有属性）
     */
    
    UIViewController *controller = [self.viewControllers lastObject];
    
    return self.viewControllers.count != 1 && ![[self valueForKey:@"_isTransitioning"] boolValue] && ![controller isKindOfClass:[HWorkRegulatorVC class]];
}

@end
