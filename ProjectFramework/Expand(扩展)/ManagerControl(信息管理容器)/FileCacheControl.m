//
//  FileCacheControl.m
//  Line0new
//
//  Created by trojan on 14-8-21.
//  Copyright (c) 2014年 com.line0. All rights reserved.
//  当前类是文件类型缓存的控制类, 所有文件型缓存的统一管理器

#import "FileCacheControl.h"
//#import "YMActivitysManager.h"
//#import "YMEntranceModel.h"

@implementation FileCacheControl

static FileCacheControl *_instance = nil;
static NSString         *_fileCacheDirectory = nil;
static NSString         *_baseNameSpace = nil;

+ (void)initialize
{
    _baseNameSpace = @"com.math.filecache";
    _fileCacheDirectory = [NSString stringWithFormat:@"%@/Documents/%@", NSHomeDirectory(), _baseNameSpace];
}

+ (id)allocWithZone:(NSZone *)zone
{
	@synchronized(self)
	{
		if (_instance == nil)
		{
			_instance = [super allocWithZone:zone];
			return _instance;
		}
	}
    
	return nil;
}

- (id)copyWithZone:(NSZone *)zone
{
	return self;
}

+ (instancetype)shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        _instance = [[self alloc] init];
        BOOL isDirectory = NO;
        if (![[NSFileManager defaultManager] fileExistsAtPath:_fileCacheDirectory isDirectory:&isDirectory] && !isDirectory)
        {
            NSError *err = nil;
            [[NSFileManager defaultManager] createDirectoryAtPath:_fileCacheDirectory withIntermediateDirectories:YES attributes:nil error:&err];
            if (err)
            {
                NSLog(@"注意: 创建文件缓存目录(%@)失败 错误信息: %@", _fileCacheDirectory, err);
            }
        }
    });
    return _instance;
}

    /// 设置文件缓存的目录, 所有文件缓存都将在此目录下
+ (void)fileCacheNameSpace:(NSString *)ns
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        _fileCacheDirectory = [NSString stringWithFormat:@"%@.%@", _fileCacheDirectory, ns];
    });
}

    /// 清除所有文件缓存
+ (void)cleanFileCache
{
    BOOL isDirectory = NO;
    if ([[NSFileManager defaultManager] fileExistsAtPath:_fileCacheDirectory isDirectory:&isDirectory] && isDirectory)
    {
        NSError *err = nil;
        [[NSFileManager defaultManager] removeItemAtPath:_fileCacheDirectory error:&err];
        if (err)
        {
            NSLog(@"注意: 清除所有文件缓存时删除文件缓存目录(%@)失败 错误信息: %@", _fileCacheDirectory, err);
        }
        
        [[NSFileManager defaultManager] createDirectoryAtPath:_fileCacheDirectory withIntermediateDirectories:YES attributes:nil error:&err];
        if (err)
        {
            NSLog(@"注意: 清除所有文件缓存时重新创建文件缓存目录(%@)失败 错误信息: %@", _fileCacheDirectory, err);
        }
    }
}


