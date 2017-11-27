//
//  DataBaseControl.m
//  ProjectFramework
//
//  Created by ElanKing on 2017/11/27.
//  Copyright © 2017年 ElanKing. All rights reserved.
//

#import "DataBaseControl.h"
#import "FMDatabaseQueue.h"
#import "FMDatabasePool.h"
#import "FMDatabase.h"

static DataBaseControl *_oneDataBaseControl = nil;

@implementation DataBaseControl

+ (instancetype)shareInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _oneDataBaseControl = [[DataBaseControl alloc] init];
    });
    return _oneDataBaseControl;
}

- (void)createDatabase
{
        ///更新数据库
    FMDatabase *db = [FMDatabase databaseWithPath:kYooMathDBPath];
    if ([db open]) {
        FMDatabaseQueue *queue = [FMDatabaseQueue databaseQueueWithPath:kYooMathDBPath];
        [queue inTransaction:^(FMDatabase *db, BOOL *rollback) {
             // 创建购物车表
//         NSString *sqlKey = @"\
//         exerciseType integer,\
//         exerciseId text, \
//         fileName text,\
//         primary key(exerciseType, exerciseId)";
//         NSString *sql = [NSString stringWithFormat:@"create table if not exists %@ (%@)", kScratchPaperTable, sqlKey];
//         BOOL isSucc3 = [db executeUpdate:sql];
//         if ([db hadError]) {
//             NSLog(@"error:%@", [db lastError]);
//         }
//         
//             // 创建汉子表数据库
//         NSString *othersqlKey = @"chineseKId integer,chinese text, pinyin text,index0 integer,index1 integer, index2 integer, index3 integer, index4 integer, index5 integer, index6 integer, primary key(chineseKId)";
//         
//         NSString *sqlStr = [NSString stringWithFormat:@"create table if not exists %@ (%@)", kChineseDataTable, othersqlKey];
//         BOOL isSucc4 = [db executeUpdate:sqlStr];
//         if ([db hadError]) {
//             NSLog(@"error:%@", [db lastError]);
//            }
         
             /// 只关心新表是否创建成功
//         if (!isSucc3 || !isSucc4) {
//             *rollback = YES;
//             return;
//         }
        }];
    }
    [db close];
}

@end
