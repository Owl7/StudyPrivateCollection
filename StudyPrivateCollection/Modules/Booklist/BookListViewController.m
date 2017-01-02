//
//  BookListViewController.m
//  StudyPrivateCollection
//
//  Created by 车车 on 16/12/16.
//  Copyright © 2016年 pengyiwei. All rights reserved.
//

#import "BookListViewController.h"
#import "BookListTableViewController.h"
#import "BookListCollectionViewController.h"

typedef NS_ENUM(NSUInteger, BookListMode) {
    BookListModeTableView,
    BookListModeColectionView
};

@interface BookListViewController ()

@property (nonatomic, assign) BookListMode mode;

@end

@implementation BookListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initNavigation];
    
    self.mode = BookListModeTableView;
    
    [self switchToModel:self.mode];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

- (void)initNavigation {
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"list-switch-collection"] style:UIBarButtonItemStylePlain target:self action:@selector(didTapSwitchButton:)];
    
}

- (void)didTapSwitchButton:(UIBarButtonItem *)item {
    
    [self.childViewControllers makeObjectsPerformSelector:@selector(willMoveToParentViewController:) withObject:nil];
    [self.view.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.childViewControllers makeObjectsPerformSelector:@selector(removeFromParentViewController)];
    [self.childViewControllers makeObjectsPerformSelector:@selector(didMoveToParentViewController:) withObject:nil];
    
    if (self.mode == BookListModeTableView) {
        self.mode = BookListModeColectionView;
        item.image = [UIImage imageNamed:@"list-switch-table"];
    } else {
        self.mode = BookListModeTableView;
        item.image = [UIImage imageNamed:@"list-switch-collection"];
    }
    
    [self switchToModel:self.mode];
    
}

- (void)switchToModel:(BookListMode)mode {
    
    if (mode == BookListModeTableView) {
        BookListTableViewController *tableVC = [BookListTableViewController new];
        [tableVC willMoveToParentViewController:self];
        [self addChildViewController:tableVC];
        [self.view addSubview:tableVC.view];
        tableVC.view.frame = self.view.bounds;
        [tableVC didMoveToParentViewController:self];
    } else {
        BookListCollectionViewController *collectionVC = [BookListCollectionViewController new];
        [collectionVC willMoveToParentViewController:self];
        [self addChildViewController:collectionVC];
        [self.view addSubview:collectionVC.view];
        collectionVC.view.frame = self.view.bounds;
        [collectionVC didMoveToParentViewController:self];
    }
    
}

@end
