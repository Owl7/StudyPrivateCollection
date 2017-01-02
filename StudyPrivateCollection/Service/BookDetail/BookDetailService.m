//
//  BookDetailService.m
//  StudyPrivateCollection
//
//  Created by 彭益伟 on 26/12/2016.
//  Copyright © 2016 pengyiwei. All rights reserved.
//

#import "BookDetailService.h"
#import "BookDBHelper.h"
#import "BookEntityDAO.h"
#import "AuthorDAO.h"
#import "TranslatorDAO.h"
#import "TagDAO.h"

@implementation BookDetailService

+ (long long)favBook:(BookEntity *)bookEntity {
    
    FMDatabase *db = [FMDatabase databaseWithPath:[BookDBHelper dbPath]];
    if (![db open]) {
        return 0;
    }
    
    // 保存图书
    long long bookId = [BookEntityDAO insertModel:bookEntity withDataBase:db];
    if (!bookId) {
        return bookId;
    }
    
    // 保存作者
    [bookEntity.authors enumerateObjectsUsingBlock:^(AuthorModel *_Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.bookId = bookId;
        [AuthorDAO insertModel:obj withDataBase:db];
    }];
    
    // 保存译者
    [bookEntity.translators enumerateObjectsUsingBlock:^(TranslatorModel *_Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.bookId = bookId;
        [TranslatorDAO insertModel:obj withDataBase:db];
    }];
    
    // 保存Tag
    [bookEntity.tags enumerateObjectsUsingBlock:^(TagModel *_Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.bookId = bookId;
        [TagDAO insertModel:obj withDataBase:db];
    }];
    
    [db close];
    
    return bookId;
    
}

+ (BookEntity *)searchFavedBookWithDoubanId:(long long)doubanId {
    
    FMDatabase *db = [FMDatabase databaseWithPath:[BookDBHelper dbPath]];
    
    if (![db open]) {
        return 0;
    }
    
    BookEntity *book = [BookEntityDAO queryModelByDoubanId:doubanId withDataBase:db];
    
    [db close];
    
    return book;
    
}


+ (BOOL)unFavBookWithId:(long long)id {
    
    FMDatabase *db = [FMDatabase databaseWithPath:[BookDBHelper dbPath]];
    
    if (![db open]) {
        return 0;
    }
    
    BOOL success = NO;
    
    BOOL bookEntityFlag = [BookEntityDAO deleteModelWithId:id withDataBase:db];
    BOOL bookAuthorFlag = [AuthorDAO deleteModelWithBookId:id withDataBase:db];
    BOOL bookTranslatorFlag = [TranslatorDAO deleteModelWithBookId:id withDataBase:db];
    BOOL bookTagFlag = [TagDAO deleteModelWithBookId:id withDataBase:db];
    
    if (bookEntityFlag && bookAuthorFlag && bookTranslatorFlag && bookTagFlag) {
        success = YES;
    }
    
    [db close];
    
    return success;
    
}



@end
