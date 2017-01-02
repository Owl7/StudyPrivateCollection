//
//  BookCollectionViewCell+BookEntity.h
//  StudyPrivateCollection
//
//  Created by 彭益伟 on 28/12/2016.
//  Copyright © 2016 pengyiwei. All rights reserved.
//

#import "BookCollectionViewCell.h"

@class BookEntity;

@interface BookCollectionViewCell (BookEntity)

- (void)configureWithBookEntity:(BookEntity *)bookEntity;

@end
