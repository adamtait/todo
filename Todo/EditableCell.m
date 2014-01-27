//
//  EditableCell.m
//  Todo
//
//  Created by Adam Tait on 1/24/14.
//  Copyright (c) 2014 Adam Tait. All rights reserved.
//

#import "EditableCell.h"

@interface EditableCell ()

@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UITextView *textView;

@end

@implementation EditableCell

- (id)init
{
    self = [super init];
    if (self) {
        [[self.contentView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];;
        self.textField = [[UITextField alloc] init];
        [self.textField setFrame:CGRectMake(14, 8, 288, 30)];
        [self.contentView addSubview:self.textField];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    NSLog(@"got setSelected / %hhd /", selected);
    [super setSelected:selected animated:animated];
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    NSLog(@"EditableCell got setEditing / %hhd /", editing);
    [super setEditing:editing animated:animated];
}

- (void)cellWillShow
{
    [_textField becomeFirstResponder];
}

- (NSString *)getText
{
    return _textField.text;
}

@end
