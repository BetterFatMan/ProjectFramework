//
//  INLINEMacros.h
//  ProjectFramework
//
//  Created by ElanKing on 2017/11/24.
//  Copyright © 2017年 ElanKing. All rights reserved.
//

#ifndef INLINEMacros_h
#define INLINEMacros_h

#import <UIKit/UIKit.h>

    //简单的以AlertView显示提示信息
#define mAlertView(title, msg) \
if((msg).length)\
{\
UIAlertView *alert = [[UIAlertView alloc] initWithTitle:(title) message:(msg) delegate:nil \
cancelButtonTitle:@"确定" otherButtonTitles:nil]; \
[alert show];\
}

    //简单的以AlertView显示提示信息
#define mAlertViewWithBtn(title, msg, btn) \
if((msg).length)\
{\
UIAlertView *alert = [[UIAlertView alloc] initWithTitle:(title) message:(msg) delegate:nil \
cancelButtonTitle:(btn) otherButtonTitles:nil]; \
[alert show];\
}

/** 直接传入精度丢失有问题的Double类型*/
UIKIT_STATIC_INLINE NSString *decimalNumberWithDouble(double conversionValue){
    NSString *doubleString        = [NSString stringWithFormat:@"%lf", conversionValue];
    NSDecimalNumber *decNumber    = [NSDecimalNumber decimalNumberWithString:doubleString];
    return [decNumber stringValue];
}

UIKIT_STATIC_INLINE void AppOpenUrlScheme(NSString *scheme)
{
    UIApplication *application = [UIApplication sharedApplication];
    NSURL *URL = [NSURL URLWithString:scheme];
    
    if ([application respondsToSelector:@selector(openURL:options:completionHandler:)]) {
        [application openURL:URL options:@{} completionHandler:nil];
    } else {
        [application openURL:URL];
    }
}

/*－－－－－－－－－－－－－－－－－－－－－－－－常用内联函数定义－－－－－－－－－－－－－－－－－－*/
UIKIT_STATIC_INLINE CGSize getStringSize(NSString *str, UIFont *font, CGSize containSize)
{
    if (!str || !font || ![str isKindOfClass:[NSString class]])
        {
        return CGSizeMake(0, 0);
        }
    
    NSDictionary *attribute = @{NSFontAttributeName: font};
    NSStringDrawingOptions option = (NSStringDrawingOptions)(NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading);
    CGSize size = [str boundingRectWithSize:containSize options:option attributes:attribute context:nil].size;
    return size;
}


UIKIT_STATIC_INLINE CGSize getStringSizeByBreakMode(NSString *str, UIFont *font, CGSize containSize, NSLineBreakMode lineBreakMode)
{
    if (!str || !font || ![str isKindOfClass:[NSString class]])
        {
        return CGSizeMake(0, 0);
        }
        //设置段落模式
    NSMutableParagraphStyle *paragraph = [NSMutableParagraphStyle new];
    paragraph.lineBreakMode = lineBreakMode;
    
    NSDictionary *attribute = @{NSFontAttributeName: font, NSParagraphStyleAttributeName: paragraph};
    NSStringDrawingOptions option = (NSStringDrawingOptions)(NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading);
    CGSize size = [str boundingRectWithSize:containSize options:option attributes:attribute context:nil].size;
    
    return size;
}

    /// 加载网路图片，通过服务器裁剪图片尺寸
UIKIT_STATIC_INLINE NSString *trimImageSize(NSString *imageUrl)
{
    if (![imageUrl isKindOfClass:[NSString class]])
        {
        imageUrl = [NSString stringWithFormat:@"%@",imageUrl];
        }
    return [NSString stringWithFormat:@"%@_300x.jpg",imageUrl];
}

UIKIT_STATIC_INLINE NSDictionary *caculateHourMinSecStr(double timedate)
{
    NSString *secStr,*minStr,*hourStr;
    
    long hour = timedate/3600;
    long min  = timedate/60 - hour*60;
    long sec  = timedate - min*60 - hour*3600;
    
    if (sec < 10)
        {
        secStr = [NSString stringWithFormat:@"0%ld",sec];
        }
    else
        {
        secStr = [NSString stringWithFormat:@"%ld",sec];
        }
    if (min < 10)
        {
        minStr = [NSString stringWithFormat:@"0%ld",min];
        }
    else
        {
        minStr = [NSString stringWithFormat:@"%ld",min];
        }
    if (hour < 10)
        {
        hourStr = [NSString stringWithFormat:@"0%ld",hour];
        }
    else
        {
        hourStr = [NSString stringWithFormat:@"%ld", (hour > 23 ? 23 : hour)];
        }
    NSString *time = [NSString stringWithFormat:@"%@:%@:%@",hourStr, minStr, secStr];
    NSString *minTime = [NSString stringWithFormat:@"%@:%@", minStr, secStr];
    return @{@"hour" : hourStr, @"min" : minStr, @"sec" : secStr, @"time":time, @"minTime":minTime };
}

