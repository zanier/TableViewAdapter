//
//  ZZTableViewDelegator.m
//  TableVIewAdapter
//
//  Created by ZZ on 2020/3/13.
//  Copyright © 2020 zz. All rights reserved.
//

#import "ZZTableViewDelegator.h"

#define ZZBlockSetter(block, methodOptions) \
self.delegateBlocks[@(methodOptions)] = [block copy];\
[self didSetBlock:(BOOL)block methodType:methodOptions];

@interface ZZTableViewDelegator ()

@property (nonatomic, strong) NSMutableDictionary<NSNumber *, id> *delegateBlocks;

@property (nonatomic, assign) long long methodOptions;

/// MARK: <UITableViewDataSource>

@property (nonatomic, nullable, copy) void (^willReloadCellForRow)(UITableView *tableView, UITableViewCell *cell, NSIndexPath *indexPath);

/// MARK: <UITableViewDataDelegate>

/// MARK: row delegate method
@property (nonatomic, nullable, copy) void (^willDisplayCellForRow)(UITableView *tableView, UITableViewCell *cell, NSIndexPath *indexPath);
@property (nonatomic, nullable, copy) void (^didEndDisplayingCell)(UITableView *tableView, UITableViewCell *cell, NSIndexPath *indexPath);
@property (nonatomic, nullable, copy) CGFloat (^heightForRowAtIndexPath)(UITableView *tableView, NSIndexPath *indexPath);
@property (nonatomic, nullable, copy) CGFloat (^estimatedHeightForRowAtIndexPath)(UITableView *tableView, NSIndexPath *indexPath);
//@property (nonatomic, copy) UITableViewCellAccessoryType (^accessoryTypeForRowWithIndexPath)(UITableView *tableView, NSIndexPath *indexPath);
@property (nonatomic, nullable, copy) void (^accessoryButtonTappedForRowWithIndexPath)(UITableView *tableView, NSIndexPath *indexPath);
@property (nonatomic, nullable, copy) BOOL (^shouldHighlightRowAtIndexPath)(UITableView *tableView, NSIndexPath *indexPath);
@property (nonatomic, nullable, copy) void (^didHighlightRowAtIndexPath)(UITableView *tableView, NSIndexPath *indexPath);
@property (nonatomic, nullable, copy) void (^didUnhighlightRowAtIndexPath)(UITableView *tableView, NSIndexPath *indexPath);
@property (nonatomic, nullable, copy) NSIndexPath *(^willSelectRowAtIndexPath)(UITableView *tableView, NSIndexPath *indexPath);
@property (nonatomic, nullable, copy) NSIndexPath *(^willDeselectRowAtIndexPath)(UITableView *tableView, NSIndexPath *indexPath);
@property (nonatomic, nullable, copy) void (^didSelectRowAtIndexPath)(UITableView *tableView, NSIndexPath *indexPath);
@property (nonatomic, nullable, copy) void (^didDeselectRowAtIndexPath)(UITableView *tableView, NSIndexPath *indexPath);
@property (nonatomic, nullable, copy) UITableViewCellEditingStyle (^editingStyleForRowAtIndexPath)(UITableView *tableView, NSIndexPath *indexPath);
@property (nonatomic, nullable, copy) NSString *(^titleForDeleteConfirmationButtonForRowAtIndexPath)(UITableView *tableView, NSIndexPath *indexPath);
@property (nonatomic, nullable, copy) NSArray<UITableViewRowAction *> *(^editActionsForRowAtIndexPath)(UITableView *tableView, NSIndexPath *indexPath);
@property (nonatomic, nullable, copy) UISwipeActionsConfiguration *(^leadingSwipeActionsConfigurationForRowAtIndexPath)(UITableView *tableView, NSIndexPath *indexPath);
@property (nonatomic, nullable, copy) UISwipeActionsConfiguration *(^trailingSwipeActionsConfigurationForRowAtIndexPath)(UITableView *tableView, NSIndexPath *indexPath);
@property (nonatomic, nullable, copy) BOOL (^shouldIndentWhileEditingRowAtIndexPath)(UITableView *tableView, NSIndexPath *indexPath);
@property (nonatomic, nullable, copy) void (^willBeginEditingRowAtIndexPath)(UITableView *tableView, NSIndexPath *indexPath);
@property (nonatomic, nullable, copy) void (^didEndEditingRowAtIndexPath)(UITableView *tableView, NSIndexPath *indexPath);
@property (nonatomic, nullable, copy) NSInteger (^indentationLevelForRowAtIndexPath)(UITableView *tableView, NSIndexPath *indexPath);

