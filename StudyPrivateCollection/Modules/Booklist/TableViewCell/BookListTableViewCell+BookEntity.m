//
//  BookListTableViewCell+BookEntity.m
//  StudyPrivateCollection
//
//  Created by 彭益伟 on 27/12/2016.
//  Copyright © 2016 pengyiwei. All rights reserved.
//

#import "BookListTableViewCell+BookEntity.h"

#import "BookEntity.h"
#import "AuthorModel.h"
#import "TagModel.h"

@implementation BookListTableViewCell (BookEntity)

- (void)configureWithBookEntity:(BookEntity *)bookEntity {
    
    self.titleLabel.text = bookEntity.title;
    
    NSString *authorList = @"";
    for (AuthorModel *author in bookEntity.authors) {
        authorList = [[authorList stringByAppendingString:author.name] stringByAppendingString:@" "];
    }
    
    self.authorLabel.text = [NSString stringWithFormat:@"作者: %@", authorList];
    [self.coverImageView sd_setImageWithURL:[NSURL URLWithString:bookEntity.image]];
    
    UIView *lastDocView = self.tagesView;
    for (NSInteger i = 0; i < MIN(bookEntity.tags.count, 4); i++) {
        TagModel *tag = [bookEntity.tags objectAtIndex:i];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitleColor:UIColorFromRGB(0x999999) forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:9.0f];
        button.layer.cornerRadius = 2.0f;
        button.layer.borderColor = UIColorFromRGB(0x999999).CGColor;
        button.layer.borderWidth = 0.5f;
        button.translatesAutoresizingMaskIntoConstraints = NO;
        [button setContentEdgeInsets:UIEdgeInsetsMake(3.0f, 5.0f, 3.0f, 5.0f)];
        [button setTitle:tag.name forState:UIControlStateNormal];
        [button sizeToFit];
        
        [self.tagesView addSubview:button];
        
        if ([lastDocView isEqual:self.tagesView]) {
            [self.tagesView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[button]" options:NSLayoutFormatAlignAllCenterY metrics:nil views:NSDictionaryOfVariableBindings(button)]];
            [self.tagesView addConstraint:[NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.tagesView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
        } else {
            [self.tagesView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[lastDocView]-8-[button]" options:NSLayoutFormatAlignAllCenterY metrics:nil views:NSDictionaryOfVariableBindings(lastDocView, button)]];
        }
        
        lastDocView = button;
        
    }
    
    [self.tagesView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[lastDocView]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(lastDocView)]];
    
}

@end
