//
//  STUErrorReloadView.h
//  YooMath
//
//  Created by Elanking_MacMini on 16/6/22.
//  Copyright © 2016年 ZhangLei. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^reloadRequestBlock)();

@class CameraLoadingView;
@interface STUErrorReloadView : UIView

- (instancetype)initWithFrame:(CGRect)frame name:(NSString *)imageName reloadBlock:(reloadRequestBlock)block;


@property(nonatomic, strong) CameraLoadingView  *loadingView;

- (void)changedErrorTitle;

- (void)changedErrorTitles:(NSString *)info;
- (void)changedErrorTitleColor:(UIColor *)color;

- (void)beginViewLoading;
- (void)endViewLoading;

@end
