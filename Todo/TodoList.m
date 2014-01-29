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

    - (void)increaseAllItemIndexesFrom:(NSInteger)fromIndex to:(NSInteger)toIndex;
    - (void)decrementAllItemIndexesFrom:(NSInteger)fromIndex to:(NSInteger)toIndex;
    - (NSArray *)loadAllTodoListItems;

@end

@implementation TodoList 

#pragma initialization

- (id)init
{
    self = [super init];
    if (self) {
        _todoItems = [[NSMutableArray alloc] initWithArray:[self loadAllTodoListItems]];
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
    [self addString:string atIndex:0];
}

- (void)addString:(NSString *)string atIndex:(NSInteger)atIndex
{
    PFObject *todo = [PFObject objectWithClassName:parseClassName];
    [todo setObject:string forKey:parseItemKey];
    [todo setObject:[NSString stringWithFormat:@"%d", atIndex] forKey:parseIndexKey];
    [self increaseAllItemIndexesFrom:atIndex to:[_todoItems count]];
    [todo saveInBackground];
    
    [_todoItems insertObject:todo atIndex:atIndex];
    
}

- (void)updateString:(NSString *)string atIndex:(NSInteger)atIndex
{
    PFObject *todo = _todoItems[atIndex];
    [todo setObject:string forKey:parseItemKey];
    [todo saveInBackground];

    [_todoItems replaceObjectAtIndex:atIndex withObject:todo];
}

- (void)moveStringFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex
{
    PFObject *fromTodo = _todoItems[fromIndex];
    [fromTodo setObject:[NSString stringWithFormat:@"%d", toIndex] forKey:parseIndexKey];
    [fromTodo saveInBackground];
    
    if (fromIndex < toIndex) {
        [self decrementAllItemIndexesFrom:(fromIndex + 1) to:(toIndex + 1)];
    } else if (fromIndex > toIndex){
        [self increaseAllItemIndexesFrom:toIndex to:fromIndex];
    }
    [_todoItems removeObjectAtIndex:fromIndex];
    [_todoItems insertObject:fromTodo atIndex:toIndex];
}

- (void)deleteFromIndex:(NSInteger)index
{
    PFObject *todo = _todoItems[index];
    [todo deleteEventually];
    [self decrementAllItemIndexesFrom:(index + 1) to:[_todoItems count]];
    
    [_todoItems removeObjectAtIndex:index];
}


#pragma increment or decrement many indexes

- (void)increaseAllItemIndexesFrom:(NSInteger)fromIndex to:(NSInteger)toIndex
{
    for (int i = fromIndex; i < toIndex; i++) {
        PFObject *todo = _todoItems[i];
        [todo setObject:[NSString stringWithFormat:@"%d", (i + 1)] forKey:parseIndexKey];
        [todo saveInBackground];
    }
}

- (void)decrementAllItemIndexesFrom:(NSInteger)fromIndex to:(NSInteger)toIndex
{
    for (int i = fromIndex; i < toIndex; i++) {
        PFObject *todo = _todoItems[i];
        [todo setObject:[NSString stringWithFormat:@"%d", (i - 1)] forKey:parseIndexKey];
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
    NSArray *pfobjects = [[PFQuery queryWithClassName:parseClassName] findObjects];
    return [pfobjects sortedArrayUsingComparator:^NSComparisonResult(id a, id b) {
        NSString *aString = [(PFObject *)a objectForKey:parseIndexKey];
        NSString *bString = [(PFObject *)b objectForKey:parseIndexKey];
        return aString.intValue > bString.intValue;
    }];
}

@end
