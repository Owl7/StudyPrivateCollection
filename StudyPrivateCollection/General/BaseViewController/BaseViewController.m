//
//  BaseViewController.m
//  StudyPrivateCollection
//
//  Created by 彭益伟 on 23/12/2016.
//  Copyright © 2016 pengyiwei. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self adjustNavigator];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation config

- (void)adjustNavigator {
    
    // 是否隐藏导航底部的线
    if ([self shouldShadowImage]) {
        [self.navigationController.navigationBar setShadowImage:nil];
    } else {
        [self.navigationController.navigationBar setShadowImage:[UIImage new]];
        [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    }
    
    // 是否使用自定义的背景（透明）
    if ([self navigationBarBackgroundImage]) {
        [self.navigationController.navigationBar setBackgroundImage:[self navigationBarBackgroundImage] forBarMetrics:UIBarMetricsDefault];
    } else {
        self.navigationController.navigationBar.barTintColor = UIColorFromRGB(0x009D82);
        [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    }
    
}

- (UIImage *)navigationBarBackgroundImage {
    return nil;
}

- (BOOL)shouldShadowImage {
    return NO;
}

- (BOOL)shouldHideBottomBarwhenPushed {
    return NO;
}

@end
