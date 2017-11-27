//
//  UIImage+Extension.h
//  GoldVault
//
//  Created by Butterfly on 2017/6/20.
//  Copyright © 2017年 Delame. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (Extension)

/**
 *  创建一像素给定颜色的图片
 */
+ (UIImage *)imageFromColor:(UIColor *)color;

/**
 *  创建给定Size的特定颜色的图片
 */
+ (UIImage *)imageFromColor:(UIColor *)color
                        size:(CGSize)size;

/** 把图片压缩到制定的size*/
+ (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size;

@end

NS_ASSUME_NONNULL_END
