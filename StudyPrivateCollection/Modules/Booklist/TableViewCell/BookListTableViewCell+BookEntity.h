//
//  BookListTableViewCell+BookEntity.h
//  StudyPrivateCollection
//
//  Created by 彭益伟 on 27/12/2016.
//  Copyright © 2016 pengyiwei. All rights reserved.
//

#import "BookListTableViewCell.h"

@class BookEntity;

@interface BookListTableViewCell (BookEntity)

- (void)configureWithBookEntity:(BookEntity *)bookEntity;

@end
