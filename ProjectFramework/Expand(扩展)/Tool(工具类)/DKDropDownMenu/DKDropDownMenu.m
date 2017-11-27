//
//  DKDropDownMenu.m
//  DKDropDownMenu
//
//  Created by 蝴蝶 on 2017/11/9.
//  Copyright © 2017年 butterfly. All rights reserved.
//

#import "DKDropDownMenu.h"


@implementation DKIndexPath

@synthesize column = _column;
@synthesize row = _row;

+ (instancetype)indexPathWithColumn:(NSInteger)column row:(NSInteger)row {
    return [[[self class] alloc] initWithColumn:column row:row];
}

- (instancetype)initWithColumn:(NSInteger)column row:(NSInteger)row {
    self = [super init];
    if (self) {
        _column = column;
        _row = row;
    }
    return self;
}

@end

@implementation DKDropDownRowItem

@synthesize title = _title;
@synthesize titleFont = _titleFont;
@synthesize titleColor = _titleColor;
@synthesize selectedTitleColor = _selectedTitleColor;
@synthesize useCoulumTitleWhenSelected = _useCoulumTitleWhenSelected;
@synthesize identifier = _identifier;

@end

@implementation DKDropDownCoulumItem

@synthesize title = _title;
@synthesize identifier = _identifier;
@synthesize icon = _icon;
@synthesize selectedIcon = _selectedIcon;
@synthesize currentSelectedRow = _currentSelectedRow;
@synthesize showDropImage = _showDropImage;
@synthesize titleColor = _titleColor;
@synthesize selectedTitleColor = _selectedTitleColor;

- (instancetype)init {
    self = [super init];
    if (self) {
        _showDropImage = YES;
    }
    return self;
}

@end

@interface DKDropDownCoulumView ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) UIImageView *dropImageView;

@end

@implementation DKDropDownCoulumView

@synthesize iconImage = _iconImage;
@synthesize selectedIconImage = _selectedIconImage;
@synthesize selectedTitleColor = _selectedTitleColor;
@synthesize title = _title;
@synthesize dropupImage = _dropupImage;
@synthesize dropdownImage = _dropdownImage;
@synthesize titleColor = _titleColor;
@synthesize titleFont = _titleFont;
@synthesize dropUp = _dropUp;
@synthesize highlightedTitle = _highlightedTitle;

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self viewInit];
    }
    return self;
}

- (instancetype)init {
    return [self initWithFrame:CGRectZero];
}

#pragma mark- View Init

- (void)viewInit {
    self.backgroundColor = [UIColor clearColor];
    
    // 标题标签
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.backgroundColor = [UIColor clearColor];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    
    [self addSubview:_titleLabel];
    
    // Icon
    _iconView = [[UIImageView alloc] init];
    _iconView.backgroundColor = [UIColor clearColor];
    _iconView.contentMode = UIViewContentModeCenter;
    
    [self addSubview:_iconView];
    
    // Dorp View
    _dropImageView = [[UIImageView alloc] init];
    _dropImageView.backgroundColor = [UIColor clearColor];
    _dropImageView.contentMode = UIViewContentModeCenter;
    
    [self addSubview:_dropImageView];
}

#pragma mark- Layout SubViews

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    [_titleLabel sizeToFit];
    CGFloat titleWidth = CGRectGetWidth(_titleLabel.frame)+2;
    CGFloat imageLength = _titleLabel.frame.size.height;
    CGFloat iconWidth = 0.0f;
    CGFloat dropWidth = 0.0f;
    if (_iconView.isHighlighted) {
        iconWidth = _selectedIconImage ? imageLength : 0;
    }else {
        iconWidth = _iconImage ? imageLength : 0;
    }
    
    if (!_dropImageView.isHighlighted) {
        dropWidth = _dropdownImage ? imageLength : 0;
    }else {
        dropWidth = _dropupImage ? imageLength : 0;
    }

    CGFloat maxTitleWidth = CGRectGetWidth(self.frame) - iconWidth - dropWidth;
    titleWidth = MIN(titleWidth, maxTitleWidth);
    
    // 计算内容坐标
    CGFloat contentWidth = titleWidth + iconWidth + dropWidth;
    CGFloat contentOffsetX = (CGRectGetWidth(self.frame) - contentWidth)/2.0f;
    
    if (iconWidth > 0) {
        _iconView.frame = CGRectMake(contentOffsetX, (CGRectGetHeight(self.frame)-imageLength)/2.0f, imageLength, imageLength);
        _iconView.hidden = NO;
        contentOffsetX = contentOffsetX + CGRectGetWidth(_iconView.frame);
    }else {
        _iconView.frame = CGRectZero;
        _iconView.hidden = YES;
    }
    
    _titleLabel.frame = CGRectMake(contentOffsetX, 0, titleWidth, CGRectGetHeight(self.frame));
    
    if (dropWidth > 0) {
        _dropImageView.frame = CGRectMake(CGRectGetMaxX(_titleLabel.frame), (CGRectGetHeight(self.frame)-imageLength)/2.0f, imageLength, imageLength);
        _dropImageView.hidden = NO;
    }else {
        _dropImageView.frame = CGRectZero;
        _dropImageView.hidden = YES;
    }
}


