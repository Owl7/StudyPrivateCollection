//
//  TagModel.h
//  StudyPrivateCollection
//
//  Created by 彭益伟 on 23/12/2016.
//  Copyright © 2016 pengyiwei. All rights reserved.
//

#import "BaseModel.h"

@interface TagModel : BaseModel

// 图书本地id
@property (nonatomic, assign) long long bookId;

// 标签名字
@property (nonatomic, copy) NSString *name;

// 标签次数
@property (nonatomic, assign) long count;


@end
