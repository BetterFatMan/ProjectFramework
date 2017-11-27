//
//  DataBaseControl.h
//  ProjectFramework
//
//  Created by ElanKing on 2017/11/27.
//  Copyright © 2017年 ElanKing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataBaseControl : NSObject

+ (instancetype)shareInstance;

    /// 创建缓存数据库
- (void)createDatabase;

@end
