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
        [_todoItems addObject:[[TodoListItem alloc] initWithString:@"kiss Tam"]];
        [_todoItems addObject:[[TodoListItem alloc] initWithString:@"tell Tam how much you love her"]];
        [_todoItems addObject:[[TodoListItem alloc] initWithString:@"listen to the context of Tam's words. The context is an important clue to understanding her better."]];
        [_todoItems addObject:[[TodoListItem alloc] initWithString:@"always make Tam your first priority"]];
        [_todoItems addObject:[[TodoListItem alloc] initWithString:@"add constraints"]];
        [_todoItems addObject:[[TodoListItem alloc] initWithString:@"save to parse"]];
        [_todoItems addObject:[[TodoListItem alloc] initWithString:@"add an app icon"]];
        [_todoItems addObject:[[TodoListItem alloc] initWithString:@"make text areas that are being edited update their heights"]];
    }
    return self;
}


#pragma public interface

- (NSString *)getStringForIndex:(NSInteger)index
{
    return [_todoItems[index] getString];
}

- (TodoListItem *)getTodoListItemForIndex:(NSInteger)index
{
    return _todoItems[index];
}

- (void)addString:(NSString *)string
{
    [_todoItems insertObject:[[TodoListItem alloc] initWithString:string] atIndex:0];
}

- (void)addString:(NSString *)string atIndex:(NSInteger)atIndex
{
    [_todoItems insertObject:[[TodoListItem alloc] initWithString:string] atIndex:atIndex];
}

- (void)updateString:(NSString *)string atIndex:(NSInteger)atIndex
{
    [_todoItems replaceObjectAtIndex:atIndex withObject:[[TodoListItem alloc] initWithString:string]];
}

- (void)moveStringFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex
{
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
