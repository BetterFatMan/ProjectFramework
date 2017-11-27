//
//  DLMBannerView.h
//  DLMBannerView
//
//  Created by Butterfly on 2017/10/29.
//  Copyright © 2017年 CF. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DLMBannerView;

typedef NS_ENUM(NSInteger, DLMBannerViewScrollDirection) {
    DLMBannerViewScrollDirectionLeft,
    DLMBannerViewScrollDirectionRight
};

NS_ASSUME_NONNULL_BEGIN

@protocol DLMBannerViewDelegate <NSObject>

@optional

/**
 *  已经移动到某一页
 *
 *  @param bannerView 触发此代理方法的DLMBannerView
 *  @param page 移动到的页数
 */
- (void)bannerView:(DLMBannerView *)bannerView didMoveToPage:(NSUInteger)page;

/**
 *  用户点击了某一页
 *
 *  @param bannerView 触发此代理方法的DLMBannerView
 *  @param page     用户点击的页码
 */
- (void)bannerView:(DLMBannerView *)bannerView didTouchPage:(NSUInteger)page;

@end


@protocol DLMBannerViewDataSource <NSObject>

@required

/**
 *  获取当前总共有多少页
 *
 *  @param bannerView 需要获取页数的DLMBannerView
 */
- (NSUInteger)numberOfPagesInBannerView:(DLMBannerView *)bannerView;

/**
 *  获取当某个页数的图片地址
 *
 *  @param bannerView 需要获取图片地址的DLMBannerView
 *  @param page 第多少页
 *
 *  @return NSString  图片地址
 */
- (NSString *)bannerView:(DLMBannerView *)bannerView imagePathAtPage:(NSUInteger)page;


@end


NS_CLASS_AVAILABLE_IOS(7_0) @interface IB_DESIGNABLE DLMBannerView : UIView

/**
 *  指定初始化方法
 *
 *  @param frame view的大小
 *
 *  @return DLMBannerView的实例
 */
- (instancetype)initWithFrame:(CGRect)frame NS_DESIGNATED_INITIALIZER;

/**
 *  指定Storyboard/Xib初始化方法，直接调用无效。
 *
 *  @param aDecoder 一个解压对象
 *
 *  @return DLMBannerView的实例
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_DESIGNATED_INITIALIZER;


/* 
 *  默认占位图片
 */
IBInspectable
@property (nonatomic, nullable, strong) UIImage *placeholder;

/*
 *  是否自动滚动,默认为YES
 */
IBInspectable
@property (nonatomic, assign, getter=isAutoScroll) BOOL autoScroll;

/*
 *  滚动速度,默认3s
 */
IBInspectable
@property (nonatomic, assign) CGFloat timeInterval;


/*
 *  代理
 */
@property (nonatomic, nullable, weak) id<DLMBannerViewDelegate> delegate;

/*
 *  数据源
 */
@property (nonatomic, nullable, weak) id<DLMBannerViewDataSource> dataSource;

/**
 *  图片显示的缩放模式,默认为ScaleAspectFill
 */
@property (nonatomic, assign) UIViewContentMode imageViewMode;


/**
 *  自动滚动时的滚动方向,默认是DLMBannerViewScrollDirectionLeft
 */
@property (nonatomic, assign) DLMBannerViewScrollDirection scrollDirection;

/*
 *  指示器默认颜色,默认为灰色
 */
IBInspectable
@property(nullable, nonatomic,strong) UIColor *pageIndicatorTintColor;

/*
 *  指示器高亮的颜色,默认为白色
 */
IBInspectable
@property(nullable, nonatomic,strong) UIColor *currentPageIndicatorTintColor;


/**
 *  开始轮播
 *  当图片数量 < 2 张 或者 autoScroll == NO 时,调用此方法不会产生任何效果。
 */
- (void)startMoving;

/**
 *  停止轮播
 */
- (void)stopMoving;


/**
 *  重新加载数据
 */
- (void)reloadData;

@end

NS_ASSUME_NONNULL_END