#pragma mark- Setters And Getters

- (void)setIconImage:(UIImage *)iconImage {
    _iconImage = iconImage;
    _iconView.image = _iconImage;
}

- (void)setSelectedIconImage:(UIImage *)selectedIconImage {
    _selectedIconImage = selectedIconImage;
    _iconView.highlightedImage = _selectedIconImage;
}

- (void)setSelectedTitleColor:(UIColor *)selectedTitleColor {
    _selectedTitleColor = selectedTitleColor;
    _titleLabel.highlightedTextColor = _selectedTitleColor;
}

- (void)setTitleColor:(UIColor *)titleColor {
    _titleColor = titleColor;
    _titleLabel.textColor = _titleColor;
}

- (void)setTitle:(NSString *)title {
    _title = [title copy];
    _titleLabel.text = _title;
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

- (void)setTitleFont:(UIFont *)titleFont {
    _titleFont = titleFont;
    _titleLabel.font = _titleFont;
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

- (void)setDropupImage:(UIImage *)dropupImage {
    _dropupImage = dropupImage;
    _dropImageView.highlightedImage = _dropupImage;
}

- (void)setDropdownImage:(UIImage *)dropdownImage {
    _dropdownImage = dropdownImage;
    _dropImageView.image = _dropdownImage;
}

- (void)setSelected:(BOOL)selected {
    _iconView.highlighted = selected;
}

- (void)setDropUp:(BOOL)dropUp {
    _dropUp = dropUp;
    [UIView animateWithDuration:0.5f animations:^{
        _dropImageView.highlighted = _dropUp;
    }];
}

- (void)setHighlightedTitle:(BOOL)highlightedTitle {
    _highlightedTitle = highlightedTitle;
    _titleLabel.highlighted = _highlightedTitle;
}

@end

@interface DKDropDownMenu ()<UITableViewDelegate,
                             UITableViewDataSource,
                             UIGestureRecognizerDelegate>

@property (nonatomic, strong) UITableView *tableView;

// 当前选中的列数
@property (nonatomic, assign) NSInteger currentColumn;

// 列数
@property (nonatomic, assign) NSInteger numberOfColumn;

// 背景视图
@property (nonatomic, strong) UIView *backGroundView;

// 每列的控件
@property (nonatomic, strong) NSMutableArray *columnItems;
@property (nonatomic, strong) NSMutableArray *columnViews;
@property (nonatomic, strong) NSMutableArray *rowItems;
@property (nonatomic, strong) NSMutableArray *lineViews;

// 是否处于展开状态
@property (nonatomic, assign) BOOL show;

@end

#define CELL_IDENTIFIER @"DropDownMenuCell"
#define DEFAULT_SEPARATORCOLOR

#define GROUND_COLOR [UIColor colorWithRed:244.0f/255.0f green:244.0f/255.0f blue:244.0f/255.0f alpha:1.0]


@implementation DKDropDownMenu

@synthesize delegate = _delegate;
@synthesize dataSource = _dataSource;
@synthesize selectedTitleColor = _selectedTitleColor;
@synthesize dropupImage = _dropupImage;
@synthesize dropdownImage = _dropdownImage;
@synthesize titleColor = _titleColor;
@synthesize titleFont = _titleFont;
@synthesize separatorColor = _separatorColor;

- (instancetype)initWithFrame:(CGRect)frame {
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGRect newFrame = CGRectMake(frame.origin.x, frame.origin.y, width, frame.size.height);
    self = [super initWithFrame:newFrame];
    if (self) {
        [self viewInit];
    }
    return self;
}

- (instancetype)init {
    return [self initWithFrame:CGRectZero];
}

#pragma mark- View Init

- (void)viewInit {
    
    self.backgroundColor = GROUND_COLOR;
    _currentColumn = -1;
    _columnItems = [@[] mutableCopy];
    _rowItems = [@[] mutableCopy];
    _columnViews = [@[] mutableCopy];
    _lineViews = [@[] mutableCopy];

    [self addTableView];
    [self addBackGroundView];
}

- (void)addTableView {
    
    CGRect frame = CGRectMake(self.frame.origin.x, self.frame.origin.y
                              + self.frame.size.height, 0, 0);
    _tableView = [[UITableView alloc] initWithFrame:frame
                                              style:UITableViewStylePlain];
    _tableView.rowHeight = 40;
    _tableView.separatorColor = [UIColor colorWithRed:220.f/255.0f
                                                green:220.f/255.0f
                                                 blue:220.f/255.0f
                                                alpha:1.0];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.tableFooterView = [[UIView alloc] init];
    _tableView.estimatedRowHeight = 0.0;
    _tableView.estimatedSectionHeaderHeight = 0.0;
    _tableView.estimatedSectionFooterHeight = 0.0;
    
    if (@available(iOS 11.0, *)) {
        _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    
    [_tableView registerClass:[UITableViewCell class]
       forCellReuseIdentifier:CELL_IDENTIFIER];
}

- (void)addBackGroundView {
    
    _backGroundView = [[UIView alloc] init];
    _backGroundView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.0];
    _backGroundView.opaque = NO;
    
    // 添加手势
    UIGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                           action:@selector(backgroundTapped:)];
    [_backGroundView addGestureRecognizer:gesture];
}

#pragma mark- Load Data

- (void)reloadData {
    [self hiddenRowView];
    [self loadContent];
}

- (void)loadContent {
    
    // 移除所有的列的数据
    [_columnViews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [_lineViews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [_columnViews removeAllObjects];
    [_columnItems removeAllObjects];
    [_lineViews removeAllObjects];
    [_rowItems removeAllObjects];
    
    // 如果数据源为空,则返回
    if (!_dataSource) { return; }
    
    // 获取多少行数
    if ([_dataSource respondsToSelector:@selector(numberOfColumnsInMenu:)]) {
        _numberOfColumn = [_dataSource numberOfColumnsInMenu:self];
    } else {
        _numberOfColumn = 1;
    }
    
    CGFloat columnInterval = (CGRectGetWidth(self.frame) - _numberOfColumn*0.5f + 0.5f) / _numberOfColumn;
    
    for (NSInteger i = 0; i < _numberOfColumn; i++) {
        
        DKDropDownCoulumItem *columnItem = [_dataSource dropDownMenu:self itemForColumn:i];
        DKDropDownCoulumView *columnView = [[DKDropDownCoulumView alloc] init];
        columnView.frame = CGRectMake(columnInterval*i+i*0.5f, 0, columnInterval, CGRectGetHeight(self.frame));
        columnView.title = columnItem.title;
        columnView.iconImage = columnItem.icon;
        columnView.selectedIconImage = columnItem.selectedIcon;
        
        if (columnItem.showDropImage) {
            columnView.dropupImage = self.dropupImage;
            columnView.dropdownImage = self.dropdownImage;
        }else {
            columnView.dropupImage = nil;
            columnView.dropdownImage = nil;
        }

        columnView.titleFont = self.titleFont;
        columnView.titleColor = columnItem.titleColor?:self.titleColor;
        columnView.selectedTitleColor = columnItem.selectedTitleColor?:self.selectedTitleColor;
        columnView.tag = i;
        
        [columnView addTarget:self
                       action:@selector(columnButtonPressed:)
             forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:columnView];
        
        if (i < _numberOfColumn-1) {
            CGRect lineFrame = CGRectMake(CGRectGetMaxX(columnView.frame),CGRectGetHeight(self.frame)/4.0f,
                                          0.5f, CGRectGetHeight(self.frame)/2.0f);
            UIView *lineView = [[UIView alloc] initWithFrame:lineFrame];
            lineView.backgroundColor = _separatorColor ? _separatorColor : [UIColor blackColor];
            
            [self addSubview:lineView];
            [_lineViews addObject:lineView];
        }
        
        [_columnViews addObject:columnView];
        [_columnItems addObject:columnItem];
        
        // 获取当前列的行数据
        NSInteger numberOfRowsInColumn = 0;
        if ([_dataSource respondsToSelector:@selector(dropDownMenu:numberOfRowsInColumn:)]) {
            numberOfRowsInColumn = [_dataSource dropDownMenu:self numberOfRowsInColumn:i];
        }
        
        NSMutableArray *rowArray = [@[] mutableCopy];
        for (NSInteger j = 0; j < numberOfRowsInColumn; j++) {
            DKIndexPath *indexPath = [DKIndexPath indexPathWithColumn:i row:j];
            DKDropDownRowItem *rowItem = [_dataSource dropDownMenu:self
                                             itemForRowAtIndexPath:indexPath];
            [rowArray addObject:rowItem];
        }
        [_rowItems addObject:rowArray];
    }
}

#pragma mark- UITableView Delegate And DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (_currentColumn < 0 || _currentColumn >= _numberOfColumn) {
        return 0;
    }
    
    NSArray *rowItems = _rowItems[_currentColumn];
    return rowItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELL_IDENTIFIER
                                                            forIndexPath:indexPath];
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    // 赋值每行数据
    NSArray *rowItems = _rowItems[_currentColumn];
    DKDropDownRowItem *item = rowItems[indexPath.row];
    
    cell.textLabel.textColor = item.titleColor;
    cell.textLabel.text = item.title;
    cell.textLabel.font = item.titleFont;
    cell.textLabel.highlightedTextColor = item.selectedTitleColor;
    
    // 设置被选中的行
    DKDropDownCoulumItem *coulumItem = _columnItems[_currentColumn];
    if (indexPath.row == coulumItem.currentSelectedRow) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        cell.textLabel.highlighted = YES;
    }else {
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.textLabel.highlighted = NO;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DKIndexPath *path = [DKIndexPath indexPathWithColumn:_currentColumn row:indexPath.row];
    [self confiMenuWithIndexPath:path];
    
    if ([_delegate respondsToSelector:@selector(dropDownMenu:didSelectRowAtIndexPath:)]) {
        [_delegate dropDownMenu:self didSelectRowAtIndexPath:path];
    }
}


