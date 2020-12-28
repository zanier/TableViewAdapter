//
//  ZZTableAdapter.m
//  TableVIewAdapter
//
//  Created by ZZ on 2019/11/25.
//  Copyright © 2019 zz. All rights reserved.
//

#import "ZZTableAdapter.h"
#import "ZZTableViewUtil.h"
#import "ZZTableViewCell.h"
#import <objc/runtime.h>

#define ZZTableGetSection \
ZZTableSectionItem *sectionItem = self.mutableSectionItems[section];\

#define ZZTableGetRow \
ZZTableSectionItem *sectionItem = self.mutableSectionItems[indexPath.section];\
ZZTableRowItem *rowItem = sectionItem.rowItems[indexPath.row];

@interface ZZTableAdapter () {
    BOOL _needUpdateMethodOptions;
    long long _finalMethodOptions;
}

@property (nonatomic, nullable, weak) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray<ZZTableSectionItem *> *mutableSectionItems;

@end

@implementation ZZTableAdapter

- (instancetype)init {
    if (self = [super init]) {
        [self setNeedUpdateMethodOptions];
    }
    return self;
}

/// 重写是否响应方法
///
/// 由于声明了绝大多数的数据源和代理方法，在表视图刷新时会通过`respondsToSelector`决定是否调用对象的数据源和代理方法。
/// 为了保证未使用的数据源和代理方法具有默认的实现，以及刷新时的计算效率，在设置了row与section的数据源和代理方法后，会通
/// 过位计算的方式保存为long long型的MethodOptions标志，并通过遍历归并为最终的MethodOptions。由此数据决定需要实现的
/// 数据源和代理方法。
///
/// @param aSelector 方法名称
- (BOOL)respondsToSelector:(SEL)aSelector {
    ZZTableViewDelegateMethodType methodType = ZZMethodTypeWithSEL(aSelector);
    if (methodType != ZZTableViewDelegateMethodTypeNone) {
        [self updateMethodOptionsIfNeeded];
        if (ZZMethodTypeCanRespond(methodType, _finalMethodOptions)) {
            //NSLog(@"能响应 %@", NSStringFromSelector(aSelector));
            return YES;
        } else {
            //NSLog(@"不能响应 %@", NSStringFromSelector(aSelector));
            return NO;
        }
    }
    return [super respondsToSelector:aSelector];
}

- (void)setNeedUpdateMethodOptions {
    _needUpdateMethodOptions = YES;
}

- (void)updateMethodOptionsIfNeeded {
    if (_needUpdateMethodOptions) {
        [self updateMethodOptions];
        _needUpdateMethodOptions = NO;
    }
}

- (void)updateMethodOptions {
    _finalMethodOptions = self.methodOptions;
    for (ZZTableSectionItem *section in _mutableSectionItems) {
        //NSLog(@"%ld | %ld section", (long)_finalMethodOptions, (long)section.methodOptions);
        _finalMethodOptions |= section.methodOptions;
        for (ZZTableRowItem *row in section.rowItems) {
            //NSLog(@"%ld | %ld row", (long)_finalMethodOptions, (long)row.methodOptions);
            _finalMethodOptions |= row.methodOptions;
        }
    }
}

- (void)updateMethodOptionsWithSection:(ZZTableSectionItem *)sectionItem {
    sectionItem.adapter = self;
    _finalMethodOptions |= sectionItem.methodOptions;
    for (ZZTableRowItem *rowItem in sectionItem.rowItems) {
        _finalMethodOptions |= rowItem.methodOptions;
    }
}

- (void)updateMethodOption:(NSUInteger)option addOrRemoveBlock:(BOOL)flag {
    if (flag) {
        _finalMethodOptions |= option;
    } else {
        BOOL didSetOp = NO;
        for (ZZTableSectionItem *sectionItem in _mutableSectionItems) {
            if (!didSetOp && (sectionItem.methodOptions & option)) {
                _finalMethodOptions &= ~option;
                didSetOp = YES;
            }
            if (didSetOp) return;
            for (ZZTableRowItem *rowItem in sectionItem.rowItems) {
                if (!didSetOp && (rowItem.methodOptions & option)) {
                    _finalMethodOptions &= ~option;
                    didSetOp = YES;
                }
                if (didSetOp) return;
            }
        }
    }
}

