//
//  BaseViewController.m
//  ProjectFramework
//
//  Created by ElanKing on 2017/11/27.
//  Copyright © 2017年 ElanKing. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor   = [UIColor whiteColor];
    self.navigationController.navigationBarHidden = YES;
    self.view.clipsToBounds     = YES;
    
    _navView                = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kKeyWindow.frame.size.width, kStatusBarHeight + 44)];
    _navView.backgroundColor    = kNormalBlueColor;
    _navView.clipsToBounds  = YES;
    [self.view addSubview:_navView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (!self.leftBtn) {
        UIButton *backBtn           = [UIButton buttonWithType:UIButtonTypeCustom];
        backBtn.frame               = CGRectMake(10, kStatusBarHeight, 54, 44);
        [backBtn setImage:[UIImage imageNamed:@"top_arrow_back"] forState:UIControlStateNormal];
        [backBtn addTarget:self action:@selector(clickBackButton:) forControlEvents:UIControlEventTouchUpInside];
        [backBtn setTitle:@"返回" forState:UIControlStateNormal];
        [backBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        backBtn.titleLabel.font = gFontSystemSize(16);
        
        self.leftBtn = backBtn;
    }
    [_navView addSubview:_leftBtn];
    
    if (!self.titleLab) {
        UILabel *titleLabel         = [[UILabel alloc] initWithFrame:CGRectMake(65, kStatusBarHeight, kKeyWindow.width - 130, 44)];
        titleLabel.textAlignment    = NSTextAlignmentCenter;
        titleLabel.backgroundColor  = [UIColor clearColor];
        titleLabel.font             = [UIFont boldSystemFontOfSize:17];
        titleLabel.textColor        = [UIColor whiteColor];
        titleLabel.autoresizingMask = (UIViewAutoresizingFlexibleWidth);
        self.titleLab = titleLabel;
    }
    [_navView addSubview:_titleLab];
    
    _titleLab.text             = self.title;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)clickBackButton:(UIButton *)sender {
    
}


@end
