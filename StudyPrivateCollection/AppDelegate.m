//
//  AppDelegate.m
//  StudyPrivateCollection
//
//  Created by pengyiwei on 16/12/12.
//  Copyright © 2016年 pengyiwei. All rights reserved.
//

#import "AppDelegate.h"
#import "BookListViewController.h"
#import "BookScannerViewController.h"
#import "BookAnalyticsViewController.h"

@interface AppDelegate ()<UITabBarControllerDelegate>

@property (nonatomic, strong) BookScannerViewController *scannerVC;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    // 开启网络监测
    [[AFNetworkReachabilityManager manager] startMonitoring];
    
    // 状态栏菊花
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    UITabBarController *tabVC = [[UITabBarController alloc] init];
    tabVC.delegate = self;
    
    self.window.rootViewController = tabVC;
    [self.window makeKeyAndVisible];
    
    BookListViewController *listVC = [BookListViewController new];
    listVC.tabBarItem.title = @"我的藏书";
    listVC.tabBarItem.image = [UIImage imageNamed:@"tabbar-icon-collection"];
    listVC.tabBarItem.selectedImage = [UIImage imageNamed:@""];
    
    BookScannerViewController *scannerVC = [BookScannerViewController new];
    self.scannerVC = scannerVC;
    scannerVC.tabBarItem.title = @"扫码藏书";
    scannerVC.tabBarItem.image = [UIImage imageNamed:@"tabbar-icon-scan"];
    scannerVC.tabBarItem.selectedImage = [UIImage imageNamed:@""];
    
    BookAnalyticsViewController *analyticsVC = [BookAnalyticsViewController new];
    analyticsVC.tabBarItem.title = @"我的";
    analyticsVC.tabBarItem.image = [UIImage imageNamed:@"tabbar-icon-me"];
    analyticsVC.tabBarItem.selectedImage = [UIImage imageNamed:@""];
    
    tabVC.viewControllers = @[listVC, scannerVC, analyticsVC];
    tabVC.tabBar.itemPositioning = UITabBarItemPositioningCentered;
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
//    [self.scannerVC.captureSession stopRunning];
//    [self.scannerVC.scanView stopAnimation];
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
//    [self.scannerVC initSubviews];
//    [self.scannerVC.captureSession startRunning];
//    [self.scannerVC.scanView startAnimation];
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark -- tabber

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    
    if ([viewController isKindOfClass:[BookScannerViewController class]]) {
        BookScannerViewController *scannerVC = [BookScannerViewController new];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:scannerVC];
        [self.window.rootViewController presentViewController:nav animated:YES completion:nil];
        return NO;
    }
    
    return YES;
}



@end
