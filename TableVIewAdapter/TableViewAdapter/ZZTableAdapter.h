//
//  ZZTableAdapter.h
//  TableVIewAdapter
//
//  Created by ZZ on 2019/11/25.
//  nullable, copyright © 2019 zz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZZTableViewDelegator.h"
#import "ZZTableSectionItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZZTableAdapter : ZZTableViewMutableItem <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, nullable, weak, readonly) UITableView *tableView;
@property (nonatomic, strong) ZZTableViewDelegator *delegator;

@property (readonly) NSArray<ZZTableSectionItem *> *sectionItems;

- (void)updateMethodOption:(NSUInteger)option addOrRemoveBlock:(BOOL)flag;

/// MARK: contain
- (BOOL)containsSection:(ZZTableSectionItem *)section;
/// MARK: add
- (void)addSection:(ZZTableSectionItem *)section;
- (void)addSectionsFromArray:(NSArray<ZZTableSectionItem *> *)sectionsArray;
/// MARK: insert
- (void)insertSection:(ZZTableSectionItem *)section atIndex:(NSUInteger)idx;
- (void)insertSections:(NSArray<ZZTableSectionItem *> *)sectionsArray atIndex:(NSUInteger)idx;
/// MARK: remove
- (void)removeSection:(ZZTableSectionItem *)section;
- (void)removeSectionAtIndex:(NSUInteger)idx;
- (void)removeSectionsInArray:(NSArray<ZZTableSectionItem *> *)sectionsArray;

@property (nonatomic, nullable, copy) NSIndexPath *(^targetIndexPathForMoveFromRowAtIndexPathToProposedIndexPath)(UITableView *tableView, NSIndexPath *sourceIndexPath, NSIndexPath *proposedDestinationIndexPath);

/// MARK:


@end

NS_ASSUME_NONNULL_END
