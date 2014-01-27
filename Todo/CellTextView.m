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
    self = [super init];

    if (self) {
        self.layout = [[NSLayoutManager alloc] init];    // might want a custom subclass
        [self.layout addTextContainer:self.container];
        self.storage = [[NSTextStorage alloc] init];
        [self.storage addLayoutManager:self.layout];
        
        self.textView = [[UITextView alloc] initWithFrame:frame textContainer:self.container];
        self.textView.delegate = self;
        self.textView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
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
    self.textView.text = content;
    
    NSRange range = NSMakeRange(0, [content length]);
    [_storage addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18.0] range:range];
}



#pragma UITextViewDelegate

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    NSLog(@"CellTextView did begin editing");
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    NSLog(@"CellTextView did end editing");
    [self.textView resignFirstResponder];

    [[NSNotificationCenter defaultCenter] postNotificationName:@"textViewDidEndEditing" object:self];
}

- (BOOL)textView:(UITextView *)textView
shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if([text isEqualToString:@"\n"]) {
        NSLog(@"CellTextView shouldChangeTextInRange is done editing");
        [textView resignFirstResponder];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"textViewDidEndEditing" object:self];
        return NO;
    }
    
    return YES;
}


#pragma UIResponder

- (BOOL)becomeFirstResponder
{
    NSLog(@"CellTextView becameFirstResponder");
    return [self.textView becomeFirstResponder];
}

@end
