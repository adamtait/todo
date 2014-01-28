//
//  TodoListItem.m
//  Todo
//
//  Created by Adam Tait on 1/28/14.
//  Copyright (c) 2014 Adam Tait. All rights reserved.
//

#import "TodoListItem.h"

@interface TodoListItem ()

    // private properties
    @property (nonatomic, strong) NSString *item;

@end

@implementation TodoListItem

#pragma public instance methods

- (id)initWithString:(NSString *)string
{
    self = [super init];
    if (self) {
        self.item = string;
    }
    return self;
}

- (NSString *)getString
{
    return _item;
}

- (void)setWithString:(NSString *)string
{
    _item = string;
}

@end
