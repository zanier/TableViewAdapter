//
//  ZZTableViewCellProtocol.h
//  TableVIewAdapter
//
//  Created by handsome on 2020/12/25.
//  Copyright © 2020 zz. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ZZTableRowItem;

NS_ASSUME_NONNULL_BEGIN

@protocol ZZTableViewCellProtocol <NSObject>

@required
- (void)setRowItem:(ZZTableRowItem * _Nonnull)rowItem;
- (void)reloadWithRowItem:(ZZTableRowItem *)rowItem;

@end

NS_ASSUME_NONNULL_END