/// MARK: contain
- (BOOL)containsSection:(ZZTableSectionItem *)section {
    return [_mutableSectionItems containsObject:section];
}
/// MARK: add
- (void)addSection:(ZZTableSectionItem *)section {
    [self.mutableSectionItems addObject:section];
    [self updateMethodOptionsWithSection:section];
}
- (void)addSectionsFromArray:(NSArray<ZZTableSectionItem *> *)sectionsArray {
    [self.mutableSectionItems addObjectsFromArray:sectionsArray];
    for (ZZTableSectionItem *sectionItem in sectionsArray) {
        [self updateMethodOptionsWithSection:sectionItem];
    }
}
/// MARK: insert
- (void)insertSection:(ZZTableSectionItem *)section atIndex:(NSUInteger)idx {
    [self.mutableSectionItems insertObject:section atIndex:idx];
    [self updateMethodOptionsWithSection:section];
}
- (void)insertSections:(NSArray<ZZTableSectionItem *> *)sectionsArray atIndex:(NSUInteger)idx {
    [self.mutableSectionItems insertObjects:sectionsArray atIndexes:[NSIndexSet indexSetWithIndex:idx]];
    for (ZZTableSectionItem *sectionItem in sectionsArray) {
        [self updateMethodOptionsWithSection:sectionItem];
    }
}
/// MARK: remove
- (void)removeSection:(ZZTableSectionItem *)section {
    [self.mutableSectionItems removeObject:section];
    [self setNeedUpdateMethodOptions];
}
- (void)removeSectionAtIndex:(NSUInteger)idx {
    [self.mutableSectionItems removeObjectAtIndex:idx];
    [self setNeedUpdateMethodOptions];
}
- (void)removeSectionsInArray:(NSArray<ZZTableSectionItem *> *)sectionsArray {
    [self.mutableSectionItems removeObjectsInArray:sectionsArray];
    [self setNeedUpdateMethodOptions];
}

/// MARK: - sectionItems

- (NSMutableArray<ZZTableSectionItem *> *)mutableSectionItems {
    if (!_mutableSectionItems) {
        _mutableSectionItems = [NSMutableArray array];
    }
    return _mutableSectionItems;
}

- (NSArray<ZZTableSectionItem *> *)sectionItems {
    return _mutableSectionItems;
}

/// MARK: - <UITableViewDataSource>

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    self.tableView = tableView;
    return self.mutableSectionItems.count;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    ZZTableSectionItem *sectionItem = self.mutableSectionItems[section];
    return sectionItem.rowItems.count;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    ZZTableGetRow;
    UITableViewCell<ZZTableViewCellProtocol> *cell;
    if (!rowItem.cellIdentifier) {
        rowItem.cellIdentifier = [NSString stringWithFormat:@"Cell_%@_%li", NSStringFromClass(rowItem.cellClass), rowItem.cellStyle];
    }
    cell = [tableView dequeueReusableCellWithIdentifier:rowItem.cellIdentifier];
    if (!cell) {
        Class cls = rowItem.cellClass;
        Protocol *protocol = NSProtocolFromString(@"ZZTableViewCellProtocol");
        if (![cls isKindOfClass:object_getClass(ZZTableViewCell.self)] && !class_conformsToProtocol(cls, protocol)) {
            cls = ZZTableViewCell.self;
        }
        cell = [(UITableViewCell<ZZTableViewCellProtocol> *)[cls alloc] initWithStyle:rowItem.cellStyle reuseIdentifier:rowItem.cellIdentifier];
    }
    cell.rowItem = rowItem;
    if (rowItem.willReloadCellForRow) {
        rowItem.willReloadCellForRow(tableView, cell, indexPath);
    } else if (self.willReloadCellForRow) {
        self.willReloadCellForRow(tableView, cell, indexPath);
    }
    return cell;
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    ZZTableGetSection;
    if (sectionItem.titleForHeaderInSection) return sectionItem.titleForHeaderInSection(tableView, section);
    if (self.titleForHeaderInSection) return self.titleForHeaderInSection(tableView, section);
    return nil;
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    ZZTableGetSection;
    if (sectionItem.titleForFooterInSection) return sectionItem.titleForFooterInSection(tableView, section);
    if (self.titleForFooterInSection) return self.titleForFooterInSection(tableView, section);
    return nil;
}

