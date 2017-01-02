//
//  BookCollectionViewFlowLayout.m
//  StudyPrivateCollection
//
//  Created by 彭益伟 on 28/12/2016.
//  Copyright © 2016 pengyiwei. All rights reserved.
//

#import "BookCollectionViewFlowLayout.h"

@implementation BookCollectionViewFlowLayout

- (instancetype)init {
    if (self = [super init]) {
        //配置布局的参数信息
        self.itemSize = CGSizeMake(80, 80);
        self.minimumInteritemSpacing = 10;
        self.minimumLineSpacing = 10;
        self.scrollDirection = UICollectionViewScrollDirectionVertical;
        
        //内边距
        //sectionInset属性为 UIEdgeInsets类型的结构体
        self.sectionInset = UIEdgeInsetsMake(154, 30, 154, 30);
    }
    return self;
}

@end
