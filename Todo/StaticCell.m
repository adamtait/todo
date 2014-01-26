//
//  StaticCell.m
//  Todo
//
//  Created by Adam Tait on 1/24/14.
//  Copyright (c) 2014 Adam Tait. All rights reserved.
//

#import "StaticCell.h"

@interface StaticCell ()

    + (UIFont *)defaultFont;

    @property BOOL completed;
    @property (nonatomic, strong) UITextView *textView;
    @property (nonatomic, strong) NSTextStorage *textStorage;

    - (void)textViewDidBeginEditing:(UITextView *)textView;
    - (void)textViewDidEndEditing:(UITextView *)textView;
    - (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text;

@end

@implementation StaticCell

+ (UIFont *)defaultFont
{
    return [UIFont systemFontOfSize:18.0];
}

+ (NSLineBreakMode)defaultLineBreakMode
{
    return NSLineBreakByWordWrapping;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [[self.contentView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
        
        NSTextContainer *container = [[NSTextContainer alloc] initWithSize:CGSizeMake(2, 300)];
        self.textStorage = [[NSTextStorage alloc] init];
        NSLayoutManager *layoutManager = [[NSLayoutManager alloc] init];    // might want a custom subclass
        [self.textStorage addLayoutManager:layoutManager];
        [layoutManager addTextContainer:container];
        
//        container.lineBreakMode = NSLineBreakByWordWrapping;
//        container.heightTracksTextView = YES;
        
        self.textView = [[UITextView alloc] initWithFrame:CGRectMake(14, 8, 300, 30) textContainer:container];

//        self.textView.keyboardAppearance = YES;
        self.textView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        self.textView.autocapitalizationType = UITextAutocapitalizationTypeNone;
//        self.textView.keyboardType = UIKeyboardTypeWebSearch;
        self.textView.returnKeyType = UIReturnKeyDone;
        self.textView.enablesReturnKeyAutomatically = YES;
        self.textView.delegate = self;
        [self.contentView addSubview:self.textView];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    NSLog(@"StaticCell got setEditing / %hhd /", editing);
    [super setEditing:editing animated:animated];
}

#pragma handle view details

- (void)updateContentWithString:(NSString *)content
{
    _content = content;
    self.textView.text = _content;
    [_textStorage addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18.0]
                         range:NSMakeRange(0, [_content length])];
}

- (CGFloat)getHeight
{
    return 30.0; //self.textView.textContainer.size.height;
}


#pragma event handler

- (BOOL)resignFirstResponder
{
    [self.textView resignFirstResponder];
    return [super resignFirstResponder];
}



#pragma UITextViewDelegate

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    NSLog(@"UITextView did begin editing");
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    NSLog(@"UITextVIew did end editing");
    [self resignFirstResponder];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    
    return YES;
}


@end
