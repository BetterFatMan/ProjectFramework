//
//  NSDictionary+Extension.h
//  YMTeacher
//
//  Created by Elanking_MacMini on 16/4/7.
//  Copyright © 2016年 ZhangLei. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kNilWhenNSNull(obj)          ((obj) == [NSNull null] ? nil : (obj))

    /// 之所以在NSObject中添加safeBindValue方法是为了在使用时错误的对象实例调用该方法引起crash
@interface NSObject (Extension)

- (id)safeBindValue:(NSString *)key;
- (NSString *)safeBindStringValue:(NSString *)key;

@end

@interface NSDictionary (Extension)

- (id)safeBindValue:(NSString *)key;
- (NSString *)safeBindStringValue:(NSString *)key;

@end