/// MARK: section delegate method

@property (nonatomic, nullable, copy) void (^willDisplayHeaderView)(UITableView *tableView, UIView *view, NSInteger section);
@property (nonatomic, nullable, copy) void (^willDisplayFooterView)(UITableView *tableView, UIView *view, NSInteger section);
@property (nonatomic, nullable, copy) void (^didEndDisplayingHeaderView)(UITableView *tableView, UIView *view, NSInteger section);
@property (nonatomic, nullable, copy) void (^didEndDisplayingFooterView)(UITableView *tableView, UIView *view, NSInteger section);
@property (nonatomic, nullable, copy) CGFloat (^heightForHeaderInSection)(UITableView *tableView, NSInteger section);
@property (nonatomic, nullable, copy) CGFloat (^heightForFooterInSection)(UITableView *tableView, NSInteger section);
@property (nonatomic, nullable, copy) CGFloat (^estimatedHeightForHeaderInSection)(UITableView *tableView, NSInteger section);
@property (nonatomic, nullable, copy) CGFloat (^estimatedHeightForFooterInSection)(UITableView *tableView, NSInteger section);
@property (nonatomic, nullable, copy) UIView *(^viewForHeaderInSection)(UITableView *tableView, NSInteger section);
@property (nonatomic, nullable, copy) UIView *(^viewForFooterInSection)(UITableView *tableView, NSInteger section);

/// MARK: section datasource method

@property (nonatomic, nullable, copy) NSString *(^titleForHeaderInSection)(UITableView *tableView, NSInteger section);
@property (nonatomic, nullable, copy) NSString *(^titleForFooterInSection)(UITableView *tableView, NSInteger section);

@end

@implementation ZZTableViewDelegator

@dynamic willReloadCellForRow;
@dynamic willDisplayCellForRow;
@dynamic didEndDisplayingCell;
@dynamic heightForRowAtIndexPath;
@dynamic estimatedHeightForRowAtIndexPath;
@dynamic accessoryButtonTappedForRowWithIndexPath;
@dynamic shouldHighlightRowAtIndexPath;
@dynamic didHighlightRowAtIndexPath;
@dynamic didUnhighlightRowAtIndexPath;
@dynamic willSelectRowAtIndexPath;
@dynamic willDeselectRowAtIndexPath;
@dynamic didSelectRowAtIndexPath;
@dynamic didDeselectRowAtIndexPath;
@dynamic editingStyleForRowAtIndexPath;
@dynamic titleForDeleteConfirmationButtonForRowAtIndexPath;
@dynamic editActionsForRowAtIndexPath;
@dynamic leadingSwipeActionsConfigurationForRowAtIndexPath;
@dynamic trailingSwipeActionsConfigurationForRowAtIndexPath;
@dynamic shouldIndentWhileEditingRowAtIndexPath;
@dynamic willBeginEditingRowAtIndexPath;
@dynamic didEndEditingRowAtIndexPath;
@dynamic indentationLevelForRowAtIndexPath;
@dynamic willDisplayHeaderView;
@dynamic willDisplayFooterView;
@dynamic didEndDisplayingHeaderView;
@dynamic didEndDisplayingFooterView;
@dynamic heightForHeaderInSection;
@dynamic heightForFooterInSection;
@dynamic estimatedHeightForHeaderInSection;
@dynamic estimatedHeightForFooterInSection;
@dynamic viewForHeaderInSection;
@dynamic viewForFooterInSection;
@dynamic titleForHeaderInSection;
@dynamic titleForFooterInSection;

