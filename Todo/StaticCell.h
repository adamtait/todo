//
//  StaticCell.h
//  Todo
//
//  Created by Adam Tait on 1/24/14.
//  Copyright (c) 2014 Adam Tait. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StaticCell : UITableViewCell <UITextViewDelegate>

@property (nonatomic, strong) NSString *content;

- (void)setEditing:(BOOL)editing animated:(BOOL)animated;
- (BOOL)resignFirstResponder;

- (void)updateContentWithString:(NSString *)content;
- (CGFloat)getHeight;

+ (UIFont *)defaultFont;
+ (NSLineBreakMode)defaultLineBreakMode;

@end
