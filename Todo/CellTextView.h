//
//  CellTextView.h
//  Todo
//
//  Created by Adam Tait on 1/26/14.
//  Copyright (c) 2014 Adam Tait. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CellTextView : NSObject <UITextViewDelegate>

    + (UIFont *)defaultFont;
    + (NSLineBreakMode)defaultLineBreakMode;

    - (id)initWithFrame:(CGRect)frame;

    - (UITextView *)getTextView;
    - (void)updateContentWithString:(NSString *)content;

    - (BOOL)becomeFirstResponder;
    - (BOOL)resignFirstResponder;

@end
