//
//  UIImage+DPUrl.h
//  YMTeacher
//
//  Created by elanking on 2017/9/28.
//  Copyright © 2017年 ZhangLei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (DPUrl)

// 获取html字符串中所有的图片地址
+ (NSArray *)filterImage:(NSString *)htmlString;

@end
