//
//  ZZTableSectionItem.h
//  TableVIewAdapter
//
//  Created by ZZ on 2019/11/25.
//  Copyright © 2019 zz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZZTableViewDelegator.h"
#import "ZZTableRowItem.h"

@class ZZTableAdapter;

NS_ASSUME_NONNULL_BEGIN

@interface ZZTableSectionItem : ZZTableViewSectionDelegator

@property (nonatomic, nullable, weak) ZZTableAdapter *adapter;

@property (readonly) NSArray<ZZTableRowItem *> *rowItems;

/// MARK: contain
- (BOOL)containsRow:(ZZTableRowItem *)row;
/// MARK: add
- (void)addRow:(ZZTableRowItem *)row;
- (void)addRowsFromArray:(NSArray<ZZTableRowItem *> *)rowsArray;
/// MARK: insert
- (void)insertRow:(ZZTableRowItem *)row atIndex:(NSUInteger)idx;
- (void)insertRows:(NSArray<ZZTableRowItem *> *)rowsArray atIndex:(NSUInteger)idx;
/// MARK: remove
- (void)removeRow:(ZZTableRowItem *)row;
- (void)removeRowAtIndex:(NSUInteger)idx;
- (void)removeRowsInArray:(NSArray<ZZTableRowItem *> *)rowsArray;

@end

NS_ASSUME_NONNULL_END
