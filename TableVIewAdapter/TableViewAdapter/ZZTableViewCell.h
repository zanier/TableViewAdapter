//
//  ZZTableViewCell.h
//  TableVIewAdapter
//
//  Created by ZZ on 2020/3/13.
//  Copyright © 2020 zz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZZTableRowItem.h"

NS_ASSUME_NONNULL_BEGIN

@protocol ZZTableViewCellProtocol <NSObject>

- (void)setRowItem:(ZZTableRowItem * _Nonnull)rowItem;

@end

@interface ZZTableViewCell : UITableViewCell <ZZTableViewCellProtocol>

- (void)setRowItem:(ZZTableRowItem * _Nonnull)rowItem;

// Override
- (void)reloadWithRowItem:(ZZTableRowItem *)rowItem;

@end

NS_ASSUME_NONNULL_END
