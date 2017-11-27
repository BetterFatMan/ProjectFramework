//
//  UIImage+Extension.m
//  GoldVault
//
//  Created by Butterfly on 2017/6/20.
//  Copyright © 2017年 Delame. All rights reserved.
//

#import "UIImage+Extension.h"

@implementation UIImage (Extension)

/**
 *  创建一像素给定颜色的图片
 */
+ (UIImage *)imageFromColor:(UIColor *)color {
    return [UIImage imageFromColor:color size:CGSizeMake(1, 1)];
}

/**
 *  创建给定Size的特定颜色的图片
 */
+ (UIImage *)imageFromColor:(UIColor *)color size:(CGSize)size {
    
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

+ (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size; {
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
    [img drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}

@end
