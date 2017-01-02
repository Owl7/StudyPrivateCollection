//
//  PieChartView+Author.m
//  StudyPrivateCollection
//
//  Created by 彭益伟 on 31/12/2016.
//  Copyright © 2016 pengyiwei. All rights reserved.
//

#import "PieChartView+Author.h"

#import "BookEntity.h"
#import "AuthorModel.h"

@implementation PieChartView (Author)

- (void)configureWithBookEntity:(NSArray<AuthorModel*> *)authors withRadius:(CGFloat)radius {
    
    for (NSArray *item in authors) {
        self.sumAuthorCount += item.count;
    }
    
    self.authorArr = authors;
    
    self.radius = radius;
    
}

@end
