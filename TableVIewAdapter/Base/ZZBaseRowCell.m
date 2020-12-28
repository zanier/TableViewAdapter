//
//  ZZBaseRowCell.m
//  TableVIewAdapter
//
//  Created by ZZ on 2020/3/14.
//  Copyright © 2020 zz. All rights reserved.
//

#import "ZZBaseRowCell.h"
#import "ZZNormalRowItem.h"

@implementation ZZBaseRowCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setRowItem:(ZZNormalRowItem *)rowItem {
    if (_rowItem == rowItem) {
        return;
    }
    _rowItem = rowItem;
    [self reloadWithRowItem:rowItem];
}

// Override
- (void)reloadWithRowItem:(ZZNormalRowItem *)rowItem {
    
}

@end
