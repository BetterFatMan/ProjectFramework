//
//  HJCActionSheet.m
//  wash
//
//  Created by weixikeji on 15/5/11.
//
//

#import "HJCActionSheet.h"

// 每个按钮的高度
#define BtnHeight 50
// 取消按钮上面的间隔高度
#define Margin 10

#define HJCColor(r, g, b) [UIColor colorWithRed:(r/255.0) green:(g/255.0) blue:(b/255.0) alpha:1.0]
// 背景色
#define GlobelBgColor HJCColor(237, 240, 242)
// 分割线颜色
#define GlobelSeparatorColor HJCColor(226, 226, 226)
// 普通状态下的图片
#define normalImage [self createImageWithColor:HJCColor(255, 255, 255)]
// 高亮状态下的图片
#define highImage [self createImageWithColor:HJCColor(242, 242, 242)]

#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
// 字体
#define HeitiLight(f) [UIFont fontWithName:@"STHeitiSC-Light" size:f]

@interface HJCActionSheet ()
{
    int _tag;
    BOOL        _isNeedDiffColor;
}

@property (nonatomic, weak) HJCActionSheet *actionSheet;
@property (nonatomic, weak) UIView *sheetView;
@property (nonatomic, strong) NSMutableArray  *btnArray;
@end

@implementation HJCActionSheet

- (instancetype)initWithDelegate:(id<HJCActionSheetDelegate>)delegate CancelTitle:(NSString *)cancelTitle OtherTitles:(NSString *)otherTitles, ...
{
    HJCActionSheet *actionSheet = [self init];
    self.actionSheet = actionSheet;
    
    actionSheet.delegate = delegate;
    
    // 黑色遮盖
    actionSheet.frame = [UIScreen mainScreen].bounds;
    actionSheet.backgroundColor = [UIColor blackColor];
    [[UIApplication sharedApplication].keyWindow addSubview:actionSheet];
    actionSheet.alpha = 0.0;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(coverClick)];
    [actionSheet addGestureRecognizer:tap];
    
    // sheet
    UIView *sheetView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 0)];
    sheetView.backgroundColor = GlobelBgColor;
    sheetView.alpha = 0.9;
    [[UIApplication sharedApplication].keyWindow addSubview:sheetView];
    self.sheetView = sheetView;
    sheetView.hidden = YES;
    
    _tag = 1;
    
    NSString* curStr;
    va_list list;
    if(otherTitles)
    {
        [self setupBtnWithTitle:otherTitles];
        
        va_start(list, otherTitles);
        while ((curStr = va_arg(list, NSString*))) {
            [self setupBtnWithTitle:curStr];
            
        }
        va_end(list);
    }
    
    CGRect sheetViewF = sheetView.frame;
    sheetViewF.size.height = BtnHeight * _tag + Margin;
    sheetView.frame = sheetViewF;
    
    // 取消按钮
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, sheetView.frame.size.height - BtnHeight, ScreenWidth, BtnHeight)];
    [btn setBackgroundImage:normalImage forState:UIControlStateNormal];
    [btn setBackgroundImage:highImage forState:UIControlStateHighlighted];
    [btn setTitle:cancelTitle forState:UIControlStateNormal];
    [btn setTitleColor:UICOLOR_RGB(0xd9, 0x00, 0x00) forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:17];
    btn.tag = 0;
    [btn addTarget:self action:@selector(sheetBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.sheetView addSubview:btn];
    
    return actionSheet;
}

- (void)needShowBlueColor:(NSInteger)btnTag
{
    [self needShowDiffColor:btnTag color:kNormalBlueColor];
    _isNeedDiffColor = NO;
}

- (void)needShowDiffColor:(NSInteger)btnTag color:(UIColor *)color
{
    _isNeedDiffColor = YES;
    UIButton *btn = [_btnArray objectAtIndexSafe:btnTag];
    
    [btn setTitleColor:color forState:UIControlStateNormal];
}

- (void)show{
    _isNeedDiffColor = NO;
    self.sheetView.hidden = NO;

    CGRect sheetViewF = self.sheetView.frame;
    sheetViewF.origin.y = ScreenHeight;
    self.sheetView.frame = sheetViewF;
    
    CGRect newSheetViewF = self.sheetView.frame;
    newSheetViewF.origin.y = ScreenHeight - self.sheetView.frame.size.height;
    
    [UIView animateWithDuration:0.3 animations:^{

        self.sheetView.frame = newSheetViewF;
        
        self.actionSheet.alpha = 0.3;
    }];
}

- (void)setupBtnWithTitle:(NSString *)title{
    // 创建按钮
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, BtnHeight * (_tag - 1) , ScreenWidth, BtnHeight)];
    [btn setBackgroundImage:normalImage forState:UIControlStateNormal];
    [btn setBackgroundImage:highImage forState:UIControlStateHighlighted];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:UICOLOR_RGB(0x38, 0x3d, 0x4b) forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:17];
    btn.tag = _tag;
    [btn addTarget:self action:@selector(sheetBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.sheetView addSubview:btn];
    [self.btnArray addObject:btn];
    
    // 最上面画分割线
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 0.5)];
    line.backgroundColor = GlobelSeparatorColor;
    [btn addSubview:line];
    
    _tag ++;
}

- (void)coverClick{
    CGRect sheetViewF = self.sheetView.frame;
    sheetViewF.origin.y = ScreenHeight;
    
    [UIView animateWithDuration:0.2 animations:^{
        self.sheetView.frame = sheetViewF;
        self.actionSheet.alpha = 0.0;
    } completion:^(BOOL finished) {
        [self.actionSheet removeFromSuperview];
        [self.sheetView removeFromSuperview];
    }];
}

- (void)sheetBtnClick:(UIButton *)btn{
    if (btn.tag == 0) {
        [self coverClick];
        return;
    }
    
    UIColor *btnColor = [btn titleColorForState:UIControlStateNormal];
    if (!_isNeedDiffColor || CGColorEqualToColor(btnColor.CGColor, UICOLOR_RGB(0x38, 0x3d, 0x4b).CGColor)) {
        
        if ([self.delegate respondsToSelector:@selector(actionSheet:clickedButtonAtIndex:)]) {
            [self.delegate actionSheet:self.actionSheet clickedButtonAtIndex:btn.tag];
            [self coverClick];
        }
    }
}

- (UIImage*)createImageWithColor:(UIColor*)color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

- (NSMutableArray *)btnArray
{
    if (_btnArray == nil) {
        _btnArray = [NSMutableArray array];
    }
    return _btnArray;
}

@end
