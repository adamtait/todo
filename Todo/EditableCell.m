//
//  EditableCell.m
//  Todo
//
//  Created by Adam Tait on 1/24/14.
//  Copyright (c) 2014 Adam Tait. All rights reserved.
//

#import "EditableCell.h"
#import "CellTextView.h"

@interface EditableCell ()

    @property (nonatomic, strong) CellTextView *cellTextView;

@end

@implementation EditableCell

- (id)init
{
    self = [super init];
    if (self) {
        // remove all subviews from the UITableViewCell contentView
        [[self.contentView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
        
        self.cellTextView = [[CellTextView alloc] initWithFrame:CGRectMake(14, 8, 288, 30)];
        [self.contentView addSubview:self.cellTextView.getTextView];
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
    NSLog(@"EditableCell will show");
    [self.cellTextView becomeFirstResponder];
}

- (NSString *)getText
{
    return [self.cellTextView getTextView].text;
}

@end
