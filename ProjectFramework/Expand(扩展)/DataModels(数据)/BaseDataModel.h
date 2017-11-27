//
//  BaseDataModel.h
//  ProjectFramework
//
//  Created by ElanKing on 2017/11/27.
//  Copyright © 2017年 ElanKing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseDataModel : NSObject

    //返回需要序列化与反序列化的当前对象的属性列表
- (NSArray *)serializeProperties;

@end
