//
//  TodoList.m
//  Todo
//
//  Created by Adam Tait on 1/26/14.
//  Copyright (c) 2014 Adam Tait. All rights reserved.
//

#import "TodoList.h"

@interface TodoList ()

    @property (nonatomic, strong) NSMutableArray *todoItems;

@end

@implementation TodoList 

#pragma initialization

- (id)init
{
    self = [super init];
    if (self) {
        _todoItems = [[NSMutableArray alloc] init];
        [_todoItems addObject:@"kiss Tam"];
        [_todoItems addObject:@"tell Tam how much you love her"];
        [_todoItems addObject:@"always listen carefully to Tam"];
        [_todoItems addObject:@"understand the emotional context of what Tam says"];
        [_todoItems addObject:@"add constraints"];
        [_todoItems addObject:@"save to parse"];
        [_todoItems addObject:@"add an app icon"];
        [_todoItems addObject:@"make text areas that are being edited update their heights"];
    }
    return self;
}


#pragma public interface

- (NSString *)getStringForIndex:(NSInteger)index
{
    return _todoItems[index];
}

- (void)addString:(NSString *)string
{
    [_todoItems insertObject:string atIndex:0];
}

- (void)updateString:(NSString *)string atIndex:(NSInteger)atIndex
{
    [_todoItems replaceObjectAtIndex:atIndex withObject:string];
}

- (void)moveStringFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex
{
    NSLog(@"moving item from / %d / to / %d /", fromIndex, toIndex);
    [_todoItems exchangeObjectAtIndex:toIndex withObjectAtIndex:fromIndex];
}

- (void)deleteFromIndex:(NSInteger)index
{
    [_todoItems removeObjectAtIndex:index];
}

- (NSInteger)count
{
    return [_todoItems count];
}

@end
