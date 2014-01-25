//
//  EditableCell.m
//  Todo
//
//  Created by Adam Tait on 1/24/14.
//  Copyright (c) 2014 Adam Tait. All rights reserved.
//

#import "EditableCell.h"

@interface EditableCell ()

@end

@implementation EditableCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    NSLog(@"initWithStyle was called / %d /", style);
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma handle view details

- (void)updateContentWithString:(NSString *)content
{
    _content = content;
    self.textLabel.text = _content;
}


@end
