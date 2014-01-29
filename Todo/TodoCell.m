//
//  TodoCell.m
//  Todo
//
//  Created by Adam Tait on 1/27/14.
//  Copyright (c) 2014 Adam Tait. All rights reserved.
//

#import "TodoCell.h"
#import "CellTextView.h"

@interface TodoCell ()

    // private properties
    @property (nonatomic, strong) CellTextView *cellTextView;

    // private methods
    - (void)setup;

    - (void)gotTextViewDidBeginEditingEvent:(id)sender;
    - (void)gotTextViewDidChangeEvent:(id)sender;

@end


@implementation TodoCell

#pragma public static methods

+ (CGRect)defaultFrame
{
    return CGRectMake(10, 10, 300, 44);
}


#pragma public initialization methods

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setup];
    }
    return self;
}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setup];
    }
    return self;
}


#pragma private initialization methods

- (void)setup
{
    _todoListItem = nil;
    
    self.indentationLevel = 0;
    self.indentationWidth = 0.0;
    self.shouldIndentWhileEditing = NO;
    self.separatorInset = UIEdgeInsetsZero;
    
    // remove all subviews from the UITableViewCell contentView
    [[self.contentView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    self.cellTextView = [[CellTextView alloc] initWithFrame:[TodoCell defaultFrame]];
    [self.contentView addSubview:self.cellTextView.getTextView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(gotTextViewDidBeginEditingEvent:) name:@"textViewDidBeginEditing" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(gotTextViewDidChangeEvent:) name:@"textViewDidChange" object:nil];
}


#pragma accessors for CellTextView property

- (NSString *)getText
{
    return [self.cellTextView getTextView].text;
}

- (void)updateContentWithString:(NSString *)content
{
    [self.cellTextView updateContentWithString:content];
}


#pragma UIResponder

- (BOOL)becomeFirstResponder
{
    NSLog(@"TodoCell is going to becomeFirstResponder");
    [self.cellTextView becomeFirstResponder];
    return [super becomeFirstResponder];
}

- (BOOL)resignFirstResponder
{
    NSLog(@"TodoCell is going to resignFirstResponder");
    [self.cellTextView resignFirstResponder];
    return [super resignFirstResponder];
}


#pragma event handlers

- (void)gotTextViewDidBeginEditingEvent:(id)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"todoCellDidBeginEditing" object:self];
}

- (void)gotTextViewDidChangeEvent:(id)sender
{
    [_todoListItem setWithString:[self getText]];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"todoCellDidChange" object:self];
}

@end
