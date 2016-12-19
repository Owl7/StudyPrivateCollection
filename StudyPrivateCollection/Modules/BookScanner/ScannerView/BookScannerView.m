//
//  BookScannerView.m
//  StudyPrivateCollection
//
//  Created by 车车 on 16/12/16.
//  Copyright © 2016年 pengyiwei. All rights reserved.
//

#import "BookScannerView.h"

@interface BookScannerView()

// 扫描区域
@property (nonatomic, assign) CGSize rectSize;

// 扫描区域相对于view中心位置的偏移量，向上为正向下为负
@property (nonatomic, assign) CGFloat offsetY;

// 扫描线
@property (nonatomic, strong) UIImageView *animationLine;

// 是否反向扫描
@property (nonatomic, assign, getter=isAnimationReverse) BOOL animationReverse;

// 是否开始动画
@property (nonatomic, assign, getter=isAnimating) BOOL animating;

//
@property (nonatomic, strong) UILabel *textLabel;

// 计算基准坐标
@property (nonatomic, assign) CGFloat minX;
@property (nonatomic, assign) CGFloat minY;
@property (nonatomic, assign) CGFloat maxX;
@property (nonatomic, assign) CGFloat maxY;

@end

@implementation BookScannerView

- (id)initWithFrame:(CGRect)frame rectSize:(CGSize)size offsetY:(CGFloat)offsetY {
    
    if (self = [super initWithFrame:frame]) {
        self.rectSize = size;
        self.offsetY = offsetY;
    }
    
    return self;
    
}

- (UIImageView *)animationLine {
    if (!_animationLine) {
        _animationLine = [[UIImageView alloc] initWithFrame:CGRectMake(self.minX, self.minY, self.rectSize.width, 1.0f)];
        _animationLine.image = [UIImage imageNamed:@"scanner-line"];
        [self addSubview:_animationLine];
    }
    return _animationLine;
}

- (UILabel *)textLabel {
    if (!_textLabel) {
        _textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.maxY + 40, self.frame.size.width, 25)];
        _textLabel.text = @"将条形码放入输入框内，即可自动扫描";
        _textLabel.textColor = [UIColor whiteColor];
        _textLabel.textAlignment = NSTextAlignmentCenter;
        _textLabel.font = [UIFont systemFontOfSize:14];
        [self addSubview:_textLabel];
    }
    return _textLabel;
}

- (CGFloat)minX {
    if (!_minX) {
        _minX = (self.frame.size.width - self.rectSize.width) / 2;
    }
    return _minX;
}

- (CGFloat)minY {
    if (!_minY) {
        _minY = (self.frame.size.height - self.rectSize.height) / 2 + self.offsetY;
    }
    return _minY;
}

- (CGFloat)maxX {
    if (!_maxX) {
        _maxX = self.minX + self.rectSize.width;
    }
    return _maxX;
}

- (CGFloat)maxY {
    if (!_maxY) {
        _maxY = self.minY + self.rectSize.height;
    }
    return _maxY;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // 绘制黑色遮罩区域
    CGContextSetRGBFillColor(context, 0, 0, 0, 0.4f);
    
    CGContextFillRect(context, CGRectMake(0, 0, self.frame.size.width, self.minY));
    CGContextFillRect(context, CGRectMake(0, self.minY, self.minX, self.rectSize.height));
    CGContextFillRect(context, CGRectMake(0, self.maxY, self.frame.size.width, self.frame.size.height - self.maxY));
    CGContextFillRect(context, CGRectMake(self.maxX, self.minY, self.minX, self.rectSize.height));
    
    // 绘制中间区域的白色边框
    CGContextSetStrokeColorWithColor(context, [[UIColor whiteColor] CGColor]);
    CGContextSetLineWidth(context, 0.5f);
    
    CGContextAddRect(context, CGRectMake(self.minX, self.minY, self.rectSize.width, self.rectSize.height));
    
    CGContextStrokePath(context);
    
    // 绘制中间区域的四个角落
    CGFloat cornerLineLength = 9.0f;
    CGFloat cornerLineThick = 2.0f;
    
    CGContextSetStrokeColorWithColor(context, [[UIColor whiteColor] CGColor]);
    CGContextSetLineWidth(context, cornerLineThick);
    
    // 左上角
    CGContextMoveToPoint(context, self.minX + cornerLineLength, self.minY);
    CGContextAddLineToPoint(context, self.minX, self.minY);
    CGContextAddLineToPoint(context, self.minX, self.minY + cornerLineLength);
    
    // 右上角
    CGContextMoveToPoint(context, self.maxX - cornerLineLength, self.minY);
    CGContextAddLineToPoint(context, self.maxX, self.minY);
    CGContextAddLineToPoint(context, self.maxX, self.minY + cornerLineLength);
    
    // 左下角
    CGContextMoveToPoint(context, self.minX, self.maxY - cornerLineLength);
    CGContextAddLineToPoint(context, self.minX, self.maxY);
    CGContextAddLineToPoint(context, self.minX + cornerLineLength, self.maxY);
    
    // 右下角
    CGContextMoveToPoint(context, self.maxX - cornerLineLength, self.maxY);
    CGContextAddLineToPoint(context, self.maxX, self.maxY);
    CGContextAddLineToPoint(context, self.maxX, self.maxY - cornerLineLength);
    
    CGContextStrokePath(context);
    
    //添加文字
    self.textLabel.hidden = NO;
    
}


- (void)startAnimation {
    
    if (self.isAnimating) {
        return;
    }
    
    self.animating = YES;
    
    [UIView animateWithDuration:3.0f delay:0.5f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        if (self.isAnimationReverse) {
            self.animationLine.frame = CGRectMake(self.minX, self.minY, self.rectSize.width, 1.0f);
        }else {
            self.animationLine.frame = CGRectMake(self.minX, self.maxY, self.rectSize.width, 1.0f);
        }
    } completion:^(BOOL finished) {
        if (finished) {
            self.animationReverse = !self.animationReverse;
            self.animating = NO;
            [self startAnimation];
        }else {
            [self stopAnimation];
        }
    }];
    
}

- (void)stopAnimation {
    
    self.animating = NO;
    self.animationReverse = NO;
    [self.animationLine removeFromSuperview];
    self.animationLine = nil;
    
}








@end
