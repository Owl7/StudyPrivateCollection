//
//  BookDBHelper.h
//  StudyPrivateCollection
//
//  Created by 彭益伟 on 26/12/2016.
//  Copyright © 2016 pengyiwei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BookDBHelper : NSObject

+ (NSString *)dbFolder;

+ (NSString *)dbPath;

+ (void)bulldDataBase;

@end
