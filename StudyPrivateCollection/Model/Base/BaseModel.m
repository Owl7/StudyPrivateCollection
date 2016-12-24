//
//  BaseModel.m
//  StudyPrivateCollection
//
//  Created by 彭益伟 on 23/12/2016.
//  Copyright © 2016 pengyiwei. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel

- (instancetype)initWithDictionary:(NSDictionary *)dic {
    
    NSString *msg = [NSString stringWithFormat:@"%s is no implemented for the class %@", sel_getName(_cmd), self];
    
    @throw [NSException exceptionWithName:@"BookModelInitializerException" reason:msg userInfo:nil];
    
}

- (id)copyWithZone:(NSZone *)zone {
    
    NSString *msg = [NSString stringWithFormat:@"%s is no implemented for the class %@", sel_getName(_cmd), self];
    
    @throw [NSException exceptionWithName:@"BookModelInitializerException" reason:msg userInfo:nil];
    
}

#pragma mark - convert

- (NSArray *)modelArrayFromDictArray:(NSArray *)array withModelClass:(Class)modelClass {
    
    NSParameterAssert(modelClass != nil);
    NSParameterAssert([modelClass isSubclassOfClass:BaseModel.class]);
    
    NSMutableArray *models = [@[] mutableCopy];
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        BaseModel *baseModel = [[modelClass alloc] initWithDictionary:obj];
        [models addObject:baseModel];
    }];
    
    return models;
    
}

@end
