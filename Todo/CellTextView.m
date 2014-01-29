//
//  CellTextView.m
//  Todo
//
//  Created by Adam Tait on 1/26/14.
//  Copyright (c) 2014 Adam Tait. All rights reserved.
//

#import "CellTextView.h"

@interface CellTextView  ()

    @property (nonatomic, strong) UITextView *textView;

    @property (nonatomic, strong) NSTextContainer *container;
    @property (nonatomic, strong) NSTextStorage *storage;
    @property (nonatomic, strong) NSLayoutManager *layout;

    - (void)textViewDidBeginEditing:(UITextView *)textView;
    - (void)textViewDidEndEditing:(UITextView *)textView;
    - (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text;
    - (void)textViewDidChange:(UITextView *)textView;

@end

@implementation CellTextView

#pragma public static methods

+ (UIFont *)defaultFont
{
    return [UIFont systemFontOfSize:18.0];
}

+ (NSLineBreakMode)defaultLineBreakMode
{
    return NSLineBreakByWordWrapping;
}

#pragma public instance methods

- (id)initWithFrame:(CGRect)frame
{
    self.container = [[NSTextContainer alloc] initWithSize:CGSizeMake(frame.size.width, frame.size.height)];
    self.container.lineBreakMode = [CellTextView defaultLineBreakMode];
    self = [super init];

    if (self) {
        self.layout = [[NSLayoutManager alloc] init];    // might want a custom subclass
        [self.layout addTextContainer:self.container];
        self.storage = [[NSTextStorage alloc] init];
        [self.storage addLayoutManager:self.layout];
        
        self.textView = [[UITextView alloc] initWithFrame:frame textContainer:self.container];
        
        self.textView.font = [CellTextView defaultFont];
        self.textView.textContainerInset = UIEdgeInsetsZero;
        
        self.textView.delegate = self;
        self.textView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        self.textView.translatesAutoresizingMaskIntoConstraints = YES;
        
        
        self.textView.autocapitalizationType = UITextAutocapitalizationTypeNone;
        self.textView.returnKeyType = UIReturnKeyDone;
        self.textView.enablesReturnKeyAutomatically = YES;
        
        
    }
    return self;
}

- (UITextView *)getTextView
{
    return self.textView;
}

- (void)updateContentWithString:(NSString *)content
{
    self.textView.attributedText = [[NSAttributedString alloc] initWithString:content ];
    
    NSRange range = NSMakeRange(0, [content length]);
    [_storage addAttribute:NSFontAttributeName value:[CellTextView defaultFont] range:range];
}



#pragma UITextViewDelegate

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"textViewDidBeginEditing" object:self];
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    [self.textView resignFirstResponder];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"textViewDidEndEditing" object:self];
}

- (BOOL)textView:(UITextView *)textView
shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"textViewDidEndEditing" object:self];
        return NO;
    }
    
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"textViewDidChange" object:self];
}


#pragma UIResponder

- (BOOL)becomeFirstResponder
{
    return [self.textView becomeFirstResponder];
}

- (BOOL)resignFirstResponder
{
    return [self.textView resignFirstResponder];
}

@end
