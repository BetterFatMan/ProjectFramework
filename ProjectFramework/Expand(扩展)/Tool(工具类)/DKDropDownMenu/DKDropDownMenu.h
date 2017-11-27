//
//  DKDropDownMenu.h
//  DKDropDownMenu
//
//  Created by 蝴蝶 on 2017/11/9.
//  Copyright © 2017年 butterfly. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class DKDropDownMenu;

@interface DKIndexPath : NSObject

@property (nonatomic, assign) NSInteger column;
@property (nonatomic, assign) NSInteger row;

- (instancetype)initWithColumn:(NSInteger)column row:(NSInteger)row;
+ (instancetype)indexPathWithColumn:(NSInteger)column row:(NSInteger)row;

@end

@interface DKDropDownRowItem : NSObject

@property (nonatomic, nullable, copy) NSString *title;
@property (nonatomic, nullable, strong) UIFont *titleFont;
@property (nonatomic, nullable, strong) UIColor *titleColor;
@property (nonatomic, nullable, strong) UIColor *selectedTitleColor;
@property (nonatomic, assign) BOOL useCoulumTitleWhenSelected;
@property (nonatomic, nullable, copy) NSString *identifier;

@end

@interface DKDropDownCoulumItem : NSObject

@property (nonatomic, nullable, copy) NSString *title;
@property (nonatomic, nullable, strong) UIImage *icon;
@property (nonatomic, nullable, strong) UIImage *selectedIcon;
@property (nonatomic, nullable, copy) NSString *identifier;
@property (nonatomic, assign) NSInteger currentSelectedRow;
@property (nonatomic, assign) BOOL showDropImage;
@property (nonatomic, nullable, strong) UIColor *titleColor;
@property (nonatomic, nullable, strong) UIColor *selectedTitleColor;

@end

@interface DKDropDownCoulumView : UIControl

@property (nonatomic, nullable, strong) UIImage *iconImage;
@property (nonatomic, nullable, strong) UIImage *selectedIconImage;
@property (nonatomic, nullable, copy) NSString *title;
@property (nonatomic, nullable, strong) UIImage *dropupImage;
@property (nonatomic, nullable, strong) UIImage *dropdownImage;
@property (nonatomic, nullable, strong) UIColor *titleColor;
@property (nonatomic, nullable, strong) UIColor *selectedTitleColor;
@property (nonatomic, nullable, strong) UIFont *titleFont;
@property (nonatomic, assign) BOOL dropUp;
@property (nonatomic, assign) BOOL highlightedTitle;

@end


@protocol DKDropDownMenuDelgate <NSObject>

@optional
- (void)dropDownMenu:(DKDropDownMenu *)menu didSelectRowAtIndexPath:(DKIndexPath *)indexPath;
- (void)dropDownMenu:(DKDropDownMenu *)menu didSelectColumn:(NSInteger)column;

@end


@protocol DKDropDownMenuDataSource <NSObject>

@required
- (NSInteger)dropDownMenu:(DKDropDownMenu *)menu
     numberOfRowsInColumn:(NSInteger)column;
- (DKDropDownRowItem *)dropDownMenu:(DKDropDownMenu *)menu
              itemForRowAtIndexPath:(DKIndexPath *)indexPath;
- (DKDropDownCoulumItem *)dropDownMenu:(DKDropDownMenu *)menu
            itemForColumn:(NSInteger)column;

@optional
- (NSInteger)numberOfColumnsInMenu:(DKDropDownMenu *)menu;

@end

@interface DKDropDownMenu : UIView

@property (nonatomic, nullable, weak) id<DKDropDownMenuDelgate> delegate;
@property (nonatomic, nullable, weak) id<DKDropDownMenuDataSource> dataSource;

@property (nonatomic, nullable, strong) UIFont *titleFont;
@property (nonatomic, nullable, strong) UIColor *titleColor;
@property (nonatomic, nullable, strong) UIColor *selectedTitleColor;
@property (nonatomic, nullable, strong) UIImage *dropupImage;
@property (nonatomic, nullable, strong) UIImage *dropdownImage;
@property (nonatomic, nullable, strong) UIColor *separatorColor;

@property (nonatomic, nullable, weak) UIViewController *presentViewController;

- (void)reloadData;
- (void)hiddenDropList;

@end

NS_ASSUME_NONNULL_END
