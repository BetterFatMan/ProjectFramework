//
//  UIImageView+ZZAttributeLable.m
//  YooMath
//
//  Created by Elanking_MacMini on 16/7/29.
//  Copyright © 2016年 ZhangLei. All rights reserved.
//

#import "UIImageView+ZZAttributeLable.h"
#import <objc/runtime.h>

@implementation UIImageView (ZZAttributeLable)

- (NSString *)imageUrl
{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setImageUrl:(NSString *)imageUrl
{
    objc_setAssociatedObject(self, @selector(imageUrl), imageUrl, OBJC_ASSOCIATION_COPY);
}

@end
