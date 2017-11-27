//
//  Created by 振东 何 on 12-6-8.
//  Copyright (c) 2012年 开趣. All rights reserved.
//

#import "RegularExpression.h"

@implementation RegularExpression

+ (BOOL)isValidateEmail:(NSString *)string
{
    NSString *regex = @"\\b([a-zA-Z0-9%_.+\\-]+)@([a-zA-Z0-9.\\-]+?\\.[a-zA-Z]{2,6})\\b";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:string];
}

+ (BOOL)isNumber:(NSString *)string
{
    NSString *regex = @"^[0-9]*$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:string];
}

+ (BOOL)isEnglishWords:(NSString *)string
{
    NSString *regex = @"^[A-Za-z]+$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:string];
}

//^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{8,16}$
+ (BOOL)isValidateUserName:(NSString *)string
{
    NSString *regex = @"^[\\w\\d_\u4e00-\u9fa5]{2,16}$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    if ([predicate evaluateWithObject:string])
    {
        NSInteger count = 0;
        
        NSString *regex1 = @"^[a-zA-Z_0-9]+$";
        NSPredicate *predicate1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex1];
        
        NSString *regex2 = @"^[\u4e00-\u9fa5]$";
        NSPredicate *predicate2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex2];
        
        for (int i = 0; i < string.length; i ++) {
            NSString *cha = [string substringWithRange:NSMakeRange(i, 1)];
            if ([predicate1 evaluateWithObject:cha]) {
                count ++;
            }
            if ([predicate2 evaluateWithObject:cha]) {
                count += 2;
            }
        }
        if (count >= 4 && count <= 16) {
            return YES;
        }
    }
    return NO;
}

+ (BOOL)isValidatePasswordAnswer:(NSString *)string
{
    NSString *regex = @"^[a-zA-Z_0-9\u4e00-\u9fa5]+$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    if ([predicate evaluateWithObject:string])
    {
        NSInteger count = 0;
        
        NSString *regex1 = @"^[a-zA-Z_0-9]+$";
        NSPredicate *predicate1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex1];
        
        NSString *regex2 = @"^[\u4e00-\u9fa5]$";
        NSPredicate *predicate2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex2];
        
        for (int i = 0; i < string.length; i ++) {
            NSString *cha = [string substringWithRange:NSMakeRange(i, 1)];
            if ([predicate1 evaluateWithObject:cha]) {
                count ++;
            }
            if ([predicate2 evaluateWithObject:cha]) {
                count += 2;
            }
        }
        if (count > 3 && count <= 38) {
            return YES;
        }
    }
    
    return NO;
}

+ (BOOL)isValidateUserTrueName:(NSString *)string
{
    NSString *regex = @"^[a-zA-Z\u4e00-\u9fa5]+$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    if ([predicate evaluateWithObject:string])
    {
        NSInteger count = 0;
        
        NSString *regex1 = @"^[a-zA-Z]+$";
        NSPredicate *predicate1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex1];
        
        NSString *regex2 = @"^[\u4e00-\u9fa5]$";
        NSPredicate *predicate2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex2];
        
        for (int i = 0; i < string.length; i ++) {
            NSString *cha = [string substringWithRange:NSMakeRange(i, 1)];
            if ([predicate1 evaluateWithObject:cha]) {
                count ++;
            }
            if ([predicate2 evaluateWithObject:cha]) {
                count += 1;
            }
        }
        if (count > 0 && count <= 15) {
            return YES;
        }
    }
    
    return NO;
}

+ (BOOL)isValidateUserPassword:(NSString *)string
{
    NSString *regex = @"[^\u4e00-\u9fa5]{6,16}$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:string];
}

//字母数字下划线，6－16位
+ (BOOL)isValidatePassword:(NSString *)string
{
    NSString *regex = @"^[\\w\\d_.]{6,16}$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:string];
}

+ (BOOL)isChineseWords:(NSString *)string
{
    NSString *regex = @"^[\u4e00-\u9fa5],{0,}$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:string];
}

+ (BOOL)isInternetUrl:(NSString *)string
{
    NSString *regex = @"^http://([\\w-]+\\.)+[\\w-]+(/[\\w-./?%&=]*)?$ ；^[a-zA-z]+://(w+(-w+)*)(.(w+(-w+)*))*(?S*)?$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:string];
}

+ (BOOL)isMobileNumber:(NSString *)string
{
    NSString *regex = @"^((13|15|18|14|17|19)+\\d{9})$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:string];
}

+ (BOOL)isElevenDigitNum:(NSString *)string
{
    NSString *regex = @"^[0-9]*$";
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL result = [predicate evaluateWithObject:string];

    if (result && string.length == 11)
        return YES;

    return NO;
}

+ (BOOL)isIdentifyCardNumber:(NSString *)string
{
    NSString *regex = @"^\\d{15}|\\d{}18$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:string];
}

+ (BOOL)isQQCode:(NSString *)string
{
    NSString *regex = @"^[0-9]{5,15}$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:string];
}

@end
