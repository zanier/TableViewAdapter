//
//  ZZTableViewCell.m
//  TableVIewAdapter
//
//  Created by ZZ on 2020/3/13.
//  Copyright © 2020 zz. All rights reserved.
//

#import "ZZTableViewCell.h"

@interface ZZTableViewCell ()

@property (nonatomic, strong) ZZTableRowItem *rowItem;

@end

@implementation ZZTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setRowItem:(ZZTableRowItem *)rowItem {
    if (_rowItem == rowItem) {
        return;
    }
    _rowItem = rowItem;
    [self reloadWithRowItem:rowItem];
}

- (void)reloadWithRowItem:(ZZTableRowItem *)rowItem {
    
}

@end
