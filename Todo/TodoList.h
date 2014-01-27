//
//  TodoList.h
//  Todo
//
//  Created by Adam Tait on 1/26/14.
//  Copyright (c) 2014 Adam Tait. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TodoList : NSObject

    - (id)init;

    - (NSString *)getStringForIndex:(NSInteger)index;
    - (void)addString:(NSString *)string;
    - (void)updateString:(NSString *)string atIndex:(NSInteger)atIndex;
    - (void)moveStringFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex;
    - (void)deleteFromIndex:(NSInteger)index;
    - (NSInteger)count;

@end