- (NSMutableDictionary *)delegateBlocks {
    if (!_delegateBlocks) {
        _delegateBlocks = [NSMutableDictionary dictionary];
    }
    return _delegateBlocks;
}

- (void)didSetBlock:(BOOL)blockIfNonnull methodType:(ZZTableViewDelegateMethodType)methodOptions {
    NSUInteger options = 1 << methodOptions;
    if (blockIfNonnull) {
        _methodOptions |= options;
    } else {
        _methodOptions &= ~options;
    }
}

/// MARK: - <UITableViewDataSource>
- (void)setWillReloadCellForRow:(void (^)(UITableView *, UITableViewCell *, NSIndexPath *))willReloadCellForRow {
    ZZBlockSetter(willReloadCellForRow, ZZRow_willReloadCellForRow);
}
- (void (^)(UITableView *, UITableViewCell *, NSIndexPath *))willReloadCellForRow {
    return self.delegateBlocks[@(ZZRow_willReloadCellForRow)];
}
/// MARK: - <UITableViewDataDelegate>
/// MARK: row delegate method
- (void)setWillDisplayCellForRow:(void (^)(UITableView *, UITableViewCell *, NSIndexPath *))willDisplayCellForRow {
    ZZBlockSetter(willDisplayCellForRow, ZZRow_willDisplayCellForRow);
}
- (void (^)(UITableView * _Nonnull, UITableViewCell * _Nonnull, NSIndexPath * _Nonnull))willDisplayCellForRow {
    return self.delegateBlocks[@(ZZRow_willDisplayCellForRow)];
}
- (void)setDidEndDisplayingCell:(void (^)(UITableView *, UITableViewCell *, NSIndexPath *))didEndDisplayingCell {
    ZZBlockSetter(didEndDisplayingCell, ZZRow_didEndDisplayingCell);
}
- (void (^)(UITableView * _Nonnull, UITableViewCell * _Nonnull, NSIndexPath * _Nonnull))didEndDisplayingCell {
    return self.delegateBlocks[@(ZZRow_didEndDisplayingCell)];
}
-(void)setHeightForRowAtIndexPath:(CGFloat (^)(UITableView *, NSIndexPath *))heightForRowAtIndexPath {
    ZZBlockSetter(heightForRowAtIndexPath, ZZRow_heightForRowAtIndexPath);
}
- (CGFloat (^)(UITableView * _Nonnull, NSIndexPath * _Nonnull))heightForRowAtIndexPath {
    return self.delegateBlocks[@(ZZRow_heightForRowAtIndexPath)];
}
- (void)setEstimatedHeightForRowAtIndexPath:(CGFloat (^)(UITableView *, NSIndexPath *))estimatedHeightForRowAtIndexPath {
    ZZBlockSetter(estimatedHeightForRowAtIndexPath, ZZRow_estimatedHeightForRowAtIndexPath);
}
- (CGFloat (^)(UITableView * _Nonnull, NSIndexPath * _Nonnull))estimatedHeightForRowAtIndexPath {
    return self.delegateBlocks[@(ZZRow_estimatedHeightForRowAtIndexPath)];
}
- (void)setAccessoryButtonTappedForRowWithIndexPath:(void (^)(UITableView *, NSIndexPath *))accessoryButtonTappedForRowWithIndexPath {
    ZZBlockSetter(accessoryButtonTappedForRowWithIndexPath, ZZRow_accessoryButtonTappedForRowWithIndexPath);
}
- (void (^)(UITableView * _Nonnull, NSIndexPath * _Nonnull))accessoryButtonTappedForRowWithIndexPath {
    return self.delegateBlocks[@(ZZRow_accessoryButtonTappedForRowWithIndexPath)];
}
- (void)setShouldHighlightRowAtIndexPath:(BOOL (^)(UITableView *, NSIndexPath *))shouldHighlightRowAtIndexPath {
    ZZBlockSetter(shouldHighlightRowAtIndexPath, ZZRow_shouldHighlightRowAtIndexPath);
}
- (BOOL (^)(UITableView * _Nonnull, NSIndexPath * _Nonnull))shouldHighlightRowAtIndexPath {
    return self.delegateBlocks[@(ZZRow_shouldHighlightRowAtIndexPath)];
}
- (void)setDidHighlightRowAtIndexPath:(void (^)(UITableView *, NSIndexPath *))didHighlightRowAtIndexPath {
    ZZBlockSetter(didHighlightRowAtIndexPath, ZZRow_didHighlightRowAtIndexPath);
}
- (void (^)(UITableView * _Nonnull, NSIndexPath * _Nonnull))didHighlightRowAtIndexPath {
    return self.delegateBlocks[@(ZZRow_didHighlightRowAtIndexPath)];
}
- (void)setDidUnhighlightRowAtIndexPath:(void (^)(UITableView *, NSIndexPath *))didUnhighlightRowAtIndexPath {
    ZZBlockSetter(didUnhighlightRowAtIndexPath, ZZRow_didUnhighlightRowAtIndexPath);
}
- (void (^)(UITableView * _Nonnull, NSIndexPath * _Nonnull))didUnhighlightRowAtIndexPath {
    return self.delegateBlocks[@(ZZRow_didUnhighlightRowAtIndexPath)];
}
- (void)setWillSelectRowAtIndexPath:(NSIndexPath * (^)(UITableView *, NSIndexPath *))willSelectRowAtIndexPath {
    ZZBlockSetter(willSelectRowAtIndexPath, ZZRow_willSelectRowAtIndexPath);
}
- (NSIndexPath * _Nonnull (^)(UITableView * _Nonnull, NSIndexPath * _Nonnull))willSelectRowAtIndexPath {
    return self.delegateBlocks[@(ZZRow_willSelectRowAtIndexPath)];
}
- (void)setWillDeselectRowAtIndexPath:(NSIndexPath * (^)(UITableView *, NSIndexPath *))willDeselectRowAtIndexPath {
    ZZBlockSetter(willDeselectRowAtIndexPath, ZZRow_willDeselectRowAtIndexPath);
}
- (NSIndexPath * _Nonnull (^)(UITableView * _Nonnull, NSIndexPath * _Nonnull))willDeselectRowAtIndexPath {
    return self.delegateBlocks[@(ZZRow_willDeselectRowAtIndexPath)];
}
- (void)setDidSelectRowAtIndexPath:(void (^)(UITableView *, NSIndexPath *))didSelectRowAtIndexPath {
    ZZBlockSetter(didSelectRowAtIndexPath, ZZRow_didSelectRowAtIndexPath);
}
- (void (^)(UITableView * _Nonnull, NSIndexPath * _Nonnull))didSelectRowAtIndexPath {
    return self.delegateBlocks[@(ZZRow_didSelectRowAtIndexPath)];
}
- (void)setDidDeselectRowAtIndexPath:(void (^)(UITableView *, NSIndexPath *))didDeselectRowAtIndexPath {
    ZZBlockSetter(didDeselectRowAtIndexPath, ZZRow_didDeselectRowAtIndexPath);
}
- (void (^)(UITableView * _Nonnull, NSIndexPath * _Nonnull))didDeselectRowAtIndexPath {
    return self.delegateBlocks[@(ZZRow_didDeselectRowAtIndexPath)];
}
- (void)setEditingStyleForRowAtIndexPath:(UITableViewCellEditingStyle (^)(UITableView *, NSIndexPath *))editingStyleForRowAtIndexPath {
    ZZBlockSetter(editingStyleForRowAtIndexPath, ZZRow_editingStyleForRowAtIndexPath);
}
- (UITableViewCellEditingStyle (^)(UITableView * _Nonnull, NSIndexPath * _Nonnull))editingStyleForRowAtIndexPath {
    return self.delegateBlocks[@(ZZRow_editingStyleForRowAtIndexPath)];
}
- (void)setTitleForDeleteConfirmationButtonForRowAtIndexPath:(NSString * (^)(UITableView *, NSIndexPath *))titleForDeleteConfirmationButtonForRowAtIndexPath {
    ZZBlockSetter(titleForDeleteConfirmationButtonForRowAtIndexPath, ZZRow_titleForDeleteConfirmationButtonForRowAtIndexPath);
}
- (NSString * _Nonnull (^)(UITableView * _Nonnull, NSIndexPath * _Nonnull))titleForDeleteConfirmationButtonForRowAtIndexPath {
    return self.delegateBlocks[@(ZZRow_titleForDeleteConfirmationButtonForRowAtIndexPath)];
}
- (void)setEditActionsForRowAtIndexPath:(NSArray<UITableViewRowAction *> * (^)(UITableView *, NSIndexPath *))editActionsForRowAtIndexPath {
    ZZBlockSetter(editActionsForRowAtIndexPath, ZZRow_editActionsForRowAtIndexPath);
}
- (NSArray<UITableViewRowAction *> * _Nonnull (^)(UITableView * _Nonnull, NSIndexPath * _Nonnull))editActionsForRowAtIndexPath {
    return self.delegateBlocks[@(ZZRow_editActionsForRowAtIndexPath)];
}
- (void)setLeadingSwipeActionsConfigurationForRowAtIndexPath:(UISwipeActionsConfiguration * (^)(UITableView *, NSIndexPath *))leadingSwipeActionsConfigurationForRowAtIndexPath {
    ZZBlockSetter(leadingSwipeActionsConfigurationForRowAtIndexPath, ZZRow_leadingSwipeActionsConfigurationForRowAtIndexPath);
}
- (UISwipeActionsConfiguration * _Nonnull (^)(UITableView * _Nonnull, NSIndexPath * _Nonnull))leadingSwipeActionsConfigurationForRowAtIndexPath {
    return self.delegateBlocks[@(ZZRow_leadingSwipeActionsConfigurationForRowAtIndexPath)];
}
- (void)setTrailingSwipeActionsConfigurationForRowAtIndexPath:(UISwipeActionsConfiguration * (^)(UITableView *, NSIndexPath *))trailingSwipeActionsConfigurationForRowAtIndexPath {
    ZZBlockSetter(trailingSwipeActionsConfigurationForRowAtIndexPath, ZZRow_trailingSwipeActionsConfigurationForRowAtIndexPath);
}
- (UISwipeActionsConfiguration * _Nonnull (^)(UITableView * _Nonnull, NSIndexPath * _Nonnull))trailingSwipeActionsConfigurationForRowAtIndexPath {
    return self.delegateBlocks[@(ZZRow_trailingSwipeActionsConfigurationForRowAtIndexPath)];
}
- (void)setShouldIndentWhileEditingRowAtIndexPath:(BOOL (^)(UITableView *, NSIndexPath *))shouldIndentWhileEditingRowAtIndexPath {
    ZZBlockSetter(shouldIndentWhileEditingRowAtIndexPath, ZZRow_shouldIndentWhileEditingRowAtIndexPath);
}
- (BOOL (^)(UITableView * _Nonnull, NSIndexPath * _Nonnull))shouldIndentWhileEditingRowAtIndexPath {
    return self.delegateBlocks[@(ZZRow_shouldIndentWhileEditingRowAtIndexPath)];
}
- (void)setWillBeginEditingRowAtIndexPath:(void (^)(UITableView *, NSIndexPath *))willBeginEditingRowAtIndexPath {
    ZZBlockSetter(willBeginEditingRowAtIndexPath, ZZRow_willBeginEditingRowAtIndexPath);
}
- (void (^)(UITableView * _Nonnull, NSIndexPath * _Nonnull))willBeginEditingRowAtIndexPath {
    return self.delegateBlocks[@(ZZRow_willBeginEditingRowAtIndexPath)];
}
- (void)setDidEndEditingRowAtIndexPath:(void (^)(UITableView *, NSIndexPath *))didEndEditingRowAtIndexPath {
    ZZBlockSetter(didEndEditingRowAtIndexPath, ZZRow_didEndEditingRowAtIndexPath);
}
- (void (^)(UITableView * _Nonnull, NSIndexPath * _Nonnull))didEndEditingRowAtIndexPath {
    return self.delegateBlocks[@(ZZRow_didEndEditingRowAtIndexPath)];
}
- (void)setIndentationLevelForRowAtIndexPath:(NSInteger (^)(UITableView *, NSIndexPath *))indentationLevelForRowAtIndexPath {
    ZZBlockSetter(indentationLevelForRowAtIndexPath, ZZRow_indentationLevelForRowAtIndexPath);
}
- (NSInteger (^)(UITableView * _Nonnull, NSIndexPath * _Nonnull))indentationLevelForRowAtIndexPath {
    return self.delegateBlocks[@(ZZRow_indentationLevelForRowAtIndexPath)];
}

