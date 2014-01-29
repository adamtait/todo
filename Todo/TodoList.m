//
//  TodoList.m
//  Todo
//
//  Created by Adam Tait on 1/26/14.
//  Copyright (c) 2014 Adam Tait. All rights reserved.
//

#import "TodoList.h"
#import <Parse/Parse.h>

static NSString * const parseClassName = @"TodoListItem";
static NSString * const parseItemKey = @"item";
static NSString * const parseIndexKey = @"index";

@interface TodoList ()

    @property (nonatomic, strong) NSMutableArray *todoItems;

    - (void)increaseAllItemIndexesFrom:(NSInteger)index;
    - (void)decrementAllItemIndexesFrom:(NSInteger)index;
    - (NSArray *)loadAllTodoListItems;

@end

@implementation TodoList 

#pragma initialization

- (id)init
{
    self = [super init];
    if (self) {
        NSArray *items = [self loadAllTodoListItems];
        NSLog(@"TodoList got / %@ /", items);
        
        _todoItems = [[NSMutableArray alloc] initWithArray:items];
    }
    return self;
}


#pragma public interface

- (NSString *)getStringForIndex:(NSInteger)index
{
    PFObject *todo = _todoItems[index];
    return [todo objectForKey:parseItemKey];
}


// TODO check where this is being used
- (PFObject *)getPFObjectForIndex:(NSInteger)index
{
    return _todoItems[index];
}

- (void)addString:(NSString *)string
{
    PFObject *todo = [PFObject objectWithClassName:parseClassName];
    [todo setObject:string forKey:parseItemKey];
    [todo setObject:@"0" forKey:parseIndexKey];
    [self increaseAllItemIndexesFrom:0];
    [todo saveInBackground];
    
    NSLog(@"addString no index Saving in background");
    
    [_todoItems insertObject:todo atIndex:0];
}

- (void)addString:(NSString *)string atIndex:(NSInteger)atIndex
{
    PFObject *todo = [PFObject objectWithClassName:parseClassName];
    [todo setObject:string forKey:parseItemKey];
    [todo setObject:[NSString stringWithFormat:@"%d", atIndex] forKey:parseIndexKey];
    [self increaseAllItemIndexesFrom:atIndex];
    [todo saveInBackground];
    
    NSLog(@"addString index Saving in background");
    
    [_todoItems insertObject:todo atIndex:atIndex];
    
}

- (void)updateString:(NSString *)string atIndex:(NSInteger)atIndex
{
    PFObject *todo = _todoItems[atIndex];
    [todo setObject:string forKey:parseItemKey];
    [todo saveInBackground];
    
    NSLog(@"updateString Saving in background");
    
    [_todoItems replaceObjectAtIndex:atIndex withObject:todo];
}

- (void)moveStringFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex
{
    PFObject *fromTodo = _todoItems[fromIndex];
    [fromTodo setObject:[NSString stringWithFormat:@"%d", toIndex] forKey:parseIndexKey];
    [fromTodo saveInBackground];
    
    PFObject *toTodo = _todoItems[toIndex];
    [toTodo setObject:[NSString stringWithFormat:@"%d", fromIndex] forKey:parseIndexKey];
    [toTodo saveInBackground];
    
    NSLog(@"moveStringFromIndex Saving in background");
    
    [_todoItems exchangeObjectAtIndex:toIndex withObjectAtIndex:fromIndex];
}

- (void)deleteFromIndex:(NSInteger)index
{
    PFObject *todo = _todoItems[index];
    [todo deleteEventually];
    [self decrementAllItemIndexesFrom:index];
    
    [_todoItems removeObjectAtIndex:index];
}

- (void)increaseAllItemIndexesFrom:(NSInteger)index
{
    for (int i = index + 1; i < [_todoItems count]; i++) {
        PFObject *todo = _todoItems[i];
        [todo setObject:[NSString stringWithFormat:@"%d", (i - 1)] forKey:parseIndexKey];
        [todo saveInBackground];
    }
}

- (void)decrementAllItemIndexesFrom:(NSInteger)index
{
    for (int i = index + 1; i < [_todoItems count]; i++) {
        PFObject *todo = _todoItems[i];
        [todo setObject:[NSString stringWithFormat:@"%d", (i + 1)] forKey:parseIndexKey];
        [todo saveInBackground];
    }
}

- (NSInteger)count
{
    return [_todoItems count];
}


#pragma parse loading

- (NSArray *)loadAllTodoListItems
{
//    [_todoItems addObject:[[TodoListItem alloc] initWithString:@"kiss Tam"]];
//    [_todoItems addObject:[[TodoListItem alloc] initWithString:@"tell Tam how much you love her"]];
//    [_todoItems addObject:[[TodoListItem alloc] initWithString:@"listen to the context of Tam's words. The context is an important clue to understanding her better."]];
//    [_todoItems addObject:[[TodoListItem alloc] initWithString:@"always make Tam your first priority"]];
//    [_todoItems addObject:[[TodoListItem alloc] initWithString:@"add constraints"]];
//    [_todoItems addObject:[[TodoListItem alloc] initWithString:@"save to parse"]];
//    [_todoItems addObject:[[TodoListItem alloc] initWithString:@"add an app icon"]];
//    [_todoItems addObject:[[TodoListItem alloc] initWithString:@"make text areas that are being edited update their heights"]];
//    [_todoItems addObject:[[TodoListItem alloc] initWithString:@"scroll currently editing cell to top"]];
    
    return [[PFQuery queryWithClassName:parseClassName] findObjects];
    
}

@end
