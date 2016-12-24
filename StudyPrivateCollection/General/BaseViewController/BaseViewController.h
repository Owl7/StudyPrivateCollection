//
//  BaseViewController.h
//  StudyPrivateCollection
//
//  Created by 彭益伟 on 23/12/2016.
//  Copyright © 2016 pengyiwei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

- (UIImage *)navigationBarBackgroundImage;

- (BOOL)shouldShadowImage;

- (BOOL)shouldHideBottomBarwhenPushed;

@end
