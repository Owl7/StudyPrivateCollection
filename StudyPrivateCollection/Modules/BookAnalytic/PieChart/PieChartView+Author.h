//
//  PieChartView+Author.h
//  StudyPrivateCollection
//
//  Created by 彭益伟 on 31/12/2016.
//  Copyright © 2016 pengyiwei. All rights reserved.
//

#import "PieChartView.h"

@class BookEntity, AuthorModel;

@interface PieChartView (Author)

- (void)configureWithBookEntity:(NSArray<AuthorModel*> *)authors withRadius:(CGFloat)radius;

@end
