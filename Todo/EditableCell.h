//
//  EditableCell.h
//  Todo
//
//  Created by Adam Tait on 1/24/14.
//  Copyright (c) 2014 Adam Tait. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditableCell : UITableViewCell

@property (nonatomic, strong) NSString *content;

- (void)updateContentWithString:(NSString *)content;

@end
