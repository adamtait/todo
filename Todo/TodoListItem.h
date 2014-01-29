//
//  TodoListItem.h
//  Todo
//
//  Created by Adam Tait on 1/28/14.
//  Copyright (c) 2014 Adam Tait. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@interface TodoListItem : PFObject <PFSubclassing>

    // public instance methods
    + (NSString *)parseClassName;

    @property (retain) NSString *item;
    @property (retain) NSString *index;
@end
