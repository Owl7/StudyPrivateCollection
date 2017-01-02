//
//  TagDAO.h
//  StudyPrivateCollection
//
//  Created by 彭益伟 on 26/12/2016.
//  Copyright © 2016 pengyiwei. All rights reserved.
//

#import "BaseDAO.h"
#import "TagModel.h"

@interface TagDAO : BaseDAO

+ (long long)insertModel:(TagModel *)tagModel withDataBase:(FMDatabase *)db;

+ (BOOL)deleteModelWithBookId:(long long)bookId withDataBase:(FMDatabase *)db;

+ (NSArray<TagModel *> *)queryModelsWithBookId:(long long)bookId withDataBase:(FMDatabase *)db;

@end
