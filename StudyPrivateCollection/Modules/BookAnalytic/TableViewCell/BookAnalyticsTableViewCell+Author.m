//
//  BookAnalyticsTableViewCell+Author.m
//  StudyPrivateCollection
//
//  Created by 彭益伟 on 01/01/2017.
//  Copyright © 2017 pengyiwei. All rights reserved.
//

#import "BookAnalyticsTableViewCell+Author.h"

#import "BookEntity.h"
#import "AuthorModel.h"

@implementation BookAnalyticsTableViewCell (Author)

- (void)configureWithBookEntity:(BookEntity *)bookEntity {
    
    NSString *authorList = @"";
    for (AuthorModel *author in bookEntity.authors) {
        authorList = [[authorList stringByAppendingString:author.name] stringByAppendingString:@" "];
    }
    self.authorNameLabel.text = [NSString stringWithFormat:@"%@", authorList];
    
}

@end
