//
//  TodoListItem.m
//  Todo
//
//  Created by Adam Tait on 1/28/14.
//  Copyright (c) 2014 Adam Tait. All rights reserved.
//

#import "TodoListItem.h"
#import <Parse/PFObject+Subclass.h>

@implementation TodoListItem

    @dynamic item;
    @dynamic index;

#pragma public instance methods

+ (NSString *)parseClassName
{
    return NSStringFromClass([TodoListItem class]);
}

@end
