//
//  ShareBtnView.h
//  YooMath
//
//  Created by Elanking_MacMini on 15/12/23.
//  Copyright © 2015年 ZhangLei. All rights reserved.
//  分享view修改
/*
 * 2015-12-26 15:19
 *第5个按钮被修改成拷贝功能，可以将字符拷贝至剪贴板
 */

#import <UIKit/UIKit.h>

@protocol ShareBtnViewDelegate <NSObject>

@optional
- (void)didClickShareBtn:(NSInteger)btnIndex;

@end

@interface ShareBtnView : UIView

- (instancetype)initWithFrame:(CGRect)frame
              imagesNameArray:(NSArray *)shareButtonImagesNameArray
                  titlesArray:(NSArray *)shareButtonTitlesArray;

@property(nonatomic, weak) id<ShareBtnViewDelegate> delegate;

@end


@interface ShareButton : UIImageView

@end