UIKIT_STATIC_INLINE NSDateFormatter *timeFormatter_HH()
{
    static NSDateFormatter *timeFormatter = nil;
    timeFormatter = timeFormatter ? : [NSDateFormatter new];
    timeFormatter.dateFormat       = @"HH";
    return timeFormatter;
}

UIKIT_STATIC_INLINE NSDateFormatter *timeFormatter_HHmmss()
{
    static NSDateFormatter *timeFormatter = nil;
    timeFormatter = timeFormatter ? : [NSDateFormatter new];
    timeFormatter.dateFormat       = @"HH:mm:ss";
    return timeFormatter;
}

UIKIT_STATIC_INLINE NSDateFormatter *dateFormatter_yyyyMMdd()
{
    static NSDateFormatter *dataFormatter = nil;
    dataFormatter = dataFormatter ? : [NSDateFormatter new];
    dataFormatter.dateFormat       = @"yyyy-MM-dd";
    return dataFormatter;
}

UIKIT_STATIC_INLINE NSDateFormatter *dateFormatter_yyyy()
{
    static NSDateFormatter *dataFormatter = nil;
    dataFormatter = dataFormatter ? : [NSDateFormatter new];
    dataFormatter.dateFormat       = @"yyyy";
    return dataFormatter;
}

UIKIT_STATIC_INLINE BOOL showSameYearWithCurrentYear(double showTime)
{
    NSString *currentYear = [dateFormatter_yyyy() stringFromDate:[NSDate date]];
    NSString *showYear = [dateFormatter_yyyy() stringFromDate:[NSDate dateWithTimeIntervalSince1970:showTime]];
    
    return [currentYear isEqualToString:showYear];
}

UIKIT_STATIC_INLINE NSDateFormatter *dateFormatter_MMdd()
{
    static NSDateFormatter *dataFormatter = nil;
    dataFormatter = dataFormatter ? : [NSDateFormatter new];
    dataFormatter.dateFormat       = @"MM-dd";
    return dataFormatter;
}

UIKIT_STATIC_INLINE NSDateFormatter *dateFormatter_MMddHHmm()
{
    static NSDateFormatter *dataFormatter = nil;
    dataFormatter = dataFormatter ? : [NSDateFormatter new];
    dataFormatter.dateFormat       = @"MM-dd HH:mm";
    return dataFormatter;
}

UIKIT_STATIC_INLINE NSDateFormatter *dateFormatter_HHmm()
{
    static NSDateFormatter *dataFormatter = nil;
    dataFormatter = dataFormatter ? : [NSDateFormatter new];
    dataFormatter.dateFormat       = @"HH:mm";
    return dataFormatter;
}

UIKIT_STATIC_INLINE NSDateFormatter *dateFormatter_yyyyMMddHHmm()
{
    static NSDateFormatter *dataFormatter = nil;
    dataFormatter = dataFormatter ? : [NSDateFormatter new];
    dataFormatter.dateFormat       = @"yyyy-MM-dd HH:mm";
    return dataFormatter;
}

UIKIT_STATIC_INLINE NSDateFormatter *dateFormatter_yyyyMMddHHmmss()
{
    static NSDateFormatter *dataFormatter = nil;
    dataFormatter = dataFormatter ? : [NSDateFormatter new];
    dataFormatter.dateFormat       = @"yyyy-MM-dd HH:mm:ss";
    return dataFormatter;
}

UIKIT_STATIC_INLINE NSString *handelShowHomeworkTimeInfo(double showTime)
{
    if (showSameYearWithCurrentYear(showTime)) {
        return [dateFormatter_MMddHHmm() stringFromDate:[NSDate dateWithTimeIntervalSince1970:showTime]];
    }
    return [dateFormatter_yyyyMMddHHmm() stringFromDate:[NSDate dateWithTimeIntervalSince1970:showTime]];
}

#endif /* INLINEMacros_h */
