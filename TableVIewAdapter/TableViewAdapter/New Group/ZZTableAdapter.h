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

@interface ZZTableAdapter : ZZTableViewDelegator <UITableViewDataSource, UITableViewDelegate>

//@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) ZZTableViewDelegator *delegator;

@property (readonly) NSArray<ZZTableSectionItem *> *sectionItems;

//- (void)updateMethodOptionsWithMethodType:(ZZTableViewDelegateMethodType)methodType addOrRemoveBlock:(BOOL)flag;
- (void)updateMethodOption1:(NSUInteger)option1 methodOption2:(NSUInteger)option2 addOrRemoveBlock:(BOOL)flag;

///MARK: contain
- (BOOL)containsSection:(ZZTableSectionItem *)section;
///MARK: add
- (void)addSection:(ZZTableSectionItem *)section;
- (void)addSectionsFromArray:(NSArray<ZZTableSectionItem *> *)sectionsArray;
///MARK: insert
- (void)insertSection:(ZZTableSectionItem *)section atIndex:(NSUInteger)idx;
- (void)insertSections:(NSArray<ZZTableSectionItem *> *)sectionsArray atIndex:(NSUInteger)idx;
///MARK: remove
- (void)removeSection:(ZZTableSectionItem *)section;
- (void)removeSectionAtIndex:(NSUInteger)idx;
- (void)removeSectionsInArray:(NSArray<ZZTableSectionItem *> *)sectionsArray;

@property (nonatomic, nullable, copy) NSIndexPath *(^targetIndexPathForMoveFromRowAtIndexPathToProposedIndexPath)(UITableView *tableView, NSIndexPath *sourceIndexPath, NSIndexPath *proposedDestinationIndexPath);

@end

NS_ASSUME_NONNULL_END
