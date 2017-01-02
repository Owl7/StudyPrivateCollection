//
//  AuthorModel.h
//  StudyPrivateCollection
//
//  Created by 彭益伟 on 23/12/2016.
//  Copyright © 2016 pengyiwei. All rights reserved.
//

#import "BaseModel.h"

@interface AuthorModel : BaseModel

// 图书本地id
@property (nonatomic, assign) long long bookId;

// 作者名字
@property (nonatomic, copy) NSString *name;

@property (nonatomic, strong) UIColor *color;

@end