/// MARK: section delegate

- (void)setWillDisplayHeaderView:(void (^)(UITableView *, UIView *, NSInteger))willDisplayHeaderView {
    ZZBlockSetter(willDisplayHeaderView, ZZSection_willDisplayHeaderView);
}
- (void (^)(UITableView * _Nonnull, UIView * _Nonnull, NSInteger))willDisplayHeaderView {
    return self.delegateBlocks[@(ZZSection_willDisplayHeaderView)];
}
- (void)setWillDisplayFooterView:(void (^)(UITableView *, UIView *, NSInteger))willDisplayFooterView {
    ZZBlockSetter(willDisplayFooterView, ZZSection_willDisplayFooterView);
}
- (void (^)(UITableView * _Nonnull, UIView * _Nonnull, NSInteger))willDisplayFooterView {
    return self.delegateBlocks[@(ZZSection_willDisplayFooterView)];
}
- (void)setDidEndDisplayingHeaderView:(void (^)(UITableView *, UIView *, NSInteger))didEndDisplayingHeaderView {
    ZZBlockSetter(didEndDisplayingHeaderView, ZZSection_didEndDisplayingHeaderView);
}
- (void (^)(UITableView * _Nonnull, UIView * _Nonnull, NSInteger))didEndDisplayingHeaderView {
    return self.delegateBlocks[@(ZZSection_didEndDisplayingHeaderView)];
}
- (void)setDidEndDisplayingFooterView:(void (^)(UITableView *, UIView *, NSInteger))didEndDisplayingFooterView {
    ZZBlockSetter(didEndDisplayingFooterView, ZZSection_didEndDisplayingFooterView);
}
- (void (^)(UITableView * _Nonnull, UIView * _Nonnull, NSInteger))didEndDisplayingFooterView {
    return self.delegateBlocks[@(ZZSection_didEndDisplayingFooterView)];
}
- (void)setHeightForHeaderInSection:(CGFloat (^)(UITableView *, NSInteger))heightForHeaderInSection {
    ZZBlockSetter(heightForHeaderInSection, ZZSection_heightForHeaderInSection);
}
- (CGFloat (^)(UITableView * _Nonnull, NSInteger))heightForHeaderInSection {
    return self.delegateBlocks[@(ZZSection_heightForHeaderInSection)];
}
- (void)setHeightForFooterInSection:(CGFloat (^)(UITableView *, NSInteger))heightForFooterInSection {
    ZZBlockSetter(heightForFooterInSection, ZZSection_heightForFooterInSection);
}
- (CGFloat (^)(UITableView * _Nonnull, NSInteger))heightForFooterInSection {
    return self.delegateBlocks[@(ZZSection_heightForFooterInSection)];
}
- (void)setEstimatedHeightForFooterInSection:(CGFloat (^)(UITableView *, NSInteger))estimatedHeightForFooterInSection {
    ZZBlockSetter(estimatedHeightForFooterInSection, ZZSection_estimatedHeightForHeaderInSection);
}
- (CGFloat (^)(UITableView * _Nonnull, NSInteger))estimatedHeightForHeaderInSection {
    return self.delegateBlocks[@(ZZSection_estimatedHeightForHeaderInSection)];
}
- (void)setEstimatedHeightForHeaderInSection:(CGFloat (^)(UITableView *, NSInteger))estimatedHeightForHeaderInSection {
    ZZBlockSetter(estimatedHeightForHeaderInSection, ZZSection_estimatedHeightForFooterInSection);
}
- (CGFloat (^)(UITableView * _Nonnull, NSInteger))estimatedHeightForFooterInSection {
    return self.delegateBlocks[@(ZZSection_estimatedHeightForFooterInSection)];
}
- (void)setViewForHeaderInSection:(UIView * (^)(UITableView *, NSInteger))viewForHeaderInSection {
    ZZBlockSetter(viewForHeaderInSection, ZZSection_viewForHeaderInSection);
}
- (UIView * _Nonnull (^)(UITableView * _Nonnull, NSInteger))viewForHeaderInSection {
    return self.delegateBlocks[@(ZZSection_viewForHeaderInSection)];
}
- (void)setViewForFooterInSection:(UIView * (^)(UITableView *, NSInteger))viewForFooterInSection {
    ZZBlockSetter(viewForFooterInSection, ZZSection_viewForFooterInSection);
}
- (UIView * _Nonnull (^)(UITableView * _Nonnull, NSInteger))viewForFooterInSection {
    return self.delegateBlocks[@(ZZSection_viewForFooterInSection)];
}

