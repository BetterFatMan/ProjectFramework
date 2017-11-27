//
//  MJYooMathRefreshHeader.h
//  YooMath
//
//  Created by Elanking_MacMini on 16/2/22.
//  Copyright © 2016年 ZhangLei. All rights reserved.
//

#import "MJRefreshNormalHeader.h"

@interface MJYooMathRefreshHeader : MJRefreshStateHeader
@property (weak, nonatomic, readonly) UIImageView *arrowView;
@property(nonatomic, strong) UIImageView        *successImageView;
/** 菊花的样式 */
@property (assign, nonatomic) UIActivityIndicatorViewStyle activityIndicatorViewStyle;

@end
