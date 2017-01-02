//
//  BookListService.m
//  StudyPrivateCollection
//
//  Created by 彭益伟 on 26/12/2016.
//  Copyright © 2016 pengyiwei. All rights reserved.
//

#import "BookListService.h"

#import "BookDBHelper.h"
#import "BookEntityDAO.h"
#import "AuthorDAO.h"
#import "TranslatorDAO.h"
#import "TagDAO.h"

@implementation BookListService

+ (NSArray<BookEntity *> *)getAllBookEntitles {
    
    FMDatabase *db = [FMDatabase databaseWithPath:[BookDBHelper dbPath]];
    
    if (![db open]) {
        return 0;
    }
    
    NSArray *bookEntityles = [BookEntityDAO queryAllModelsWithDataBase:db];
    
    for (BookEntity *entity in bookEntityles) {
        entity.authors = [AuthorDAO queryModelsWithBookId:entity.id withDataBase:db];
        entity.translators = [TranslatorDAO queryModelsWithBookId:entity.id withDataBase:db];
        entity.tags = [TagDAO queryModelsWithBookId:entity.id withDataBase:db];
    }
    
    [db close];
    
    return bookEntityles;
    
}

@end