/// MARK: section dataSource

- (void)setTitleForHeaderInSection:(NSString * (^)(UITableView *, NSInteger))titleForHeaderInSection {
    ZZBlockSetter(titleForHeaderInSection, ZZSection_titleForHeaderInSection);
}
- (NSString * (^)(UITableView * _Nonnull, NSInteger))titleForHeaderInSection {
    return self.delegateBlocks[@(ZZSection_titleForHeaderInSection)];
}
- (void)setTitleForFooterInSection:(NSString * (^)(UITableView *, NSInteger))titleForFooterInSection {
    ZZBlockSetter(titleForFooterInSection, ZZSection_titleForFooterInSection);
}
- (NSString * _Nonnull (^)(UITableView * _Nonnull, NSInteger))titleForFooterInSection {
    return self.delegateBlocks[@(ZZSection_titleForFooterInSection)];
}

#undef ZZBlockSetter

@end

@implementation ZZTableViewRowDelegator
@dynamic willReloadCellForRow;
@dynamic willDisplayCellForRow;
@dynamic didEndDisplayingCell;
@dynamic heightForRowAtIndexPath;
@dynamic estimatedHeightForRowAtIndexPath;
@dynamic accessoryButtonTappedForRowWithIndexPath;
@dynamic shouldHighlightRowAtIndexPath;
@dynamic didHighlightRowAtIndexPath;
@dynamic didUnhighlightRowAtIndexPath;
@dynamic willSelectRowAtIndexPath;
@dynamic willDeselectRowAtIndexPath;
@dynamic didSelectRowAtIndexPath;
@dynamic didDeselectRowAtIndexPath;
@dynamic editingStyleForRowAtIndexPath;
@dynamic titleForDeleteConfirmationButtonForRowAtIndexPath;
@dynamic editActionsForRowAtIndexPath;
@dynamic leadingSwipeActionsConfigurationForRowAtIndexPath;
@dynamic trailingSwipeActionsConfigurationForRowAtIndexPath;
@dynamic shouldIndentWhileEditingRowAtIndexPath;
@dynamic willBeginEditingRowAtIndexPath;
@dynamic didEndEditingRowAtIndexPath;
@dynamic indentationLevelForRowAtIndexPath;
@dynamic willDisplayHeaderView;
@dynamic willDisplayFooterView;
@dynamic didEndDisplayingHeaderView;
@dynamic didEndDisplayingFooterView;
@dynamic heightForHeaderInSection;
@dynamic heightForFooterInSection;
@dynamic estimatedHeightForHeaderInSection;
@dynamic estimatedHeightForFooterInSection;
@dynamic viewForHeaderInSection;
@dynamic viewForFooterInSection;
@dynamic titleForHeaderInSection;
@dynamic titleForFooterInSection;
@end

