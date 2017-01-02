//
//  BookAnalyticsViewController.m
//  StudyPrivateCollection
//
//  Created by 车车 on 16/12/16.
//  Copyright © 2016年 pengyiwei. All rights reserved.
//

#import "BookAnalyticsViewController.h"

#import "BookListService.h"
#import "PieChartView.h"
#import "PieChartView+Author.h"
#import "BookAnalyticsTableViewCell.h"
#import "BookAnalyticsTableViewCell+Author.h"

@interface BookAnalyticsViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UIView *headerView;

@property (nonatomic, assign) CGFloat sumAuthorCount;

@property (nonatomic, strong) UILabel *sumAuthorCountLabel;

@property (nonatomic, strong) UILabel *authorLabel;

@property (nonatomic, strong) NSMutableArray<BookEntity *> *bookEntites;

@property (nonatomic, strong) NSMutableArray *authorArr;
@end

@implementation BookAnalyticsViewController

- (NSMutableArray<BookEntity *> *)bookEntites {
    
    if (!_bookEntites) {
        
        _bookEntites = [@[] mutableCopy];
        
    }
    
    return _bookEntites;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    self.sumAuthorCount = 0;
    
    [self getData];
    [self initSubviews];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

- (void)initNavigation {
    
}

- (BOOL)shouldShadowImage {
    return NO;
}

#pragma mark -- data

- (void)getData {
    self.bookEntites = [[BookListService getAllBookEntitles] mutableCopy];
    [self.tableView reloadData];
    self.authorArr = [@[] mutableCopy];
    for (BookEntity *entity in self.bookEntites) {
        self.sumAuthorCount += entity.authors.count;
        [self.authorArr addObject:entity.authors];
    }
}

#pragma mark - initSubviews

- (void)initSubviews {
    
    _headerView = [UIView new];
    _headerView.backgroundColor = UIColorFromRGB(0x009D82);
    [self.view addSubview:_headerView];
    
    [_headerView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.height.mas_equalTo(330);
    }];
    
    PieChartView *view = [[PieChartView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    view.backgroundColor = UIColorFromRGB(0x009D82);
    [view configureWithBookEntity:self.authorArr withRadius:100];
    
    [_headerView addSubview:view];
    
    
    _sumAuthorCountLabel = [UILabel new];
    _sumAuthorCountLabel.textColor = UIColorFromRGB(0x009D82);
    _sumAuthorCountLabel.font = [UIFont systemFontOfSize:40.0f];
    _sumAuthorCountLabel.textAlignment = NSTextAlignmentCenter;
    _sumAuthorCountLabel.text = [NSString stringWithFormat:@"%ld", (NSInteger)self.sumAuthorCount];
    [_headerView addSubview:_sumAuthorCountLabel];

    [_sumAuthorCountLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100-40, 40));
        make.center.mas_equalTo(CGPointMake(_headerView.bounds.size.width/2, _headerView.bounds.size.height/2+64/2-20));
    }];
    
    _authorLabel = [UILabel new];
    _authorLabel.textColor = [UIColor lightGrayColor];
    _authorLabel.text = @"作者总数";
    _authorLabel.textAlignment = NSTextAlignmentCenter;
    _authorLabel.font = [UIFont systemFontOfSize:16.0f];
    
    [_headerView addSubview:_authorLabel];
    
    [_authorLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(80*2, 40));
        make.center.mas_equalTo(CGPointMake(_headerView.bounds.size.width/2, _headerView.bounds.size.height/2+64/2+20));
    }];
    
    _tableView = [UITableView new];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    //为了让tableView自适应高度设置如下两个属性
    _tableView.estimatedRowHeight = 70;
    _tableView.rowHeight = UITableViewAutomaticDimension;
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 44)];
    [self.view addSubview:_tableView];
    
    [_tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.top.mas_equalTo(self.headerView.mas_bottom);
    }];
    
}

#pragma mark -- UITableViewDatasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.authorArr.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"bookAnalyticsTableViewCell";
    
    BookAnalyticsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        cell = [[BookAnalyticsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    BookEntity *entity = [self.bookEntites objectAtIndex:indexPath.row];
    
    [cell configureWithBookEntity:entity];
    
    return cell;
    
}

#pragma mark -- UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//    return 60;
//    
//}

@end
