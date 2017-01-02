//
//  TranslatorDAO.h
//  StudyPrivateCollection
//
//  Created by 彭益伟 on 26/12/2016.
//  Copyright © 2016 pengyiwei. All rights reserved.
//

#import "BaseDAO.h"
#import "TranslatorModel.h"

@interface TranslatorDAO : BaseDAO

+ (long long)insertModel:(TranslatorModel *)translatorModel withDataBase:(FMDatabase *)db;

+ (BOOL)deleteModelWithBookId:(long long)bookId withDataBase:(FMDatabase *)db;

+ (NSArray<TranslatorModel *> *)queryModelsWithBookId:(long long)bookId withDataBase:(FMDatabase *)db;

@end
