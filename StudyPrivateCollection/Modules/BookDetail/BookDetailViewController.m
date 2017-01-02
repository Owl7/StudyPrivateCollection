//
//  BookDetailViewController.m
//  StudyPrivateCollection
//
//  Created by 彭益伟 on 23/12/2016.
//  Copyright © 2016 pengyiwei. All rights reserved.
//

#import "BookDetailViewController.h"
#import "AuthorModel.h"
#import "TranslatorModel.h"
#import "TagModel.h"
#import "BookDetailService.h"

static const float kBackgroundImageViewHeight = 270.5f; // 头部背景图片高度
static const float kCoverImageViewHeight = 161;         // 封面图片高度
static const float kCoverImageViewWidth = 115;          // 封面图片宽度
//static const float kCoverImageViewOriginX = 16;         // 封面图片X
static const float kCoverImageViewOriginY = 16;         // 封面图片Y
static const float kNavigationBarHeight = 64.0f;        // 导航栏高度
static const float kTitleFontSize = 17.0f;              // 标题字体大小
static const float kItemLabelFontSize = 11.0f;          // 作者、译者、出版时间等 字体大小
static const float kFavButtonFontSize = 12.0f;          // 收藏按钮字体大小
static const float kSummaryLabelFontSize = 16.0f;       // 内容详情标题字体大小
static const float kDetailLabelFontSize = 15.0f;        // 详情字体大小
static const float kRight = 15.0f;                      // 右边距
static const float kLeft = 16.0f;                       // 左边距
static const float kConverImageAndItemLabel = 14.0f;    // ItemLabel距离封面图片距离

@interface BookDetailViewController ()<UIScrollViewDelegate>

//
@property (nonatomic, strong) UIImageView *backgroundImageView;

// 收藏按钮
@property (nonatomic, strong) UIButton *favButton;

// 取消收藏按钮
@property (nonatomic, strong) UIButton *unFavButton;

// bookId
@property (nonatomic, assign) long long bookId;

@end

@implementation BookDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initNavigation];
    [self initSubviews];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- Navigation

- (void)initNavigation {
    self.navigationItem.title = @"书籍详情";
}

- (UIImage *)navigationBarBackgroundImage {
    return [UIImage new];
}

- (BOOL)shouldShadowImage {
    return NO;
}

- (BOOL)shouldHideBottomBarwhenPushed {
    return YES;
}

#pragma makr -- Subviews

- (void)initSubviews {
    
    [self initBackgroundView];
    [self initScrollView];
    
}

- (void)initBackgroundView {
    
    self.backgroundImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"detail-topbg"]];
    self.backgroundImageView.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), kBackgroundImageViewHeight);
    self.backgroundImageView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:self.backgroundImageView];
    
}

