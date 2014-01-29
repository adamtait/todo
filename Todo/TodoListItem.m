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






//- (id)initWithCoder:(NSCoder *)aDecoder
//{
//    NSString *objectId = [aDecoder decodeObjectForKey:@"objectId"];
//    NSString *className = [aDecoder decodeObjectForKey:[TodoListItem parseClassName]];
//    
//    self = (TodoListItem *)[PFObject objectWithoutDataWithClassName:className objectId:objectId];
//    if (self) {
//        self[@"createdAt"] = [NSDate dateWithTimeIntervalSinceReferenceDate:[aDecoder decodeDoubleForKey:@"createdAt"]];
//        self[@"updatedAt"] = [NSDate dateWithTimeIntervalSinceReferenceDate:[aDecoder decodeDoubleForKey:@"updatedAt"]];
//        
//        for (NSString *key in [aDecoder decodeObjectForKey:@"objectAllKeys"]) {
//            id object = [aDecoder decodeObjectForKey:key];
//            self[key] = object;
//        }
//    }
//    
//    return self;
//}
//
//- (id)initWithString:(NSString *)string
//{
//    self = [super init];
//    if (self) {
//        self.item = string;
//    }
//    return self;
//}
//
//- (NSString *)getString
//{
//    return [self objectForKey:@"item"];
//}
//
//- (void)setWithString:(NSString *)string
//{
//    self.item = string;
//    [self saveInBackground];
//}
//
//- (void)encodeWithCoder:(NSCoder *)aCoder
//{
//    [aCoder encodeObject:self.parseClassName forKey:[TodoListItem parseClassName]];
//    [aCoder encodeObject:self.objectId forKey:@"objectId"];
//    [aCoder encodeDouble:[self.createdAt timeIntervalSinceReferenceDate] forKey:@"createdAt"];
//    [aCoder encodeDouble:[self.updatedAt timeIntervalSinceReferenceDate] forKey:@"updatedAt"];
//    [aCoder encodeObject:self.allKeys forKey:@"objectAllKeys"];
//    
//    for (NSString *key in self.allKeys) {
//        if (![key isEqualToString:@"ACL"]) {
//            [aCoder encodeObject:self[key] forKey:key];
//        }
//    }
//}

@end