// 选择了某行
- (void)confiMenuWithIndexPath:(DKIndexPath *)indexPath {
    
    // 重新设置列中被选中的行
    DKDropDownCoulumItem *coulumItem = _columnItems[indexPath.column];
    coulumItem.currentSelectedRow = indexPath.row;
    
    // 重新设置标题
    DKDropDownCoulumView *coulumView = _columnViews[indexPath.column];
    
    NSArray *rowItems = _rowItems[indexPath.column];
    DKDropDownRowItem *rowItem = rowItems[indexPath.row];

    if (rowItem.useCoulumTitleWhenSelected) {
        coulumView.title = coulumItem.title;
        coulumView.highlightedTitle = NO;
    }else {
        coulumView.title = rowItem.title;
        coulumView.highlightedTitle = YES;
    }
    coulumView.selected = NO;
    coulumView.dropUp = NO;
    [self hiddenRowView];
}

#pragma mark- Show and Hidden Row

- (void)hiddenDropList {
    [self backgroundTapped:nil];
}

- (void)showRowView {
    [self animateBackGroundView:_backGroundView show:YES complete:^{
        [self animateTableView:_tableView show:YES complete:^{
            _show = YES;
        }];
    }];
}

- (void)hiddenRowView {
    if (!_show) { return;}
    [self animateBackGroundView:_backGroundView show:NO complete:^{
        [self animateTableView:_tableView show:NO complete:^{
            _show = NO;
        }];
    }];
}

