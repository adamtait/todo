//
//  StaticCell.m
//  Todo
//
//  Created by Adam Tait on 1/24/14.
//  Copyright (c) 2014 Adam Tait. All rights reserved.
//

#import "StaticCell.h"
#import "CellTextView.h"

@interface StaticCell ()

    @property BOOL completed;

@end

@implementation StaticCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        // remove all subviews from the UITableViewCell contentView
        [[self.contentView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
        
        self.cellTextView = [[CellTextView alloc] initWithFrame:CGRectMake(14, 8, 288, 30)];
        [self.contentView addSubview:self.cellTextView.getTextView];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    NSLog(@"StaticCell got setEditing / %hhd /", editing);
    [super setEditing:editing animated:animated];
}

#pragma event handler

- (BOOL)resignFirstResponder
{
    NSLog(@"StaticCell got resignFirstResponder");
    [self.cellTextView.getTextView resignFirstResponder];
    return [super resignFirstResponder];
}


@end
