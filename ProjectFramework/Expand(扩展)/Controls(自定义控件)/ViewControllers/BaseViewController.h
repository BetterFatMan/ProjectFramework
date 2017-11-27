//
//  BaseViewController.h
//  ProjectFramework
//
//  Created by ElanKing on 2017/11/27.
//  Copyright © 2017年 ElanKing. All rights reserved.
//  所有controller的基类

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseViewController : UIViewController

@property(nonatomic, strong) UIView     *navView;
@property(nonatomic, strong, nullable) UIButton   *leftBtn;
@property(nonatomic, strong, nullable) UILabel    *titleLab;

- (void)clickBackButton:(UIButton *)sender;

@end

NS_ASSUME_NONNULL_END
