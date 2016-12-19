//
//  BookScannerViewController.m
//  StudyPrivateCollection
//
//  Created by 车车 on 16/12/16.
//  Copyright © 2016年 pengyiwei. All rights reserved.
//

#import "BookScannerViewController.h"
#import "BookScannerView.h"

@interface BookScannerViewController ()

@property (nonatomic, strong) BookScannerView *scanView;

@end

@implementation BookScannerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
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
    [self initCamear];
    [self initScannerView];
    [self initTip];
}

- (void)initCamear {
    
}

- (void)initScannerView {
    self.scanView = [[BookScannerView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds)) rectSize:CGSizeMake(230.0, 230.0) offsetY:-43.0];
    self.scanView.backgroundColor = [UIColor clearColor];
    self.scanView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:self.scanView];
    
    [self.scanView startAnimation];
}

- (void)initTip {
    
}

@end