- (void)animateBackGroundView:(UIView *)view 
                         show:(BOOL)show
                     complete:(void(^)(void))complete {
    if (show) {
        
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        UINavigationController *rootViewController = (UINavigationController *)window.rootViewController;
        UIViewController *controller = rootViewController.viewControllers[0];
        
        if (self.presentViewController) {
            controller = self.presentViewController;
        }
        
        CGRect rect = [self.superview convertRect:self.frame toView:controller.view];
        CGSize screenSize = [UIScreen mainScreen].bounds.size;
        view.frame = CGRectMake(self.frame.origin.x, CGRectGetMaxY(rect),
                                   screenSize.width, screenSize.height-CGRectGetMaxY(rect));
        
        [controller.view addSubview:view];
        
        [UIView animateWithDuration:0.2 animations:^{
            view.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.3];
        }];
    } else {
        [UIView animateWithDuration:0.2 animations:^{
            view.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.0];
        } completion:^(BOOL finished) {
            [view removeFromSuperview];
        }];
    }
    complete();
}

// 动画显示下拉菜单
- (void)animateTableView:(UITableView *)tableView
                    show:(BOOL)show
                complete:(void(^)(void))complete {
    
    if (!_tableView) { return; }
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    UINavigationController *rootViewController = (UINavigationController *)window.rootViewController;
    UIViewController *controller = rootViewController.viewControllers[0];
    
    if (self.presentViewController) {
        controller = self.presentViewController;
    }
    
    CGRect rect = [self.superview convertRect:self.frame toView:controller.view];
    
    if (show) {
        
        CGFloat tableViewHeight = 0;
        tableView.frame = CGRectMake(rect.origin.x, rect.origin.y + rect.size.height, rect.size.width, 0);
        [controller.view addSubview:tableView];

        tableViewHeight = ([tableView numberOfRowsInSection:0] > 5) ? (5 * tableView.rowHeight) : ([tableView numberOfRowsInSection:0] * tableView.rowHeight);
        [UIView animateWithDuration:0.2 animations:^{
            tableView.frame = CGRectMake(rect.origin.x, rect.origin.y + rect.size.height, rect.size.width, tableViewHeight);
        }];
    } else {
        [UIView animateWithDuration:0.2 animations:^{
//            tableView.frame = CGRectMake(rect.origin.x, rect.origin.y + rect.size.height, rect.size.width, 0);
            tableView.height = 0;
        } completion:^(BOOL finished) {
            [_tableView removeFromSuperview];
        }];
    }
    complete();
}