- (void)initScrollView {
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, kNavigationBarHeight, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) - kNavigationBarHeight)];
    scrollView.alwaysBounceVertical = YES;
    scrollView.delegate = self;
    scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:scrollView];

    // 头部
    UIView *headView = [UIView new];
    headView.translatesAutoresizingMaskIntoConstraints = NO;
    [scrollView addSubview:headView];
    
    [scrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"V:|-0-[headView(==%f)]", kBackgroundImageViewHeight - kNavigationBarHeight] options:NSLayoutFormatAlignAllCenterX metrics:nil views:NSDictionaryOfVariableBindings(headView)]];
    [scrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[headView(==scrollView)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(headView, scrollView)]];
    
    // 封面
    UIImageView *coverImageView = [UIImageView new];
    coverImageView.translatesAutoresizingMaskIntoConstraints = NO;
    coverImageView.backgroundColor = [UIColor whiteColor];
    [coverImageView sd_setImageWithURL:[NSURL URLWithString:self.bookEntity.image] placeholderImage:nil];
    [headView addSubview:coverImageView];
    
    [headView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"H:|-%f-[coverImageView(%f)]", kLeft, kCoverImageViewWidth] options:0 metrics:nil views:NSDictionaryOfVariableBindings(coverImageView)]];
    [headView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"V:|-%f-[coverImageView(%f)]", kCoverImageViewOriginY, kCoverImageViewHeight] options:0 metrics:nil views:NSDictionaryOfVariableBindings(coverImageView)]];
    
    // 标题
    UILabel *titleLabel = [UILabel new];
    titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    titleLabel.text = self.bookEntity.title;
    titleLabel.font = [UIFont systemFontOfSize:kTitleFontSize];
    titleLabel.textColor = [UIColor whiteColor];
    [headView addSubview:titleLabel];
    
    [headView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"H:[coverImageView]-%f-[titleLabel]-(>=%f)-|", kConverImageAndItemLabel, kRight] options:NSLayoutFormatAlignAllTop metrics:nil views:NSDictionaryOfVariableBindings(coverImageView, titleLabel)]];
    
    // 详细信息
    NSMutableArray *itemsText = [@[] mutableCopy];
    
    if (self.bookEntity.authors) {
        NSString *authorList = @"";
        for (AuthorModel *author in self.bookEntity.authors) {
            authorList = [[authorList stringByAppendingString:author.name] stringByAppendingString:@" "];
        }
        [itemsText addObject:[NSString stringWithFormat:@"作者：%@", authorList]];
    }
    
    if (self.bookEntity.translators) {
        NSString *translatorList = @"";
        for (TranslatorModel *translator in self.bookEntity.translators) {
            translatorList = [[translatorList stringByAppendingString:translator.name] stringByAppendingString:@" "];
        }
        [itemsText addObject:[NSString stringWithFormat:@"译者：%@", translatorList]];
    }
    
    if (self.bookEntity.publisher) {
        [itemsText addObject:[NSString stringWithFormat:@"出版社：%@", self.bookEntity.publisher]];
    }
    
    if (self.bookEntity.pubdate) {
        [itemsText addObject:[NSString stringWithFormat:@"出版年份：%@", self.bookEntity.pubdate]];
    }
    
    if (self.bookEntity.price) {
        [itemsText addObject:[NSString stringWithFormat:@"定价：%@", self.bookEntity.price]];
    }
    
    if (self.bookEntity.isbn13) {
        [itemsText addObject:[NSString stringWithFormat:@"ISBN：%@", self.bookEntity.isbn13]];
    } else if (self.bookEntity.isbn10) {
        [itemsText addObject:[NSString stringWithFormat:@"ISBN：%@", self.bookEntity.isbn10]];
    }
    
    
    __block UILabel *lastLabel = titleLabel;
    
    [itemsText enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UILabel *itemLabel = [UILabel new];
        itemLabel.translatesAutoresizingMaskIntoConstraints = NO;
        itemLabel.text = obj;
        itemLabel.font = [UIFont systemFontOfSize:kItemLabelFontSize];
        itemLabel.textColor = [UIColor whiteColor];
        [headView addSubview:itemLabel];
        
        [headView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"H:[coverImageView]-%f-[itemLabel]-(>=%f)-|", kConverImageAndItemLabel, kRight] options:0 metrics:nil views:NSDictionaryOfVariableBindings(coverImageView, itemLabel)]];
        [headView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[lastLabel]-4-[itemLabel]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(lastLabel, itemLabel)]];
        
        lastLabel = itemLabel;
    }];
    
    // 收藏按钮
    UIButton *favButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.favButton = favButton;
    favButton.translatesAutoresizingMaskIntoConstraints = NO;
    favButton.titleLabel.font = [UIFont systemFontOfSize:kFavButtonFontSize];
    [favButton setBackgroundColor:[UIColor whiteColor]];
    [favButton setTitle:@"收藏" forState:UIControlStateNormal];
    [favButton setTitle:@"已收藏" forState:UIControlStateDisabled];
    [favButton setTitleColor:UIColorFromRGB(0x00A25B) forState:UIControlStateNormal];
    [favButton setTitleColor:UIColorFromRGB(0xBBBBBB) forState:UIControlStateDisabled];
    favButton.layer.cornerRadius = 2.0f;
    [favButton addTarget:self action:@selector(didTapFavButton:) forControlEvents:UIControlEventTouchUpInside];
    
    [headView addSubview:favButton];
    
    // 检查是否已经收藏过了
    BookEntity *bookEntity = [BookDetailService searchFavedBookWithDoubanId:self.bookEntity.doubanId];
    if (bookEntity) {
        favButton.enabled = NO;
    }
    
    [headView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[coverImageView]-14-[favButton(==70)]" options:NSLayoutFormatAlignAllBottom metrics:nil views:NSDictionaryOfVariableBindings(coverImageView, favButton)]];
    [headView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[favButton(==27)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(favButton)]];
    
    // 取消收藏按钮
    UIButton *unFavButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.unFavButton = unFavButton;
    unFavButton.translatesAutoresizingMaskIntoConstraints = NO;
    unFavButton.titleLabel.font = [UIFont systemFontOfSize:kFavButtonFontSize];
    [unFavButton setBackgroundColor:[UIColor whiteColor]];
    [unFavButton setTitle:@"取消收藏" forState:UIControlStateNormal];
    [unFavButton setTitleColor:UIColorFromRGB(0x00A25B) forState:UIControlStateNormal];
    unFavButton.layer.cornerRadius = 2.0f;
    [unFavButton addTarget:self action:@selector(didTapUnfavButton:) forControlEvents:UIControlEventTouchUpInside];
    
    [headView addSubview:unFavButton];
    
    [headView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[favButton]-10-[unFavButton(==70)]" options:NSLayoutFormatAlignAllBottom metrics:nil views:NSDictionaryOfVariableBindings(favButton, unFavButton)]];
    [headView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[unFavButton(==27)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(unFavButton)]];
    
    if (favButton.isEnabled == NO) {
        unFavButton.hidden = NO;
    } else {
        unFavButton.hidden = YES;
        favButton.enabled = YES;
        unFavButton = nil;
    }
    
    // 底部
    UIView *bodyView = [UIView new];
    bodyView.translatesAutoresizingMaskIntoConstraints = NO;
    bodyView.backgroundColor = [UIColor whiteColor];
    [scrollView addSubview:bodyView];
    
    [scrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[bodyView(==scrollView)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(bodyView, scrollView)]];
    [scrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[headView]-0-[bodyView]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(headView, scrollView, bodyView)]];
    
    // 内容简介
    UILabel *summaryLabel = [UILabel new];
    summaryLabel.text = @"内容简介";
    summaryLabel.font = [UIFont systemFontOfSize:kSummaryLabelFontSize];
    summaryLabel.textColor = UIColorFromRGB(0x555555);
    summaryLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [bodyView addSubview:summaryLabel];
    
    // 内容简介详情
    UILabel *detailLabel = [UILabel new];
    detailLabel.numberOfLines = 0;
    detailLabel.text = self.bookEntity.summary;
    detailLabel.font = [UIFont systemFontOfSize:kDetailLabelFontSize];
    detailLabel.textColor = UIColorFromRGB(0x999999);
    detailLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [bodyView addSubview:detailLabel];
    
    [bodyView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-15-[summaryLabel]-6.5-[detailLabel]-15-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(summaryLabel, detailLabel)]];
    [bodyView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[summaryLabel]-15-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(summaryLabel)]];
    [bodyView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[detailLabel]-15-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(detailLabel)]];
    
}

#pragma mark -- scroll response

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    // 向下滚动
    if (scrollView.contentOffset.y < 0) {
        self.backgroundImageView.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), kBackgroundImageViewHeight - scrollView.contentOffset.y);
    } else {
        self.backgroundImageView.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), kBackgroundImageViewHeight);
    }
    
}

#pragma mark -- actions

- (void)didTapFavButton:(UIButton *)button {
    //
    long long bookId = [BookDetailService favBook:self.bookEntity];
    if (bookId > 0) {
        [self.favButton setEnabled:NO];
        self.unFavButton.hidden = NO;
        NSLog(@"%lld", bookId);
    } else {
        NSLog(@"收藏失败 !");
    }
}


- (void)didTapUnfavButton:(UIButton *)button {
    
    BookEntity *bookEntity = [BookDetailService searchFavedBookWithDoubanId:self.bookEntity.doubanId];
    
    BOOL success = [BookDetailService unFavBookWithId:bookEntity.id];
    
    if (success) {
        self.unFavButton.hidden = YES;
        [self.favButton setEnabled:YES];
    } else {
        NSLog(@"取消收藏失败! ");
    }
    
}




@end
