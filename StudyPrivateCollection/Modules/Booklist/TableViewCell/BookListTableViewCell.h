//
//  BookListTableViewCell.h
//  StudyPrivateCollection
//
//  Created by 彭益伟 on 27/12/2016.
//  Copyright © 2016 pengyiwei. All rights reserved.
//

#import "BookBaseTableViewCell.h"

@interface BookListTableViewCell : BookBaseTableViewCell

@property (nonatomic, strong) UIImageView *coverImageView;
@property (nonatomic, strong) UILabel *authorLabel;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *tagesView;

@end