#pragma mark- Button Action

- (void)columnButtonPressed:(id)sender {
    
    DKDropDownCoulumView *coulumView = (DKDropDownCoulumView *)sender;
    
    NSInteger tapIndex = coulumView.tag;
    
    for (NSInteger i = 0; i < _numberOfColumn; i++) {
        if (tapIndex != i) {
            DKDropDownCoulumView *otherCoulumView = _columnViews[i];
            otherCoulumView.selected = NO;
            otherCoulumView.dropUp = NO;
            
            DKDropDownCoulumItem *coulumItem = _columnItems[i];
            NSArray *rowArray = _rowItems[i];
            NSInteger rowNumber = rowArray.count;
            
            if (rowNumber > 0) {
                DKDropDownRowItem *rowItem = rowArray[coulumItem.currentSelectedRow];
                if (rowItem.useCoulumTitleWhenSelected) {
                    otherCoulumView.highlightedTitle = NO;
                }else {
                    otherCoulumView.highlightedTitle = YES;
                }
            }else {
                otherCoulumView.highlightedTitle = NO;
            }
        }
    }
    
    // 如果点击的是当前行,且已经展开,则关闭
    if (tapIndex == _currentColumn && _show) {
        _currentColumn = tapIndex;
        coulumView.selected = NO;
        coulumView.dropUp = NO;
        
        DKDropDownCoulumItem *coulumItem = _columnItems[_currentColumn];
        NSArray *rowArray = _rowItems[_currentColumn];
        NSInteger rowNumber = rowArray.count;
        if (rowNumber > 0) {
            DKDropDownRowItem *rowItem = rowArray[coulumItem.currentSelectedRow];
            if (rowItem.useCoulumTitleWhenSelected) {
                coulumView.highlightedTitle = NO;
            }else {
                coulumView.highlightedTitle = YES;
            }
        }else {
            coulumView.highlightedTitle = NO;
        }
        [self hiddenRowView];
    }else {
        _currentColumn = tapIndex;
        coulumView.selected = YES;
        coulumView.dropUp = YES;
        coulumView.highlightedTitle = YES;
        
        [self.tableView reloadData];
        
        NSArray *rowArray = _rowItems[_currentColumn];
        NSInteger rowNumber = rowArray.count;
        
        if (rowNumber > 0) {
            [self showRowView];
        }else {
            [self hiddenRowView];
            _show = YES;
        }
    }
    
    if ([_delegate respondsToSelector:@selector(dropDownMenu:didSelectColumn:)]) {
        [_delegate dropDownMenu:self didSelectColumn:tapIndex];
    }
}

