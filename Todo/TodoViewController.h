//
//  TodoViewController.h
//  Todo
//
//  Created by Adam Tait on 1/24/14.
//  Copyright (c) 2014 Adam Tait. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TodoViewController : UITableViewController <UITableViewDelegate>

    // public instance methods
    - (void)setEditing:(BOOL)editing animated:(BOOL)animated;

@end
