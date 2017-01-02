//
//  BookCollectionViewCell+BookEntity.m
//  StudyPrivateCollection
//
//  Created by 彭益伟 on 28/12/2016.
//  Copyright © 2016 pengyiwei. All rights reserved.
//

#import "BookCollectionViewCell+BookEntity.h"

#import "BookDetailService.h"
#import "BookEntity.h"

@implementation BookCollectionViewCell (BookEntity)

- (void)configureWithBookEntity:(BookEntity *)bookEntity {
    
    self.titleLabel.text = bookEntity.title;
    
    [self.coverImageView sd_setImageWithURL:[NSURL URLWithString:bookEntity.image]];
    
    self.deleteImageView.hidden = YES;
    
}

@end
