//
//  YMHUDSuccessView.h
//  YMTeacher
//
//  Created by Elanking_MacMini on 16/4/11.
//  Copyright © 2016年 ZhangLei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YMHUDSuccessView : UIView

+ (YMHUDSuccessView *)showYMHUDSuccessView:(NSString *)title hideAfterDuration:(CGFloat)duration;

- (void)changeSuccessType:(NSString *)successTitle;

- (void)changeErrorType:(NSString *)errorTitle change:(BOOL)isChanged;

- (void)changedImageSuccess:(NSString *)successTitle;

- (void)hideHUDViewAnimation;

@end



@interface YMHUDSuccessShapeLayer : CAShapeLayer

@property(nonatomic, assign) CGFloat    progress;

@property(nonatomic, strong) NSString   *type;

@end
