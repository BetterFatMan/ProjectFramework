//
//  ColorOrFontMacros.h
//  ProjectFramework
//
//  Created by ElanKing on 2017/11/27.
//  Copyright © 2017年 ElanKing. All rights reserved.
//

#ifndef ColorOrFontMacros_h
#define ColorOrFontMacros_h

/*--------------------------设计app默认字体和颜色------------------------*/

#define UICOLOR_RGB(R,G,B)          ([UIColor colorWithRed:(R)/255.0f green:(G)/255.0f blue:(B)/255.0f alpha:1])
#define UICOLOR_RGBA(R,G,B,A)       ([UIColor colorWithRed:(R)/255.0f green:(G)/255.0f blue:(B)/255.0f alpha:(A)])
#define UICOLOR_RGBDigital(RGB)     ([UIColor colorWithRed:((float)((RGB & 0xFF0000) >> 16))/255.0 green:((float)((RGB & 0xFF00) >> 8))/255.0 blue:((float)(RGB & 0xFF))/255.0 alpha:1.0])

    /// 全局线框颜色
#define kLineGrayColor          (UICOLOR_RGB(0xc8, 0xc7, 0xcc))
#define kLineLightGrayColor     (UICOLOR_RGB(0xee, 0xee, 0xee))

#define kNormalBlueColor        UICOLOR_RGB(0x1a, 0x88, 0xe6)
#define kLinkBlueColor          UICOLOR_RGB(0x00, 0x7a, 0xff)
#define kBeSameBlueColor        UICOLOR_RGB(0x2a, 0xb7, 0xf7)

#define kNormalBlueAlphaColor   UICOLOR_RGBA(0x1a, 0x88, 0xe6, 0.7)
#define kNormalRedColor         UICOLOR_RGBA(0xff,0xff,0xff,0.7)
#define kNormalOringeColor      UICOLOR_RGB(0xec, 0x69, 0x41)
#define kNormalGreenColor       UICOLOR_RGB(0x4c, 0xc0, 0xb9)
#define kNormalYellowColor      UICOLOR_RGB(0xfe, 0xa7, 0x00)

    /// 作业的状态
#define kHomeworkStatusRed      UICOLOR_RGB(0xF1, 0x4b, 0x40)
#define kHomeworkStatusBlue     UICOLOR_RGB(0x1a, 0xa1, 0xe6)
#define kHomeworkStatusGreen    UICOLOR_RGB(0x00, 0xbb, 0x9d)
#define kHomeworkStatusGray     UICOLOR_RGB(0xd3, 0xdd, 0xe5)

    /// 作业的结果统计
#define kHomeworkResultGreat    UICOLOR_RGB(0x00, 0xbb, 0x9d)
#define kHomeworkResultWell     UICOLOR_RGB(0x7d, 0xca, 0x60)
#define kHomeworkResultOK       UICOLOR_RGB(0xf8, 0xc4, 0x38)
#define kHomeworkResultBad      UICOLOR_RGB(0xf1, 0x4b, 0x40)

    /// 题目的结果统计
#define kQuestionResultRight    UICOLOR_RGB(0x00, 0xbb, 0x9d)
#define kQuestionResultHalf     UICOLOR_RGB(0xf8, 0xc4, 0x38)
#define kQuestionResultWrong    UICOLOR_RGB(0xf1, 0x4b, 0x40)

#define kLightGreenColor        UICOLOR_RGB(0x84, 0xc0, 0x4c)
#define kYMRedColor             UICOLOR_RGB(0xd9, 0x00, 0x00)
#define kCoinRedColor           UICOLOR_RGB(0xf1, 0x4b, 0x40)

#define kLightBgColor           UICOLOR_RGB(0xe8, 0xf3, 0xf7)

    // 组卷相关颜色
#define kPaperBlueColor         UICOLOR_RGB(0x1a, 0xa1, 0xe6)
#define kPaperGreenColor        UICOLOR_RGB(0x7d, 0xca, 0x60)

#define kLBBlackColor           UICOLOR_RGB(0x38, 0x3d, 0x4b)
#define kLBlackColor            UICOLOR_RGB(0xaf, 0xba, 0xbf)

#define kLLBBlackColor          UICOLOR_RGB(0x83, 0x90, 0x96)

#define kProgressBgColor        UICOLOR_RGB(0xd3, 0xdd, 0xe5)
    /// 答题卡按钮选中
#define kAnswerBtnColor         UICOLOR_RGB(0x37, 0x84, 0xd3)
    /// 应用的UIView背景色
#define kAppBgColor             UICOLOR_RGB(0xed, 0xed, 0xf3)
    /// 应用的app轻灰色
#define kAppLightBBColor        UICOLOR_RGB(0xd3, 0xdd, 0xe5)

/*--------------------------------字体大小的宏定义--------------------------------------*/

#define gFontNumberHelvetica(X)             [UIFont fontWithName:@"Helvetica" size:(X)]
#define gFontSystemSize(X)                  [UIFont systemFontOfSize:(X)]
#define gBoldFontSysSize(X)                 [UIFont boldSystemFontOfSize:(X)]


#endif /* ColorOrFontMacros_h */
