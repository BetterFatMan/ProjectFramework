//
//  ShareActivity.h
//  Line0new
//
//  Created by user on 14-9-1.
//  Copyright (c) 2014年 com.line0. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ShareActivityDelegate <NSObject>
- (void)didClickOnImageIndex:(NSInteger)imageIndex;
@end

@interface ShareActivity : UIView
- (id)initWithTitle:(NSString *)title delegate:(id<ShareActivityDelegate>)delegate cancelButtonTitle:(NSString *)cancelButtonTitle ShareButtonTitles:(NSArray *)shareButtonTitlesArray withShareButtonImagesName:(NSArray *)shareButtonImagesNameArray;
- (void)showInView:(UIView *)view;

- (void)showInView:(UIView *)view isSub:(BOOL)isAddSub;

@end
