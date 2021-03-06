//
//  ZZNormalRowItem.m
//  TableVIewAdapter
//
//  Created by ZZ on 2020/3/14.
//  Copyright © 2020 zz. All rights reserved.
//

#import "ZZNormalRowItem.h"
#import "ZZBaseRowCell.h"

@implementation ZZNormalRowItem

- (Class)cellClass {
    return ZZBaseRowCell.self;
    //return NSClassFromString(@"ZZBaseRowCell");
}

- (void)setCellHeight:(CGFloat)cellHeight {
    if (_cellHeight == cellHeight) {
        return;
    }
    _cellHeight = cellHeight;
    self.heightForRowAtIndexPath = ^CGFloat(UITableView * _Nonnull tableView, NSIndexPath * _Nonnull indexPath) {
        return cellHeight;
    };
    self.estimatedHeightForRowAtIndexPath = ^CGFloat(UITableView * _Nonnull tableView, NSIndexPath * _Nonnull indexPath) {
        return cellHeight;
    };
}

@end