// Editing

// Individual rows can opt out of having the -editing property set for them. If not implemented, all rows are assumed to be editable.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

// Moving/reordering

// Allows the reorder accessory view to optionally be shown for a particular row. By default, the reorder control will be shown only if the datasource implements -tableView:moveRowAtIndexPath:toIndexPath:
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

// Index

// return list of section titles to display in section index view (e.g. "ABCD...Z#")
- (nullable NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return nil;
}
// tell table which section corresponds to section title/index (e.g. "B",1))
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
    return 0;
}

// Data manipulation - insert and delete support

// After a row has the minus or plus button invoked (based on the UITableViewCellEditingStyle for the cell), the dataSource must commit the change
// Not called for edit actions using UITableViewRowAction - the action's handler will be invoked instead
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

// Data manipulation - reorder / moving support

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    
}

/// MARK: - <UITableViewDelegate>

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    ZZTableGetRow;
    if (rowItem.willDisplayCellForRow) return rowItem.willDisplayCellForRow(tableView, cell, indexPath);
    if (self.willDisplayCellForRow) return self.willDisplayCellForRow(tableView, cell, indexPath);
}
- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    ZZTableGetSection;
    if (sectionItem.willDisplayHeaderView) return sectionItem.willDisplayHeaderView(tableView, view, section);
    if (self.willDisplayHeaderView) return self.willDisplayHeaderView(tableView, view, section);
}
- (void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section {
    ZZTableGetSection;
    if (sectionItem.willDisplayFooterView) return sectionItem.willDisplayFooterView(tableView, view, section);
    if (self.willDisplayFooterView) return self.willDisplayFooterView(tableView, view, section);
}
- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath*)indexPath {
    ZZTableGetRow;
    if (rowItem.didEndDisplayingCell) return rowItem.didEndDisplayingCell(tableView, cell, indexPath);
    if (self.didEndDisplayingCell) return self.didEndDisplayingCell(tableView, cell, indexPath);
}
- (void)tableView:(UITableView *)tableView didEndDisplayingHeaderView:(UIView *)view forSection:(NSInteger)section {
    ZZTableGetSection;
    if (sectionItem.didEndDisplayingHeaderView) return sectionItem.didEndDisplayingHeaderView(tableView, view, section);
    if (self.didEndDisplayingHeaderView) return self.didEndDisplayingHeaderView(tableView, view, section);
}
- (void)tableView:(UITableView *)tableView didEndDisplayingFooterView:(UIView *)view forSection:(NSInteger)section {
    ZZTableGetSection;
    if (sectionItem.didEndDisplayingFooterView) return sectionItem.didEndDisplayingFooterView(tableView, view, section);
    if (self.didEndDisplayingFooterView) return self.didEndDisplayingFooterView(tableView, view, section);
}

// Variable height support

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZZTableGetRow;
    if (rowItem.heightForRowAtIndexPath) return rowItem.heightForRowAtIndexPath(tableView, indexPath);
    if (self.heightForRowAtIndexPath) return self.heightForRowAtIndexPath(tableView, indexPath);
    return 45;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    ZZTableGetSection;
    if (sectionItem.heightForHeaderInSection) return sectionItem.heightForHeaderInSection(tableView, section);
    if (self.heightForHeaderInSection) return self.heightForHeaderInSection(tableView, section);
    return 45;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    ZZTableGetSection;
    if (sectionItem.heightForFooterInSection) return sectionItem.heightForFooterInSection(tableView, section);
    if (self.heightForFooterInSection) return self.heightForFooterInSection(tableView, section);
    return 45;
}

