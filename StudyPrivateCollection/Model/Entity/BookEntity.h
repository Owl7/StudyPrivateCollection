//
//  BookEntity.h
//  StudyPrivateCollection
//
//  Created by 彭益伟 on 23/12/2016.
//  Copyright © 2016 pengyiwei. All rights reserved.
//

#import "BaseModel.h"

@interface BookEntity : BaseModel

// 图书本地id
@property (nonatomic, assign) long long id;

// 图书豆瓣id
@property (nonatomic, assign) long long doubanId;

// ISBN10
@property (nonatomic, copy) NSString *isbn10;

// ISBN13
@property (nonatomic, copy) NSString *isbn13;

// 图书名称
@property (nonatomic, copy) NSString *title;

// 豆瓣图书URL
@property (nonatomic, copy) NSString *doubanUrl;

// 图书封面URL
@property (nonatomic, copy) NSString *image;

// 出版社
@property (nonatomic, copy) NSString *publisher;

// 发行时间
@property (nonatomic, copy) NSString *pubdate;

// 价格
@property (nonatomic, copy) NSString *price;

// 书籍简介
@property (nonatomic, copy) NSString *summary;

// 作者介绍
@property (nonatomic, copy) NSString *author_intro;

// 作者
@property (nonatomic, copy) NSArray *authors;

// 译者
@property (nonatomic, copy) NSArray *translators;

// 标签
@property (nonatomic, copy) NSArray *tags;

@end
