//
//  BookListCollectionViewController.m
//  StudyPrivateCollection
//
//  Created by 彭益伟 on 26/12/2016.
//  Copyright © 2016 pengyiwei. All rights reserved.
//

#import "BookListCollectionViewController.h"

#import "BookCollectionViewCell.h"
#import "BookCollectionViewCell+BookEntity.h"
#import "BookListService.h"
#import "BookEntity.h"
#import "BookDetailService.h"
#import "BookDetailViewController.h"
#import "BookCollectionViewWaterfallHeader.h"
#import "BookCollectionViewWaterfallFooter.h"

@interface BookListCollectionViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, CHTCollectionViewDelegateWaterfallLayout>

@property (nonatomic, strong) NSMutableArray<BookEntity *> *bookEntites;

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) NSArray *cellSizes;

@property (nonatomic, strong) BookCollectionViewCell *cell;

@end

@implementation BookListCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    [self initTableView];
    [self getData];
    
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    [self updateLayoutForOrientation:[UIApplication sharedApplication].statusBarOrientation];
    
    [self initTableView];
    [self getData];
    
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    [super willAnimateRotationToInterfaceOrientation:toInterfaceOrientation duration:duration];
    [self updateLayoutForOrientation:toInterfaceOrientation];
}

- (void)updateLayoutForOrientation:(UIInterfaceOrientation)orientation {
    CHTCollectionViewWaterfallLayout *layout =
    (CHTCollectionViewWaterfallLayout *)self.collectionView.collectionViewLayout;
    layout.columnCount = UIInterfaceOrientationIsPortrait(orientation) ? 2 : 3;
}

- (NSArray *)cellSizes {
    if (!_cellSizes) {
        _cellSizes = @[
                       [NSValue valueWithCGSize:CGSizeMake(240, 400)]
                       ];
    }
    return _cellSizes;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- data

- (void)getData {
    self.bookEntites = [[BookListService getAllBookEntitles] mutableCopy];
    [self.collectionView reloadData];
}

#pragma mark -- subviews

- (void)initTableView {
    
    CHTCollectionViewWaterfallLayout *layout = [[CHTCollectionViewWaterfallLayout alloc] init];
    
    layout.sectionInset = UIEdgeInsetsMake(20, 20, 20, 20);
    layout.headerHeight = 0;
    layout.footerHeight = 20+64+44;
    layout.minimumColumnSpacing = 10;
    layout.minimumInteritemSpacing = 5;
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)) collectionViewLayout:layout];
    self.collectionView = collectionView;
    collectionView.backgroundColor = UIColorFromRGB(0xF9F9F9);
    collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    collectionView.delegate = self;
    collectionView.dataSource = self;
    
    [_collectionView registerClass:[BookCollectionViewCell class]
        forCellWithReuseIdentifier:CELL_IDENTIFIER];
    
    [_collectionView registerClass:[BookCollectionViewWaterfallHeader class]
        forSupplementaryViewOfKind:CHTCollectionElementKindSectionHeader
               withReuseIdentifier:HEADER_IDENTIFIER];
    [_collectionView registerClass:[BookCollectionViewWaterfallFooter class]
        forSupplementaryViewOfKind:CHTCollectionElementKindSectionFooter
               withReuseIdentifier:FOOTER_IDENTIFIER];
    
    [self.view addSubview:collectionView];
    
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.bookEntites.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
//    UILongPressGestureRecognizer *longGR = [[ UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPress:)];
    
    // 1.创建Tap手势对象
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapDeleteBook:)];
    // 2.设置tap手势的常用属性
    // 设置手势触发时,需要点击的次数
    tapGR.numberOfTapsRequired = 1;
    // 设置手势触发时,需要的触点数
    tapGR.numberOfTouchesRequired = 1;
    
    BookCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CELL_IDENTIFIER forIndexPath:indexPath];
    self.cell = cell;
    [cell.deleteImageView addGestureRecognizer:tapGR];
//    [cell addGestureRecognizer:longGR];
    
    BookEntity *entity = [self.bookEntites objectAtIndex:indexPath.row];
    
    cell.deleteImageView.tag = indexPath.row;
//    cell.tag = indexPath.row;
    
    [cell configureWithBookEntity:entity];
    
    return cell;
}

//- (void)longPress:(UILongPressGestureRecognizer *)gr {
//    
//    self.bookEntites.count;
//    
//    NSIndexPath *indexPath = nil;
//    
//    if (gr.view.tag != self.bookEntites.count-1 && self.bookEntites.count < 4) {
//        indexPath = [NSIndexPath indexPathForRow:gr.view.tag-1 inSection:0];
//    } else {
//        indexPath = [NSIndexPath indexPathForRow:gr.view.tag inSection:0];
//    }
//    
////    indexPath = [NSIndexPath indexPathForRow:gr.view.tag inSection:0];
//    BookCollectionViewCell *cell = [self.collectionView cellForItemAtIndexPath:indexPath];
//    cell.deleteImageView.hidden = NO;
//    
//}

-(void)tapDeleteBook:(UITapGestureRecognizer *)gr {
    
    CGPoint point = [gr locationInView:gr.view];
    NSLog(@"%@",NSStringFromCGPoint(point));
    
    BookEntity *entity = [self.bookEntites objectAtIndex:gr.view.tag];
    
    BOOL success = [BookDetailService unFavBookWithId:entity.id];
    
    if (!success) {
        NSLog(@"删除失败 !");
    } else {
        if (self.bookEntites.count > 1) {
            [self.bookEntites removeObjectAtIndex:gr.view.tag];
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:gr.view.tag inSection:0];
            [self.collectionView deleteItemsAtIndexPaths:@[indexPath]];
            [self.collectionView reloadItemsAtIndexPaths:@[indexPath]];
        } else {
            [self.bookEntites removeObjectAtIndex:gr.view.tag];
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:gr.view.tag inSection:0];
            [self.collectionView deleteItemsAtIndexPaths:@[indexPath]];
        }
    }
    
}

#pragma mark <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    BookCollectionViewCell *cell = [self.collectionView cellForItemAtIndexPath:indexPath];
    cell.deleteImageView.hidden = YES;
    
    BookEntity *entity = [self.bookEntites objectAtIndex:indexPath.row];
    
    BookDetailViewController *bookDetail = [BookDetailViewController new];
    [bookDetail setBookEntity:entity];
    [self.navigationController pushViewController:bookDetail animated:YES];
    
    NSLog(@"%ld", indexPath.row);
    
}

#pragma mark - CHTCollectionViewDelegateWaterfallLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return [self.cellSizes[indexPath.item % [_cellSizes count]] CGSizeValue];
}

@end
