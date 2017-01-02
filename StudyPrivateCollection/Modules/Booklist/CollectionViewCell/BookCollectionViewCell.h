//
//  BookCollectionViewCell.h
//  StudyPrivateCollection
//
//  Created by 彭益伟 on 28/12/2016.
//  Copyright © 2016 pengyiwei. All rights reserved.
//

#import "BookBaseCollectionViewCell.h"

@interface BookCollectionViewCell : BookBaseCollectionViewCell

@property (nonatomic, strong) UIImageView *coverImageView;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIImageView *deleteImageView;

@end