// Use the estimatedHeight methods to quickly calcuate guessed values which will allow for fast load times of the table.
// If these methods are implemented, the above -tableView:heightForXXX calls will be deferred until views are ready to be displayed, so more expensive logic can be placed there.
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath API_AVAILABLE(ios(7.0)) {
    ZZTableGetRow;
    if (rowItem.estimatedHeightForRowAtIndexPath) return rowItem.estimatedHeightForRowAtIndexPath(tableView, indexPath);
    if (self.estimatedHeightForRowAtIndexPath) return self.estimatedHeightForRowAtIndexPath(tableView, indexPath);
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section API_AVAILABLE(ios(7.0)) {
    ZZTableGetSection;
    if (sectionItem.estimatedHeightForHeaderInSection) return sectionItem.estimatedHeightForHeaderInSection(tableView, section);
    if (self.estimatedHeightForHeaderInSection) return self.estimatedHeightForHeaderInSection(tableView, section);
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForFooterInSection:(NSInteger)section API_AVAILABLE(ios(7.0)) {
    ZZTableGetSection;
    if (sectionItem.estimatedHeightForFooterInSection) return sectionItem.estimatedHeightForFooterInSection(tableView, section);
    if (self.estimatedHeightForFooterInSection) return self.estimatedHeightForFooterInSection(tableView, section);
    return 0;
}

// Section header & footer information. Views are preferred over title should you decide to provide both

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    ZZTableGetSection;
    if (sectionItem.viewForHeaderInSection) return sectionItem.viewForHeaderInSection(tableView, section);
    if (self.viewForHeaderInSection) return self.viewForHeaderInSection(tableView, section);
    return nil;
}   // custom view for header. will be adjusted to default or specified header height
- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    ZZTableGetSection;
    if (sectionItem.viewForFooterInSection) return sectionItem.viewForHeaderInSection(tableView, section);
    if (self.viewForFooterInSection) return self.viewForFooterInSection(tableView, section);
    return nil;
}   // custom view for footer. will be adjusted to default or specified footer height

// Accessories (disclosures).

//- (UITableViewCellAccessoryType)tableView:(UITableView *)tableView accessoryTypeForRowWithIndexPath:(NSIndexPath *)indexPath API_DEPRECATED("", ios(2.0, 3.0)) API_UNAVAILABLE(tvos) {
//    ZZTableGetRow;
//    return rowItem.accessoryTypeForRowWithIndexPath(tableView, indexPath);
//}
- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
    ZZTableGetRow;
    if (rowItem.accessoryButtonTappedForRowWithIndexPath) return rowItem.accessoryButtonTappedForRowWithIndexPath(tableView, indexPath);
    if (self.accessoryButtonTappedForRowWithIndexPath) return self.accessoryButtonTappedForRowWithIndexPath(tableView, indexPath);
}

// Selection

