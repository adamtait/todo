//
//  StaticCell.m
//  Todo
//
//  Created by Adam Tait on 1/24/14.
//  Copyright (c) 2014 Adam Tait. All rights reserved.
//

#import "StaticCell.h"

@interface StaticCell ()

@property BOOL completed;

@end

@implementation StaticCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    return [super initWithStyle:style reuseIdentifier:reuseIdentifier];
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
