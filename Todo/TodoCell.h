//
//  TodoCell.h
//  Todo
//
//  Created by Adam Tait on 1/27/14.
//  Copyright (c) 2014 Adam Tait. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TodoCell : UITableViewCell

    // public properties
    @property (nonatomic, strong) NSIndexPath *indexPath;

    // public instance methods
    - (NSString *)getText;
    - (void)updateContentWithString:(NSString *)content;

    - (BOOL)becomeFirstResponder;
    - (BOOL)resignFirstResponder;
@end