// -tableView:shouldHighlightRowAtIndexPath: is called when a touch comes down on a row.
// Returning NO to that message halts the selection process and does not cause the currently selected row to lose its selected look while the touch is down.
- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath API_AVAILABLE(ios(6.0)) {
    ZZTableGetRow;
    if (rowItem.shouldHighlightRowAtIndexPath) return rowItem.shouldHighlightRowAtIndexPath(tableView, indexPath);
    if (self.shouldHighlightRowAtIndexPath) return self.shouldHighlightRowAtIndexPath(tableView, indexPath);
    return YES;
}
- (void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath API_AVAILABLE(ios(6.0)) {
    ZZTableGetRow;
    if (rowItem.didHighlightRowAtIndexPath) return rowItem.didHighlightRowAtIndexPath(tableView, indexPath);
    if (self.didHighlightRowAtIndexPath) return self.didHighlightRowAtIndexPath(tableView, indexPath);
}
- (void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath API_AVAILABLE(ios(6.0)) {
    ZZTableGetRow;
    if (rowItem.didUnhighlightRowAtIndexPath) return rowItem.didUnhighlightRowAtIndexPath(tableView, indexPath);
    if (self.didUnhighlightRowAtIndexPath) return self.didUnhighlightRowAtIndexPath(tableView, indexPath);
}

// Called before the user changes the selection. Return a new indexPath, or nil, to change the proposed selection.
- (nullable NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ZZTableGetRow;
    if (rowItem.willSelectRowAtIndexPath) return rowItem.willSelectRowAtIndexPath(tableView, indexPath);
    if (self.willSelectRowAtIndexPath) return self.willSelectRowAtIndexPath(tableView, indexPath);
    return indexPath;
}
- (nullable NSIndexPath *)tableView:(UITableView *)tableView willDeselectRowAtIndexPath:(NSIndexPath *)indexPath API_AVAILABLE(ios(3.0)) {
    ZZTableGetRow;
    if (rowItem.willDeselectRowAtIndexPath) return rowItem.willDeselectRowAtIndexPath(tableView, indexPath);
    if (self.willDeselectRowAtIndexPath) return self.willDeselectRowAtIndexPath(tableView, indexPath);
    return indexPath;
}
// Called after the user changes the selection.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ZZTableGetRow;
    if (rowItem.didSelectRowAtIndexPath) return rowItem.didSelectRowAtIndexPath(tableView, indexPath);
    if (self.didSelectRowAtIndexPath) return self.didSelectRowAtIndexPath(tableView, indexPath);
}
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath API_AVAILABLE(ios(3.0)) {
    ZZTableGetRow;
    if (rowItem.didDeselectRowAtIndexPath) return rowItem.didDeselectRowAtIndexPath(tableView, indexPath);
    if (self.didDeselectRowAtIndexPath) return self.didDeselectRowAtIndexPath(tableView, indexPath);
}

// Editing

// Allows customization of the editingStyle for a particular cell located at 'indexPath'. If not implemented, all editable cells will have UITableViewCellEditingStyleDelete set for them when the table has editing property set to YES.
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZZTableGetRow;
    if (rowItem.editingStyleForRowAtIndexPath) return rowItem.editingStyleForRowAtIndexPath(tableView, indexPath);
    if (self.editingStyleForRowAtIndexPath) return self.editingStyleForRowAtIndexPath(tableView, indexPath);
    return UITableViewCellEditingStyleNone;
}
- (nullable NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath API_AVAILABLE(ios(3.0)) API_UNAVAILABLE(tvos) {
    ZZTableGetRow;
    if (rowItem.titleForDeleteConfirmationButtonForRowAtIndexPath) return rowItem.titleForDeleteConfirmationButtonForRowAtIndexPath(tableView, indexPath);
    if (self.titleForDeleteConfirmationButtonForRowAtIndexPath) return self.titleForDeleteConfirmationButtonForRowAtIndexPath(tableView, indexPath);
    return nil;
}

// This method supersedes -tableView:titleForDeleteConfirmationButtonForRowAtIndexPath: if return value is non-nil
- (nullable NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath API_DEPRECATED_WITH_REPLACEMENT("tableView:trailingSwipeActionsConfigurationForRowAtIndexPath:", ios(8.0, 13.0)) API_UNAVAILABLE(tvos) {
    ZZTableGetRow;
    if (rowItem.editActionsForRowAtIndexPath) return rowItem.editActionsForRowAtIndexPath(tableView, indexPath);
    if (self.editActionsForRowAtIndexPath) return self.editActionsForRowAtIndexPath(tableView, indexPath);
    return nil;
}

// Swipe actions
// These methods supersede -editActionsForRowAtIndexPath: if implemented
// return nil to get the default swipe actions
- (nullable UISwipeActionsConfiguration *)tableView:(UITableView *)tableView leadingSwipeActionsConfigurationForRowAtIndexPath:(NSIndexPath *)indexPath API_AVAILABLE(ios(11.0)) API_UNAVAILABLE(tvos) {
    ZZTableGetRow;
    if (rowItem.leadingSwipeActionsConfigurationForRowAtIndexPath) return rowItem.leadingSwipeActionsConfigurationForRowAtIndexPath(tableView, indexPath);
    if (self.leadingSwipeActionsConfigurationForRowAtIndexPath) return self.leadingSwipeActionsConfigurationForRowAtIndexPath(tableView, indexPath);
    return nil;
}
- (nullable UISwipeActionsConfiguration *)tableView:(UITableView *)tableView trailingSwipeActionsConfigurationForRowAtIndexPath:(NSIndexPath *)indexPath API_AVAILABLE(ios(11.0)) API_UNAVAILABLE(tvos) {
    ZZTableGetRow;
    if (rowItem.trailingSwipeActionsConfigurationForRowAtIndexPath) return rowItem.trailingSwipeActionsConfigurationForRowAtIndexPath(tableView, indexPath);
    if (self.trailingSwipeActionsConfigurationForRowAtIndexPath) return self.trailingSwipeActionsConfigurationForRowAtIndexPath(tableView, indexPath);
    return nil;
}

// Controls whether the background is indented while editing.  If not implemented, the default is YES.  This is unrelated to the indentation level below.  This method only applies to grouped style table views.
- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    ZZTableGetRow;
    if (rowItem.shouldIndentWhileEditingRowAtIndexPath) return rowItem.shouldIndentWhileEditingRowAtIndexPath(tableView, indexPath);
    if (self.shouldIndentWhileEditingRowAtIndexPath) return self.shouldIndentWhileEditingRowAtIndexPath(tableView, indexPath);
    return NO;
}

// The willBegin/didEnd methods are called whenever the 'editing' property is automatically changed by the table (allowing insert/delete/move). This is done by a swipe activating a single row
- (void)tableView:(UITableView *)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath API_UNAVAILABLE(tvos) {
    ZZTableGetRow;
    if (rowItem.willBeginEditingRowAtIndexPath) return rowItem.willBeginEditingRowAtIndexPath(tableView, indexPath);
    if (self.willBeginEditingRowAtIndexPath) return self.willBeginEditingRowAtIndexPath(tableView, indexPath);
}
- (void)tableView:(UITableView *)tableView didEndEditingRowAtIndexPath:(nullable NSIndexPath *)indexPath API_UNAVAILABLE(tvos) {
    ZZTableGetRow;
    if (rowItem.didEndEditingRowAtIndexPath) return rowItem.didEndEditingRowAtIndexPath(tableView, indexPath);
    if (self.didEndEditingRowAtIndexPath) return self.didEndEditingRowAtIndexPath(tableView, indexPath);
}

// Moving/reordering

// Allows customization of the target row for a particular row as it is being moved/reordered
- (NSIndexPath *)tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath {
    if (self.targetIndexPathForMoveFromRowAtIndexPathToProposedIndexPath) return self.targetIndexPathForMoveFromRowAtIndexPathToProposedIndexPath(tableView, sourceIndexPath, proposedDestinationIndexPath);
    if (self.targetIndexPathForMoveFromRowAtIndexPathToProposedIndexPath) return self.targetIndexPathForMoveFromRowAtIndexPathToProposedIndexPath(tableView, sourceIndexPath, proposedDestinationIndexPath);
    return proposedDestinationIndexPath;
}

// Indentation

- (NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZZTableGetRow;
    if (rowItem.indentationLevelForRowAtIndexPath) return rowItem.indentationLevelForRowAtIndexPath(tableView, indexPath);
    if (self.indentationLevelForRowAtIndexPath) return self.indentationLevelForRowAtIndexPath(tableView, indexPath);
    return 0;
} // return 'depth' of row for hierarchies

// Copy/Paste.  All three methods must be implemented by the delegate.

//- (BOOL)tableView:(UITableView *)tableView shouldShowMenuForRowAtIndexPath:(NSIndexPath *)indexPath API_DEPRECATED_WITH_REPLACEMENT("tableView:contextMenuConfigurationForRowAtIndexPath:point:", ios(5.0, 13.0)) {
//
//}
//- (BOOL)tableView:(UITableView *)tableView canPerformAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(nullable id)sender API_DEPRECATED_WITH_REPLACEMENT("tableView:contextMenuConfigurationForRowAtIndexPath:point:", ios(5.0, 13.0)) {
//
//}
//- (void)tableView:(UITableView *)tableView performAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(nullable id)sender API_DEPRECATED_WITH_REPLACEMENT("tableView:contextMenuConfigurationForRowAtIndexPath:", ios(5.0, 13.0)) {
//
//}
//
//// Focus
//
//- (BOOL)tableView:(UITableView *)tableView canFocusRowAtIndexPath:(NSIndexPath *)indexPath API_AVAILABLE(ios(9.0)) {
//
//}
//- (BOOL)tableView:(UITableView *)tableView shouldUpdateFocusInContext:(UITableViewFocusUpdateContext *)context API_AVAILABLE(ios(9.0)) {
//
//}
//- (void)tableView:(UITableView *)tableView didUpdateFocusInContext:(UITableViewFocusUpdateContext *)context withAnimationCoordinator:(UIFocusAnimationCoordinator *)coordinator API_AVAILABLE(ios(9.0)) {
//
//}
//- (nullable NSIndexPath *)indexPathForPreferredFocusedViewInTableView:(UITableView *)tableView API_AVAILABLE(ios(9.0)) {
//
//}
//
//// Spring Loading
//
//- (BOOL)tableView:(UITableView *)tableView shouldSpringLoadRowAtIndexPath:(NSIndexPath *)indexPath withContext:(id<UISpringLoadedInteractionContext>)context API_AVAILABLE(ios(11.0)) API_UNAVAILABLE(tvos, watchos) {
//
//}
//
//// Multiple Selection
//
//- (BOOL)tableView:(UITableView *)tableView shouldBeginMultipleSelectionInteractionAtIndexPath:(NSIndexPath *)indexPath API_AVAILABLE(ios(13.0)) API_UNAVAILABLE(tvos, watchos) {
//
//}
//
//- (void)tableView:(UITableView *)tableView didBeginMultipleSelectionInteractionAtIndexPath:(NSIndexPath *)indexPath API_AVAILABLE(ios(13.0)) API_UNAVAILABLE(tvos, watchos) {
//
//}
//
//
//- (void)tableViewDidEndMultipleSelectionInteraction:(UITableView *)tableView API_AVAILABLE(ios(13.0)) API_UNAVAILABLE(tvos, watchos) {
//
//}
//
//- (nullable UIContextMenuConfiguration *)tableView:(UITableView *)tableView contextMenuConfigurationForRowAtIndexPath:(NSIndexPath *)indexPath point:(CGPoint)point API_AVAILABLE(ios(13.0)) API_UNAVAILABLE(watchos, tvos) {
//
//}
//
//
//- (nullable UITargetedPreview *)tableView:(UITableView *)tableView previewForHighlightingContextMenuWithConfiguration:(UIContextMenuConfiguration *)configuration API_AVAILABLE(ios(13.0)) API_UNAVAILABLE(watchos, tvos) {
//
//}
//
//- (nullable UITargetedPreview *)tableView:(UITableView *)tableView previewForDismissingContextMenuWithConfiguration:(UIContextMenuConfiguration *)configuration API_AVAILABLE(ios(13.0)) API_UNAVAILABLE(watchos, tvos) {
//
//}
//
//- (void)tableView:(UITableView *)tableView willPerformPreviewActionForMenuWithConfiguration:(UIContextMenuConfiguration *)configuration animator:(id<UIContextMenuInteractionCommitAnimating>)animator API_AVAILABLE(ios(13.0)) API_UNAVAILABLE(watchos, tvos) {
//
//}

@end
