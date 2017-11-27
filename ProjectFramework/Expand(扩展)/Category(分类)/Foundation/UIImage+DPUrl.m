//
//  UIImage+DPUrl.m
//  YMTeacher
//
//  Created by elanking on 2017/9/28.
//  Copyright © 2017年 ZhangLei. All rights reserved.
//

#import "UIImage+DPUrl.h"

@implementation UIImage (DPUrl)

// 获取html字符串中所有的图片地址
+ (NSArray *)filterImage:(NSString *)htmlString {
    
    NSMutableArray *resultArray = [NSMutableArray array];
    
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"<(img|IMG)(.*?)(/>|></img>|>)" options:NSRegularExpressionAllowCommentsAndWhitespace error:nil];
    NSArray *result = [regex matchesInString:htmlString options:NSMatchingReportCompletion range:NSMakeRange(0, htmlString.length)];
    
    for (NSTextCheckingResult *item in result) {
        NSString *imgHtml = [htmlString substringWithRange:[item rangeAtIndex:0]];
        
        NSArray *tmpArray = nil;
        if ([imgHtml rangeOfString:@"src=\""].location != NSNotFound) {
            tmpArray = [imgHtml componentsSeparatedByString:@"src=\""];
        } else if ([imgHtml rangeOfString:@"src="].location != NSNotFound) {
            tmpArray = [imgHtml componentsSeparatedByString:@"src="];
        }
        
        if (tmpArray.count >= 2) {
            
            NSString *src = tmpArray[1];
            
            NSUInteger loc = [src rangeOfString:@"\""].location;
            if (loc != NSNotFound) {
                src = [src substringToIndex:loc];
                [resultArray addObject:src];
            }
        }
    }
    
    return resultArray;
}

@end
