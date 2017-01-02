//
//  BaseDAO.m
//  StudyPrivateCollection
//
//  Created by 彭益伟 on 26/12/2016.
//  Copyright © 2016 pengyiwei. All rights reserved.
//

#import "BaseDAO.h"

@implementation BaseDAO

+ (long long)insertModel:(BaseModel *)model withDataBase:(FMDatabase *)db {
    
    NSString *msg = [NSString stringWithFormat:@"%s is not implemented for the class %@", sel_getName(_cmd), self];
    
    @throw [NSException exceptionWithName:@"BookDAOMethodExcepthion" reason:msg userInfo:nil];
    
}

@end
