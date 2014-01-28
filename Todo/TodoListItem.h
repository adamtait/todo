//
//  TodoListItem.h
//  Todo
//
//  Created by Adam Tait on 1/28/14.
//  Copyright (c) 2014 Adam Tait. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TodoListItem : NSObject

    // public instance methods
    - (id)initWithString:(NSString *)string;
    - (NSString *)getString;
    - (void)setWithString:(NSString *)string;

@end
