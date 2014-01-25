//
//  EditableCell.h
//  Todo
//
//  Created by Adam Tait on 1/24/14.
//  Copyright (c) 2014 Adam Tait. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditableCell : UITableViewCell

- (id)init;
- (void)setEditing:(BOOL)editing animated:(BOOL)animated;
- (void)cellWillShow;

@end