@implementation ZZTableViewSectionDelegator
@dynamic willReloadCellForRow;
@dynamic willDisplayCellForRow;
@dynamic didEndDisplayingCell;
@dynamic heightForRowAtIndexPath;
@dynamic estimatedHeightForRowAtIndexPath;
@dynamic accessoryButtonTappedForRowWithIndexPath;
@dynamic shouldHighlightRowAtIndexPath;
@dynamic didHighlightRowAtIndexPath;
@dynamic didUnhighlightRowAtIndexPath;
@dynamic willSelectRowAtIndexPath;
@dynamic willDeselectRowAtIndexPath;
@dynamic didSelectRowAtIndexPath;
@dynamic didDeselectRowAtIndexPath;
@dynamic editingStyleForRowAtIndexPath;
@dynamic titleForDeleteConfirmationButtonForRowAtIndexPath;
@dynamic editActionsForRowAtIndexPath;
@dynamic leadingSwipeActionsConfigurationForRowAtIndexPath;
@dynamic trailingSwipeActionsConfigurationForRowAtIndexPath;
@dynamic shouldIndentWhileEditingRowAtIndexPath;
@dynamic willBeginEditingRowAtIndexPath;
@dynamic didEndEditingRowAtIndexPath;
@dynamic indentationLevelForRowAtIndexPath;
@dynamic willDisplayHeaderView;
@dynamic willDisplayFooterView;
@dynamic didEndDisplayingHeaderView;
@dynamic didEndDisplayingFooterView;
@dynamic heightForHeaderInSection;
@dynamic heightForFooterInSection;
@dynamic estimatedHeightForHeaderInSection;
@dynamic estimatedHeightForFooterInSection;
@dynamic viewForHeaderInSection;
@dynamic viewForFooterInSection;
@dynamic titleForHeaderInSection;
@dynamic titleForFooterInSection;
@end