- (void)backgroundTapped:(UITapGestureRecognizer *)paramSender {
    
    if (_currentColumn >= 0 && _currentColumn < _numberOfColumn) {
        DKDropDownCoulumView *tapCoulumView = _columnViews[_currentColumn];
        tapCoulumView.selected = NO;
        tapCoulumView.dropUp = NO;
        
        DKDropDownCoulumItem *coulumItem = _columnItems[_currentColumn];
        NSArray *rowItems = _rowItems[_currentColumn];
        NSInteger rowNumber = rowItems.count;
        if (rowNumber > 0) {
            DKDropDownRowItem *rowItem = rowItems[coulumItem.currentSelectedRow];
            if (rowItem.useCoulumTitleWhenSelected) {
                tapCoulumView.highlightedTitle = NO;
            }else {
                tapCoulumView.highlightedTitle = YES;
            }
        }else {
            tapCoulumView.highlightedTitle = NO;
        }
        [self hiddenRowView];
    }
}

#pragma mark- Setters And Getters

- (void)setFrame:(CGRect)frame {
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGRect newFrame = CGRectMake(frame.origin.x, frame.origin.y, width, frame.size.height);
    [super setFrame:newFrame];
}

- (void)setDataSource:(id<DKDropDownMenuDataSource>)dataSource {
    _dataSource = dataSource;
    [self reloadData];
}

- (void)setSeparatorColor:(UIColor *)separatorColor {
    _separatorColor = separatorColor;
    for (UIView *line in _lineViews) {
        line.backgroundColor = _separatorColor;
    }
}

- (void)setTitleFont:(UIFont *)titleFont {
    _titleFont = titleFont;
    for (DKDropDownCoulumView *view in _columnViews) {
        view.titleFont = _titleFont;
    }
}

- (void)setTitleColor:(UIColor *)titleColor {
    _titleColor = titleColor;
    
    for (NSInteger i = 0; i < _columnViews.count; i++) {
        DKDropDownCoulumView *view = _columnViews[i];
        DKDropDownCoulumItem *item = _columnItems[i];
        view.titleColor = item.titleColor?:_titleColor;
    }
}

- (void)setSelectedTitleColor:(UIColor *)selectedTitleColor {
    _selectedTitleColor = selectedTitleColor;
    for (NSInteger i = 0; i < _columnViews.count; i++) {
        DKDropDownCoulumView *view = _columnViews[i];
        DKDropDownCoulumItem *item = _columnItems[i];
        view.selectedTitleColor = item.selectedTitleColor?:_selectedTitleColor;
    }
}

- (void)setDropupImage:(UIImage *)dropupImage {
    _dropupImage = dropupImage;
    for (NSInteger i = 0; i < _columnViews.count; i++) {
        DKDropDownCoulumView *view = _columnViews[i];
        DKDropDownCoulumItem *item = _columnItems[i];
        
        if (item.showDropImage) {
            view.dropupImage = _dropupImage;
        }else {
            view.dropupImage = nil;
        }
    }
}

- (void)setDropdownImage:(UIImage *)dropdownImage {
    _dropdownImage = dropdownImage;
    for (NSInteger i = 0; i < _columnViews.count; i++) {
        DKDropDownCoulumView *view = _columnViews[i];
        DKDropDownCoulumItem *item = _columnItems[i];
        if (item.showDropImage) {
            view.dropdownImage = _dropdownImage;
        }else {
            view.dropdownImage = nil;
        }
    }
}

@end
