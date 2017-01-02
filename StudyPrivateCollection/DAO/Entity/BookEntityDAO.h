//
//  BookEntityDAO.h
//  StudyPrivateCollection
//
//  Created by 彭益伟 on 26/12/2016.
//  Copyright © 2016 pengyiwei. All rights reserved.
//

#import "BaseDAO.h"
#import "BookEntity.h"

@interface BookEntityDAO : BaseDAO

+ (long long)insertModel:(BookEntity *)bookEntity withDataBase:(FMDatabase *)db;

+ (BOOL)deleteModelWithId:(long long)id withDataBase:(FMDatabase *)db;

+ (BookEntity *)queryModelByDoubanId:(long long)doubanId withDataBase:(FMDatabase *)db;

+ (NSArray<BookEntity *> *)queryAllModelsWithDataBase:(FMDatabase *)db;

@end
