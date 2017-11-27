//
//  EnumerateHeader.h
//  ProjectFramework
//
//  Created by ElanKing on 2017/11/24.
//  Copyright © 2017年 ElanKing. All rights reserved.
//

#ifndef EnumerateHeader_h
#define EnumerateHeader_h

/**
 页面展示type区别
 
 - YMViewControllerTypeGood: 好题本样式
 - YMViewControllerTypeFlawSweeper: 错题本样式
 */
typedef NS_ENUM(NSInteger, YMViewControllerType) {
    YMViewControllerTypeGood        = 1,
    YMViewControllerTypeFlawSweeper = 2
};

typedef NS_OPTIONS(NSInteger, YMViewControllerAllDireaction) {
    YMViewControllerAllDireactionLeft = 0,
    YMViewControllerAllDireactionRight,
    YMViewControllerAllDireactionTop,
    YMViewControllerAllDireactionBottom
};

typedef NS_ENUM(NSInteger, EnumLoginType) {
    EnumLoginTypeNomal = 0,
    EnumLoginTypeQQ,
    EnumLoginTypeWeiXin
};

#endif /* EnumerateHeader_h */