@implementation ZZTableViewAdapterDelegator
@dynamic willReloadCellForRow;
@dynamic willDisplayCellForRow;
@dynamic didEndDisplayingCell;
@dynamic heightForRowAtIndexPath;
@dynamic estimatedHeightForRowAtIndexPath;
@dynamic accessoryButtonTappedForRowWithIndexPath;
@dynamic shouldHighlightRowAtIndexPath;
@dynamic didHighlightRowAtIndexPath;
@dynamic didUnhighlightRowAtIndexPath;
@dynamic willSelectRowAtIndexPath;
@dynamic willDeselectRowAtIndexPath;
@dynamic didSelectRowAtIndexPath;
@dynamic didDeselectRowAtIndexPath;
@dynamic editingStyleForRowAtIndexPath;
@dynamic titleForDeleteConfirmationButtonForRowAtIndexPath;
@dynamic editActionsForRowAtIndexPath;
@dynamic leadingSwipeActionsConfigurationForRowAtIndexPath;
@dynamic trailingSwipeActionsConfigurationForRowAtIndexPath;
@dynamic shouldIndentWhileEditingRowAtIndexPath;
@dynamic willBeginEditingRowAtIndexPath;
@dynamic didEndEditingRowAtIndexPath;
@dynamic indentationLevelForRowAtIndexPath;
@dynamic willDisplayHeaderView;
@dynamic willDisplayFooterView;
@dynamic didEndDisplayingHeaderView;
@dynamic didEndDisplayingFooterView;
@dynamic heightForHeaderInSection;
@dynamic heightForFooterInSection;
@dynamic estimatedHeightForHeaderInSection;
@dynamic estimatedHeightForFooterInSection;
@dynamic viewForHeaderInSection;
@dynamic viewForFooterInSection;
@dynamic titleForHeaderInSection;
@dynamic titleForFooterInSection;
@end
