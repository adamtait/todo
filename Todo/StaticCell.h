//
//  StaticCell.h
//  Todo
//
//  Created by Adam Tait on 1/24/14.
//  Copyright (c) 2014 Adam Tait. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CellTextView.h"

@interface StaticCell : UITableViewCell 

    @property (nonatomic, strong) CellTextView *cellTextView;

    - (void)setEditing:(BOOL)editing animated:(BOOL)animated;
    - (BOOL)resignFirstResponder;

@end