//- (STUTBCateEntity *)cacheCateEntity
//{
//    NSString *cacheFilePath = [NSString stringWithFormat:@"%@/cacheCateEntity.cache",_fileCacheDirectory];
//    if ([[NSFileManager defaultManager] fileExistsAtPath:cacheFilePath])
//    {
//        NSData *cacheData = [NSData dataWithContentsOfFile:cacheFilePath];
//        if (cacheData)
//        {
//            STUTBCateEntity *entity = [NSKeyedUnarchiver unarchiveObjectWithData:cacheData];
//            if ([entity isKindOfClass:[NSObject class]])
//            {
//                return entity;
//            }
//        }
//    }
//    return nil;
//}
//
//- (void)setCacheCateEntity:(STUTBCateEntity *)cacheCateEntity
//{
//    NSString *cacheFilePath = [NSString stringWithFormat:@"%@/cacheCateEntity.cache",_fileCacheDirectory];
//    if ([[NSFileManager defaultManager] fileExistsAtPath:cacheFilePath])
//    {
//        NSError *err = nil;
//        [[NSFileManager defaultManager]removeItemAtPath:cacheFilePath error:&err];
//        if (err)
//        {
//            NSLog(@"注意: 清除缓存文件(%@)失败 错误信息: %@", cacheFilePath, err);
//        }
//    }
//
//    if (cacheCateEntity)
//    {
//        NSData *cacheData = [NSKeyedArchiver archivedDataWithRootObject:cacheCateEntity];
//        BOOL isSuccess = NO;
//        if (cacheData)
//        {
//            isSuccess = [cacheData writeToFile:cacheFilePath atomically:YES];
//        }
//        if (!isSuccess)
//        {
//            NSLog(@"注意: 写入缓存文件(%@)失败", cacheFilePath);
//        }
//    }
//}
//
//- (UserEntity *)cacheUserEntity
//{
//    NSString *cacheFilePath = [NSString stringWithFormat:@"%@/cacheUserEntity.cache",_fileCacheDirectory];
//    if ([[NSFileManager defaultManager] fileExistsAtPath:cacheFilePath])
//    {
//        NSData *cacheData = [NSData dataWithContentsOfFile:cacheFilePath];
//        if (cacheData)
//        {
//            UserEntity *entity = [NSKeyedUnarchiver unarchiveObjectWithData:cacheData];
//            if ([entity isKindOfClass:[NSObject class]])
//            {
//                return entity;
//            }
//        }
//    }
//    return nil;
//}
//
//- (void)setCacheUserEntity:(UserEntity *)cacheUserEntity
//{
//    NSString *cacheFilePath = [NSString stringWithFormat:@"%@/cacheUserEntity.cache",_fileCacheDirectory];
//    if ([[NSFileManager defaultManager] fileExistsAtPath:cacheFilePath])
//    {
//        NSError *err = nil;
//        [[NSFileManager defaultManager]removeItemAtPath:cacheFilePath error:&err];
//        if (err)
//        {
//            NSLog(@"注意: 清除缓存文件(%@)失败 错误信息: %@", cacheFilePath, err);
//        }
//    }
//
//    if (cacheUserEntity)
//    {
//        NSData *cacheData = [NSKeyedArchiver archivedDataWithRootObject:cacheUserEntity];
//        BOOL isSuccess = NO;
//        if (cacheData)
//        {
//            isSuccess = [cacheData writeToFile:cacheFilePath atomically:YES];
//        }
//        if (!isSuccess)
//        {
//            NSLog(@"注意: 写入缓存文件(%@)失败", cacheFilePath);
//        }
//    }
//}
//
//- (NSArray *)cacheWordTypeList
//{
//    NSString *cacheFilePath = [NSString stringWithFormat:@"%@/cacheWordTypeList.cache", _fileCacheDirectory];
//    if ([[NSFileManager defaultManager] fileExistsAtPath:cacheFilePath])
//    {
//        NSData *cacheData = [NSData dataWithContentsOfFile:cacheFilePath];
//        if (cacheData)
//        {
//            NSArray *msgArr = [NSKeyedUnarchiver unarchiveObjectWithData:cacheData];
//            if ([msgArr isKindOfClass:[NSArray class]])
//            {
//                return msgArr;
//            }
//        }
//    }
//    return nil;
//}
//
//- (void)setCacheWordTypeList:(NSMutableArray *)cacheWordTypeList
//{
//    NSString *cacheFilePath = [NSString stringWithFormat:@"%@/cacheWordTypeList.cache", _fileCacheDirectory];
//    if ([[NSFileManager defaultManager] fileExistsAtPath:cacheFilePath])
//    {
//        NSError *err = nil;
//        [[NSFileManager defaultManager] removeItemAtPath:cacheFilePath error:&err];
//        if (err)
//        {
//            NSLog(@"注意: 清除缓存文件(%@)失败 错误信息: %@", cacheFilePath, err);
//        }
//    }
//
//    if (cacheWordTypeList)
//    {
//        NSData *cacheData = [NSKeyedArchiver archivedDataWithRootObject:cacheWordTypeList];
//        BOOL isSuccess = NO;
//        if (cacheData)
//        {
//            isSuccess = [cacheData writeToFile:cacheFilePath atomically:YES];
//        }
//        if (!isSuccess)
//        {
//            NSLog(@"注意: 写入缓存文件(%@)失败", cacheFilePath);
//        }
//    }
//}
//
//- (YMActivityEntity *)cacheActivityEntity
//{
//    NSString *cacheFilePath = [NSString stringWithFormat:@"%@/cacheActivityEntity.cache",_fileCacheDirectory];
//    if ([[NSFileManager defaultManager] fileExistsAtPath:cacheFilePath])
//    {
//        NSData *cacheData = [NSData dataWithContentsOfFile:cacheFilePath];
//        if (cacheData)
//        {
//            YMActivityEntity *entity = [NSKeyedUnarchiver unarchiveObjectWithData:cacheData];
//            if ([entity isKindOfClass:[NSObject class]])
//            {
//                return entity;
//            }
//        }
//    }
//    return nil;
//}
//
//- (void)setCacheActivityEntity:(YMActivityEntity *)cacheActivityEntity
//{
//    NSString *cacheFilePath = [NSString stringWithFormat:@"%@/cacheActivityEntity.cache",_fileCacheDirectory];
//    if ([[NSFileManager defaultManager] fileExistsAtPath:cacheFilePath])
//    {
//        NSError *err = nil;
//        [[NSFileManager defaultManager]removeItemAtPath:cacheFilePath error:&err];
//        if (err)
//        {
//            NSLog(@"注意: 清除缓存文件(%@)失败 错误信息: %@", cacheFilePath, err);
//        }
//    }
//
//    if (cacheActivityEntity)
//    {
//        NSData *cacheData = [NSKeyedArchiver archivedDataWithRootObject:cacheActivityEntity];
//        BOOL isSuccess = NO;
//        if (cacheData)
//        {
//            isSuccess = [cacheData writeToFile:cacheFilePath atomically:YES];
//        }
//        if (!isSuccess)
//        {
//            NSLog(@"注意: 写入缓存文件(%@)失败", cacheFilePath);
//        }
//    }
//}
//
//- (YMEntranceModel *)cachePreloadingImageModel
//{
//    NSString *cacheFilePath = [NSString stringWithFormat:@"%@/cachePreloadingImageModel.cache",_fileCacheDirectory];
//    if ([[NSFileManager defaultManager] fileExistsAtPath:cacheFilePath]) {
//        NSData *cacheData = [NSData dataWithContentsOfFile:cacheFilePath];
//        if (cacheData) {
//            YMEntranceModel *entity = [NSKeyedUnarchiver unarchiveObjectWithData:cacheData];
//            if ([entity isKindOfClass:[YMEntranceModel class]]) {
//                return entity;
//            }
//        }
//    }
//    return nil;
//}
//
//- (void)setCachePreloadingImageModel:(YMEntranceModel *)cachePreloadingImageModel
//{
//    NSString *cacheFilePath = [NSString stringWithFormat:@"%@/cachePreloadingImageModel.cache",_fileCacheDirectory];
//    if ([[NSFileManager defaultManager] fileExistsAtPath:cacheFilePath]) {
//        NSError *err = nil;
//        [[NSFileManager defaultManager]removeItemAtPath:cacheFilePath error:&err];
//        if (err) {
//            NSLog(@"注意: 清除缓存文件(%@)失败 错误信息: %@", cacheFilePath, err);
//        }
//    }
//
//    if (cachePreloadingImageModel) {
//        NSData *cacheData = [NSKeyedArchiver archivedDataWithRootObject:cachePreloadingImageModel];
//        BOOL isSuccess = NO;
//        if (cacheData) {
//            isSuccess = [cacheData writeToFile:cacheFilePath atomically:YES];
//        }
//        if (!isSuccess) {
//            NSLog(@"注意: 写入缓存文件(%@)失败", cacheFilePath);
//        }
//    }
//}
//
//- (NSArray *)cacheWaitIssueHomeworkIdList
//{
//    NSString *cacheFilePath = [NSString stringWithFormat:@"%@/cacheWaitIssueHomeworkIdList.cache",_fileCacheDirectory];
//    if ([[NSFileManager defaultManager] fileExistsAtPath:cacheFilePath]) {
//        NSData *cacheData = [NSData dataWithContentsOfFile:cacheFilePath];
//        if (cacheData) {
//            NSArray *entity = [NSKeyedUnarchiver unarchiveObjectWithData:cacheData];
//            if ([entity isKindOfClass:[NSArray class]]) {
//                return entity;
//            }
//        }
//    }
//    return nil;
//}
//
//- (void)setCacheWaitIssueHomeworkIdList:(NSArray *)cacheWaitIssueHomeworkIdList
//{
//    NSString *cacheFilePath = [NSString stringWithFormat:@"%@/cacheWaitIssueHomeworkIdList.cache",_fileCacheDirectory];
//    if ([[NSFileManager defaultManager] fileExistsAtPath:cacheFilePath]) {
//        NSError *err = nil;
//        [[NSFileManager defaultManager]removeItemAtPath:cacheFilePath error:&err];
//        if (err) {
//            NSLog(@"注意: 清除缓存文件(%@)失败 错误信息: %@", cacheFilePath, err);
//        }
//    }
//
//    if (cacheWaitIssueHomeworkIdList) {
//        NSData *cacheData = [NSKeyedArchiver archivedDataWithRootObject:cacheWaitIssueHomeworkIdList];
//        BOOL isSuccess = NO;
//        if (cacheData) {
//            isSuccess = [cacheData writeToFile:cacheFilePath atomically:YES];
//        }
//        if (!isSuccess) {
//            NSLog(@"注意: 写入缓存文件(%@)失败", cacheFilePath);
//        }
//    }
//}
//
//- (NSDictionary *)cacheUserCenterUrlInfo
//{
//    NSString *cacheFilePath = [NSString stringWithFormat:@"%@/cacheUserCenterUrlInfo.cache",_fileCacheDirectory];
//    if ([[NSFileManager defaultManager] fileExistsAtPath:cacheFilePath]) {
//        NSData *cacheData = [NSData dataWithContentsOfFile:cacheFilePath];
//        if (cacheData) {
//            NSDictionary *entity = [NSKeyedUnarchiver unarchiveObjectWithData:cacheData];
//            if ([entity isKindOfClass:[NSDictionary class]]) {
//                return entity;
//            }
//        }
//    }
//    return nil;
//}
//
//- (void)setCacheUserCenterUrlInfo:(NSDictionary *)cacheUserCenterUrlInfo
//{
//    NSString *cacheFilePath = [NSString stringWithFormat:@"%@/cacheUserCenterUrlInfo.cache",_fileCacheDirectory];
//    if ([[NSFileManager defaultManager] fileExistsAtPath:cacheFilePath]) {
//        NSError *err = nil;
//        [[NSFileManager defaultManager]removeItemAtPath:cacheFilePath error:&err];
//        if (err) {
//            NSLog(@"注意: 清除缓存文件(%@)失败 错误信息: %@", cacheFilePath, err);
//        }
//    }
//
//    if (cacheUserCenterUrlInfo) {
//        NSData *cacheData = [NSKeyedArchiver archivedDataWithRootObject:cacheUserCenterUrlInfo];
//        BOOL isSuccess = NO;
//        if (cacheData) {
//            isSuccess = [cacheData writeToFile:cacheFilePath atomically:YES];
//        }
//        if (!isSuccess) {
//            NSLog(@"注意: 写入缓存文件(%@)失败", cacheFilePath);
//        }
//    }
//}

@end



