//
//  BookCollectionViewCell.m
//  StudyPrivateCollection
//
//  Created by 彭益伟 on 28/12/2016.
//  Copyright © 2016 pengyiwei. All rights reserved.
//

#import "BookCollectionViewCell.h"

static const float kCoverImageViewHeight = 161;         // 封面图片高度
static const float kCoverImageViewWidth = 115;          // 封面图片宽度

@interface BookCollectionViewCell()


@end

@implementation BookCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        [self initSubviews];
    }
    
    return self;
    
}

- (void)initSubviews {
    
    UILongPressGestureRecognizer *longGR = [[ UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPress:)];
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapHidenDeleteView:)];
    
    // 长按手势特有的设置,就是最小时间间隔
    longGR.minimumPressDuration = 0.5;
    
    // 设置手势触发时,需要点击的次数
    tapGR.numberOfTapsRequired = 2;
    // 设置手势触发时,需要的触点数
    tapGR.numberOfTouchesRequired = 1;
    
    self.contentView.backgroundColor = UIColorFromRGB(0xF9F9F9);
    
    self.coverImageView = [UIImageView new];
    self.coverImageView.translatesAutoresizingMaskIntoConstraints = NO;
    self.coverImageView.userInteractionEnabled = YES;
    
    [self.coverImageView addGestureRecognizer:tapGR];
    [self.coverImageView addGestureRecognizer:longGR];
    
    [self.contentView addSubview:self.coverImageView];
    
    [self.coverImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(30/2);
        make.width.mas_equalTo(self.bounds.size.width-30/2);
        make.height.mas_equalTo(self.bounds.size.height/4*3);
    }];
    
    _deleteImageView = [UIImageView new];
    _deleteImageView.userInteractionEnabled = YES;
    _deleteImageView.layer.cornerRadius = 30/2;
    _deleteImageView.layer.masksToBounds = YES;
    _deleteImageView.image = [UIImage imageNamed:@"delete"];
    [self.contentView addSubview:_deleteImageView];
    
    [_deleteImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(30, 30));
        make.top.right.mas_equalTo(self);
    }];
    
    _deleteImageView.hidden = YES;
    
    self.titleLabel = [UILabel new];
    self.titleLabel.font = [UIFont systemFontOfSize:13.0f];
    self.titleLabel.textColor = UIColorFromRGB(0x555555);
    self.titleLabel.numberOfLines = 2;
    [self.titleLabel sizeToFit];
    self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:self.titleLabel];
    
    [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.coverImageView.mas_bottom);
        make.left.right.mas_equalTo(self.coverImageView);
        make.size.mas_equalTo(CGSizeMake(self.bounds.size.width-30/2, 40));
    }];
    
    
    
}

- (void)longPress:(UILongPressGestureRecognizer *)gr {
    
    CGPoint point = [gr locationInView:self.coverImageView];
    NSLog(@"%@",NSStringFromCGPoint(point));
    
    self.deleteImageView.hidden = NO;
    
}

-(void)tapHidenDeleteView:(UITapGestureRecognizer *)gr {
    
    CGPoint point = [gr locationInView:self.deleteImageView];
    NSLog(@"%@",NSStringFromCGPoint(point));
    
    self.deleteImageView.hidden = YES;
    
}

- (void)prepareForReuse {
    
    self.titleLabel.text = nil;
    self.coverImageView.image = nil;
    self.deleteImageView.image = nil;
    
}

@end
