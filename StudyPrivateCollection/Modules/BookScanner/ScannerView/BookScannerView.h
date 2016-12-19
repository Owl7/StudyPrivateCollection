//
//  BookScannerView.h
//  StudyPrivateCollection
//
//  Created by 车车 on 16/12/16.
//  Copyright © 2016年 pengyiwei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BookScannerView : UIView

- (id)initWithFrame:(CGRect)frame rectSize:(CGSize)size offsetY:(CGFloat)offsetY;

- (void)startAnimation;

- (void)stopAnimation;

@end
