//
//  ZZTableSectionItem.m
//  TableVIewAdapter
//
//  Created by ZZ on 2019/11/25.
//  Copyright © 2019 zz. All rights reserved.
//

#import "ZZTableSectionItem.h"
#import "ZZTableAdapter.h"

@interface ZZTableSectionItem ()

@property (nonatomic, strong) NSMutableArray<ZZTableRowItem *> *mutableRowItems;

@end

@implementation ZZTableSectionItem

- (void)_addRow:(ZZTableRowItem *)row {
    if (!row) return;
    row.sectionItem = self;

}
- (void)_removeRow:(ZZTableRowItem *)row {
    if (row) return;
    row.sectionItem = nil;
}

- (BOOL)containsRow:(ZZTableRowItem *)row {
    return [self.mutableRowItems containsObject:row];
}
/// MARK: add
- (void)addRow:(ZZTableRowItem *)row {
    [self _addRow:row];
    [self.mutableRowItems addObject:row];
    row.sectionItem = self;
}
- (void)addRowsFromArray:(NSArray<ZZTableRowItem *> *)rowsArray {
    for (ZZTableRowItem *row in rowsArray) {
        [self _addRow:row];
    }
    [self.mutableRowItems addObjectsFromArray:rowsArray];
}
/// MARK: insert
- (void)insertRow:(ZZTableRowItem *)row atIndex:(NSUInteger)idx {
    [self _addRow:row];
    [self.mutableRowItems insertObject:row atIndex:idx];
}
- (void)insertRows:(NSArray<ZZTableRowItem *> *)rowsArray atIndex:(NSUInteger)idx {
    for (ZZTableRowItem *row in rowsArray) {
        [self _addRow:row];
    }
    [self.mutableRowItems insertObjects:rowsArray atIndexes:[NSIndexSet indexSetWithIndex:idx]];
}
/// MARK: remove
- (void)removeRow:(ZZTableRowItem *)row {
    [self _removeRow:row];
    [self.mutableRowItems removeObject:row];
}
- (void)removeRowAtIndex:(NSUInteger)idx {
    ZZTableRowItem *row = [self.mutableRowItems objectAtIndex:idx];
    [self _removeRow:row];
    [self.mutableRowItems removeObjectAtIndex:idx];
}
- (void)removeRowsInArray:(NSArray<ZZTableRowItem *> *)rowsArray {
    for (ZZTableRowItem *row in rowsArray) {
        [self _removeRow:row];
    }
    [self.mutableRowItems removeObjectsInArray:rowsArray];
}

- (NSMutableArray<ZZTableRowItem *> *)mutableRowItems {
    if (!_mutableRowItems) {
        _mutableRowItems = [NSMutableArray array];
    }
    return _mutableRowItems;
}

- (NSArray<ZZTableRowItem *> *)rowItems {
    return _mutableRowItems;
}

- (void)didSetBlock:(BOOL)blockIfNonnull methodType:(ZZTableViewDelegateMethodType)methodOptions {
    [super didSetBlock:blockIfNonnull methodType:methodOptions];
    [self.adapter updateMethodOptionsWithMethodType:methodOptions addOrRemoveBlock:blockIfNonnull];
}

@end
