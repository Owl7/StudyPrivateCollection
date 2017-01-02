//
//  BookDetailService.h
//  StudyPrivateCollection
//
//  Created by 彭益伟 on 26/12/2016.
//  Copyright © 2016 pengyiwei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BookEntity.h"

@interface BookDetailService : NSObject

// 收藏图书
+ (long long)favBook:(BookEntity *)bookEntity;

// 取消收藏
+ (BOOL)unFavBookWithId:(long long)id;

// 使用豆瓣id搜索数据库中是否有已经收藏的书籍
+ (BookEntity *)searchFavedBookWithDoubanId:(long long)doubanId;

@end
