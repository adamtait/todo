//
//  TodoListCell.h
//  Todo
//
//  Created by Adam Tait on 1/27/14.
//  Copyright (c) 2014 Adam Tait. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TodoListCell : UITableViewCell

    // public instance methods
    - (id)init;
    - (NSString *)getText;
    - (void)updateContentWithString:(NSString *)content;

    - (BOOL)becomeFirstResponder;

@end
