//
//  BaseModel.h
//  StudyPrivateCollection
//
//  Created by 彭益伟 on 23/12/2016.
//  Copyright © 2016 pengyiwei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseModel : NSObject<NSCopying>

- (instancetype)initWithDictionary:(NSDictionary *)dic;

- (instancetype)initWithFMResultSet:(FMResultSet *)result;

- (NSArray *)modelArrayFromDictArray:(NSArray *)array withModelClass:(Class)modelClass;

@end
