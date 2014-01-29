//
//  TodoCell.h
//  Todo
//
//  Created by Adam Tait on 1/27/14.
//  Copyright (c) 2014 Adam Tait. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface TodoCell : UITableViewCell

    // public static methods
    + (CGRect)defaultFrame;

    // public properties
    @property (nonatomic, strong) PFObject *todoListItem;

    // public instance methods
    - (NSString *)getText;
    - (void)updateContentWithString:(NSString *)content;

    // UIResponder methods
    - (BOOL)becomeFirstResponder;
    - (BOOL)resignFirstResponder;
@end
