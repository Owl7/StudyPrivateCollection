//
//  BaseDAO.h
//  StudyPrivateCollection
//
//  Created by 彭益伟 on 26/12/2016.
//  Copyright © 2016 pengyiwei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"

@interface BaseDAO : NSObject

+ (long long)insertModel:(BaseModel *)model withDataBase:(FMDatabase *)db;

@end
