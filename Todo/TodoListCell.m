//
//  TodoListCell.m
//  Todo
//
//  Created by Adam Tait on 1/27/14.
//  Copyright (c) 2014 Adam Tait. All rights reserved.
//

#import "TodoListCell.h"
#import "CellTextView.h"

@interface TodoListCell ()

    // private properties
    @property (nonatomic, strong) CellTextView *cellTextView;
    @property BOOL completed;

    // private methods
    - (void)setup;

@end


@implementation TodoListCell

#pragma public initialization methods

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setup];
    }
    return self;
}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self setup];
    }
    return self;
}


#pragma private initialization methods

- (void)setup
{
    // remove all subviews from the UITableViewCell contentView
    [[self.contentView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    self.cellTextView = [[CellTextView alloc] initWithFrame:CGRectMake(14, 8, 288, 30)];
    [self.contentView addSubview:self.cellTextView.getTextView];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    NSLog(@"TodoListCell got setEditing / %hhd /", editing);
    [super setEditing:editing animated:animated];
}


#pragma accessors for CellTextView property

- (NSString *)getText
{
    return [self.cellTextView getTextView].text;
}

- (void)updateContentWithString:(NSString *)content
{
    [self.cellTextView updateContentWithString:content];
}


#pragma UIResponder

- (BOOL)becomeFirstResponder
{
    NSLog(@"TodoListCell is going to becomeFirstResponder");
    [self.cellTextView becomeFirstResponder];
    return [super becomeFirstResponder];
}

@end
