//
//  AuthorDAO.h
//  StudyPrivateCollection
//
//  Created by 彭益伟 on 26/12/2016.
//  Copyright © 2016 pengyiwei. All rights reserved.
//

#import "BaseDAO.h"
#import "AuthorModel.h"

@interface AuthorDAO : BaseDAO

+ (long long)insertModel:(AuthorModel *)authorModel withDataBase:(FMDatabase *)db;

+ (BOOL)deleteModelWithBookId:(long long)bookId withDataBase:(FMDatabase *)db;

+ (NSArray<AuthorModel *> *)queryModelsWithBookId:(long long)bookId withDataBase:(FMDatabase *)db;

+ (NSArray<AuthorModel *> *)queryAllModelsWithDataBase:(FMDatabase *)db;

@end
