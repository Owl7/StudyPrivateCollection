//
//  BookAnalyticsTableViewCell+Author.h
//  StudyPrivateCollection
//
//  Created by 彭益伟 on 01/01/2017.
//  Copyright © 2017 pengyiwei. All rights reserved.
//

#import "BookAnalyticsTableViewCell.h"

@class BookEntity;

@interface BookAnalyticsTableViewCell (Author)

- (void)configureWithBookEntity:(BookEntity *)bookEntity;

@end
