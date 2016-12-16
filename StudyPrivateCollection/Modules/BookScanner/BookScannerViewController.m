//
//  BookScannerViewController.m
//  StudyPrivateCollection
//
//  Created by 车车 on 16/12/16.
//  Copyright © 2016年 pengyiwei. All rights reserved.
//

#import "BookScannerViewController.h"

@interface BookScannerViewController ()

@end

@implementation BookScannerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor redColor];
    [self initNavigation];
    [self initSubviews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

- (void)initNavigation {
    
    //生成透明导航栏
    self.navigationController.navigationBar.translucent = YES;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:@"back-button"] forState:UIControlStateNormal];
    [backBtn sizeToFit];
    
    [backBtn addTarget:self action:@selector(clickBack) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    
    UIButton *flashBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [flashBtn setImage:[UIImage imageNamed:@"light-off"] forState:UIControlStateNormal];
    [flashBtn setImage:[UIImage imageNamed:@"light-on"] forState:UIControlStateSelected];
    [flashBtn sizeToFit];
    
    [flashBtn addTarget:self action:@selector(clickFlash:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:flashBtn];
    
}

- (void)clickBack {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)clickFlash:(UIButton *)button {
    button.selected = !button.selected;
    //开启和关闭手电筒
    
}

#pragma mark - initSubViews

- (void)initSubviews {
    
}

- (void)initCamear {
    
}

- (void)initScannerView {
    
}

- (void)initTip {
    
}

@end