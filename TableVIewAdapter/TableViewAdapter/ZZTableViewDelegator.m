//
//  ZZTableViewDelegator.m
//  TableVIewAdapter
//
//  Created by ZZ on 2020/3/13.
//  Copyright © 2020 zz. All rights reserved.
//

#import "ZZTableViewDelegator.h"
//if (_block == block) return;\
//_block = [block copy];\

#define ZZBlockSetter(block, methodOptions) \
_delegateBlocks[@(methodOptions)] = block;\
[self didSetBlock:(BOOL)block methodType:methodOptions];

//if (_block) {\
//    _methodOptions |= methodOptions;\
//} else {\
//    _methodOptions &= ~methodOptions;\
//}\
//[self.sectionItem.adapter updateMethodOptionsWithMethodType:methodOptions addOrRemoveBlock:(BOOL)block];

@interface ZZTableViewDelegator () {
//    NSMutableDictionary *_delegateBlocks;
}

@property (nonatomic, strong) NSMutableDictionary *delegateBlocks;

@end

@implementation ZZTableViewDelegator

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

- (void)tempblock2:(id)block methodOptions:(ZZTableViewDelegateMethodType)methodOptions {
    
    _delegateBlocks[@(methodOptions)] = block;
}

- (void)didSetBlock:(BOOL)blockIfNonnull methodType:(ZZTableViewDelegateMethodType)methodOptions {
    if (blockIfNonnull) {
        _methodOptions |= methodOptions;
    } else {
        _methodOptions &= ~methodOptions;
    }
    //[self.sectionItem.adapter updateMethodOptionsWithMethodType:methodOptions addOrRemoveBlock:(BOOL)block];
}


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
- (void)setShouldHighlightRowAtIndexPath:(BOOL (^)(UITableView *, NSIndexPath *))shouldHighlightRowAtIndexPath {
    ZZBlockSetter(shouldHighlightRowAtIndexPath, ZZRow_shouldHighlightRowAtIndexPath);
}
- (void)setDidHighlightRowAtIndexPath:(void (^)(UITableView *, NSIndexPath *))didHighlightRowAtIndexPath {
    ZZBlockSetter(didHighlightRowAtIndexPath, ZZRow_didHighlightRowAtIndexPath);
}
- (void)setDidUnhighlightRowAtIndexPath:(void (^)(UITableView *, NSIndexPath *))didUnhighlightRowAtIndexPath {
    ZZBlockSetter(didUnhighlightRowAtIndexPath, ZZRow_didUnhighlightRowAtIndexPath);
}
- (void)setWillSelectRowAtIndexPath:(NSIndexPath * (^)(UITableView *, NSIndexPath *))willSelectRowAtIndexPath {
    ZZBlockSetter(willSelectRowAtIndexPath, ZZRow_willSelectRowAtIndexPath);
}
- (void)setWillDeselectRowAtIndexPath:(NSIndexPath * (^)(UITableView *, NSIndexPath *))willDeselectRowAtIndexPath {
    ZZBlockSetter(willDeselectRowAtIndexPath, ZZRow_willDeselectRowAtIndexPath);
}
- (void)setDidSelectRowAtIndexPath:(void (^)(UITableView *, NSIndexPath *))didSelectRowAtIndexPath {
    ZZBlockSetter(didSelectRowAtIndexPath, ZZRow_didSelectRowAtIndexPath);
}
- (void)setDidDeselectRowAtIndexPath:(void (^)(UITableView *, NSIndexPath *))didDeselectRowAtIndexPath {
    ZZBlockSetter(didDeselectRowAtIndexPath, ZZRow_didDeselectRowAtIndexPath);
}
- (void)setEditingStyleForRowAtIndexPath:(UITableViewCellEditingStyle (^)(UITableView *, NSIndexPath *))editingStyleForRowAtIndexPath {
    ZZBlockSetter(editingStyleForRowAtIndexPath, ZZRow_editingStyleForRowAtIndexPath);
}
- (void)setTitleForDeleteConfirmationButtonForRowAtIndexPath:(NSString * (^)(UITableView *, NSIndexPath *))titleForDeleteConfirmationButtonForRowAtIndexPath {
    ZZBlockSetter(titleForDeleteConfirmationButtonForRowAtIndexPath, ZZRow_titleForDeleteConfirmationButtonForRowAtIndexPath);
}
- (void)setEditActionsForRowAtIndexPath:(NSArray<UITableViewRowAction *> * (^)(UITableView *, NSIndexPath *))editActionsForRowAtIndexPath {
    ZZBlockSetter(editActionsForRowAtIndexPath, ZZRow_editActionsForRowAtIndexPath);
}
- (void)setLeadingSwipeActionsConfigurationForRowAtIndexPath:(UISwipeActionsConfiguration * (^)(UITableView *, NSIndexPath *))leadingSwipeActionsConfigurationForRowAtIndexPath {
    ZZBlockSetter(leadingSwipeActionsConfigurationForRowAtIndexPath, ZZRow_leadingSwipeActionsConfigurationForRowAtIndexPath);
}
- (void)setTrailingSwipeActionsConfigurationForRowAtIndexPath:(UISwipeActionsConfiguration * (^)(UITableView *, NSIndexPath *))trailingSwipeActionsConfigurationForRowAtIndexPath {
    ZZBlockSetter(trailingSwipeActionsConfigurationForRowAtIndexPath, ZZRow_trailingSwipeActionsConfigurationForRowAtIndexPath);
}
- (void)setShouldIndentWhileEditingRowAtIndexPath:(BOOL (^)(UITableView *, NSIndexPath *))shouldIndentWhileEditingRowAtIndexPath {
    ZZBlockSetter(shouldIndentWhileEditingRowAtIndexPath, ZZRow_shouldIndentWhileEditingRowAtIndexPath);
}
- (void)setWillBeginEditingRowAtIndexPath:(void (^)(UITableView *, NSIndexPath *))willBeginEditingRowAtIndexPath {
    ZZBlockSetter(willBeginEditingRowAtIndexPath, ZZRow_willBeginEditingRowAtIndexPath);
}
- (void)setDidEndEditingRowAtIndexPath:(void (^)(UITableView *, NSIndexPath *))didEndEditingRowAtIndexPath {
    ZZBlockSetter(didEndEditingRowAtIndexPath, ZZRow_didEndEditingRowAtIndexPath);
}
- (void)setIndentationLevelForRowAtIndexPath:(NSInteger (^)(UITableView *, NSIndexPath *))indentationLevelForRowAtIndexPath {
    ZZBlockSetter(indentationLevelForRowAtIndexPath, ZZRow_indentationLevelForRowAtIndexPath);
}

// MARK: section delegate

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

// MARK: section dataSource

- (void)setTitleForHeaderInSection:(NSString * (^)(UITableView *, NSInteger))titleForHeaderInSection {
    ZZBlockSetter(titleForHeaderInSection, ZZSection_titleForHeaderInSection);
}
- (NSString * _Nonnull (^)(UITableView * _Nonnull, NSInteger))titleForHeaderInSection {
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

///// MARK: row delegate method
//- (void)setWillDisplayCellForRow:(void (^)(UITableView *, UITableViewCell *, NSIndexPath *))willDisplayCellForRow {
//    ZZBlockSetter(_willDisplayCellForRow, willDisplayCellForRow, ZZRow_willDisplayCellForRow);
//}
//- (void)setDidEndDisplayingCell:(void (^)(UITableView *, UITableViewCell *, NSIndexPath *))didEndDisplayingCell {
//    ZZBlockSetter(_didEndDisplayingCell, didEndDisplayingCell, ZZRow_didEndDisplayingCell);
//}
//-(void)setHeightForRowAtIndexPath:(CGFloat (^)(UITableView *, NSIndexPath *))heightForRowAtIndexPath {
//    ZZBlockSetter(_heightForRowAtIndexPath, heightForRowAtIndexPath, ZZRow_heightForRowAtIndexPath);
//}
//- (void)setEstimatedHeightForRowAtIndexPath:(CGFloat (^)(UITableView *, NSIndexPath *))estimatedHeightForRowAtIndexPath {
//    ZZBlockSetter(_estimatedHeightForRowAtIndexPath, estimatedHeightForRowAtIndexPath, ZZRow_estimatedHeightForRowAtIndexPath);
//}
//- (void)setAccessoryButtonTappedForRowWithIndexPath:(void (^)(UITableView *, NSIndexPath *))accessoryButtonTappedForRowWithIndexPath {
//    ZZBlockSetter(_accessoryButtonTappedForRowWithIndexPath, accessoryButtonTappedForRowWithIndexPath, ZZRow_accessoryButtonTappedForRowWithIndexPath);
//}
//- (void)setShouldHighlightRowAtIndexPath:(BOOL (^)(UITableView *, NSIndexPath *))shouldHighlightRowAtIndexPath {
//    ZZBlockSetter(_shouldHighlightRowAtIndexPath, shouldHighlightRowAtIndexPath, ZZRow_shouldHighlightRowAtIndexPath);
//}
//- (void)setDidHighlightRowAtIndexPath:(void (^)(UITableView *, NSIndexPath *))didHighlightRowAtIndexPath {
//    ZZBlockSetter(_didHighlightRowAtIndexPath, didHighlightRowAtIndexPath, ZZRow_didHighlightRowAtIndexPath);
//}
//- (void)setDidUnhighlightRowAtIndexPath:(void (^)(UITableView *, NSIndexPath *))didUnhighlightRowAtIndexPath {
//    ZZBlockSetter(_didUnhighlightRowAtIndexPath, didUnhighlightRowAtIndexPath, ZZRow_didUnhighlightRowAtIndexPath);
//}
//- (void)setWillSelectRowAtIndexPath:(NSIndexPath * (^)(UITableView *, NSIndexPath *))willSelectRowAtIndexPath {
//    ZZBlockSetter(_willSelectRowAtIndexPath, willSelectRowAtIndexPath, ZZRow_willSelectRowAtIndexPath);
//}
//- (void)setWillDeselectRowAtIndexPath:(NSIndexPath * (^)(UITableView *, NSIndexPath *))willDeselectRowAtIndexPath {
//    ZZBlockSetter(_willDeselectRowAtIndexPath, willDeselectRowAtIndexPath, ZZRow_willDeselectRowAtIndexPath);
//}
//- (void)setDidSelectRowAtIndexPath:(void (^)(UITableView *, NSIndexPath *))didSelectRowAtIndexPath {
//    ZZBlockSetter(_didSelectRowAtIndexPath, didSelectRowAtIndexPath, ZZRow_didSelectRowAtIndexPath);
//}
//- (void)setDidDeselectRowAtIndexPath:(void (^)(UITableView *, NSIndexPath *))didDeselectRowAtIndexPath {
//    ZZBlockSetter(_didDeselectRowAtIndexPath, didDeselectRowAtIndexPath, ZZRow_didDeselectRowAtIndexPath);
//}
//- (void)setEditingStyleForRowAtIndexPath:(UITableViewCellEditingStyle (^)(UITableView *, NSIndexPath *))editingStyleForRowAtIndexPath {
//    ZZBlockSetter(_editingStyleForRowAtIndexPath, editingStyleForRowAtIndexPath, ZZRow_editingStyleForRowAtIndexPath);
//}
//- (void)setTitleForDeleteConfirmationButtonForRowAtIndexPath:(NSString * (^)(UITableView *, NSIndexPath *))titleForDeleteConfirmationButtonForRowAtIndexPath {
//    ZZBlockSetter(_titleForDeleteConfirmationButtonForRowAtIndexPath, titleForDeleteConfirmationButtonForRowAtIndexPath, ZZRow_titleForDeleteConfirmationButtonForRowAtIndexPath);
//}
//- (void)setEditActionsForRowAtIndexPath:(NSArray<UITableViewRowAction *> * (^)(UITableView *, NSIndexPath *))editActionsForRowAtIndexPath {
//    ZZBlockSetter(_editActionsForRowAtIndexPath, editActionsForRowAtIndexPath, ZZRow_editActionsForRowAtIndexPath);
//}
//- (void)setLeadingSwipeActionsConfigurationForRowAtIndexPath:(UISwipeActionsConfiguration * (^)(UITableView *, NSIndexPath *))leadingSwipeActionsConfigurationForRowAtIndexPath {
//    ZZBlockSetter(_leadingSwipeActionsConfigurationForRowAtIndexPath, leadingSwipeActionsConfigurationForRowAtIndexPath, ZZRow_leadingSwipeActionsConfigurationForRowAtIndexPath);
//}
//- (void)setTrailingSwipeActionsConfigurationForRowAtIndexPath:(UISwipeActionsConfiguration * (^)(UITableView *, NSIndexPath *))trailingSwipeActionsConfigurationForRowAtIndexPath {
//    ZZBlockSetter(_trailingSwipeActionsConfigurationForRowAtIndexPath, trailingSwipeActionsConfigurationForRowAtIndexPath, ZZRow_trailingSwipeActionsConfigurationForRowAtIndexPath);
//}
//- (void)setShouldIndentWhileEditingRowAtIndexPath:(BOOL (^)(UITableView *, NSIndexPath *))shouldIndentWhileEditingRowAtIndexPath {
//    ZZBlockSetter(_shouldIndentWhileEditingRowAtIndexPath, shouldIndentWhileEditingRowAtIndexPath, ZZRow_shouldIndentWhileEditingRowAtIndexPath);
//}
//- (void)setWillBeginEditingRowAtIndexPath:(void (^)(UITableView *, NSIndexPath *))willBeginEditingRowAtIndexPath {
//    ZZBlockSetter(_willBeginEditingRowAtIndexPath, willBeginEditingRowAtIndexPath, ZZRow_willBeginEditingRowAtIndexPath);
//}
//- (void)setDidEndEditingRowAtIndexPath:(void (^)(UITableView *, NSIndexPath *))didEndEditingRowAtIndexPath {
//    ZZBlockSetter(_didEndEditingRowAtIndexPath, didEndEditingRowAtIndexPath, ZZRow_didEndEditingRowAtIndexPath);
//}
//- (void)setIndentationLevelForRowAtIndexPath:(NSInteger (^)(UITableView *, NSIndexPath *))indentationLevelForRowAtIndexPath {
//    ZZBlockSetter(_indentationLevelForRowAtIndexPath, indentationLevelForRowAtIndexPath, ZZRow_indentationLevelForRowAtIndexPath);
//}
//
//// MARK: section delegate
//
//- (void)setWillDisplayHeaderView:(void (^)(UITableView *, UIView *, NSInteger))willDisplayHeaderView {
//    ZZBlockSetter(_willDisplayHeaderView, willDisplayHeaderView, ZZSection_willDisplayHeaderView);
//}
//- (void)setWillDisplayFooterView:(void (^)(UITableView *, UIView *, NSInteger))willDisplayFooterView {
//    ZZBlockSetter(_willDisplayFooterView, willDisplayFooterView, ZZSection_willDisplayFooterView);
//}
//- (void)setDidEndDisplayingHeaderView:(void (^)(UITableView *, UIView *, NSInteger))didEndDisplayingHeaderView {
//    ZZBlockSetter(_didEndDisplayingHeaderView, didEndDisplayingHeaderView, ZZSection_didEndDisplayingHeaderView);
//}
//- (void)setDidEndDisplayingFooterView:(void (^)(UITableView *, UIView *, NSInteger))didEndDisplayingFooterView {
//    ZZBlockSetter(_didEndDisplayingFooterView, didEndDisplayingFooterView, ZZSection_didEndDisplayingFooterView);
//}
//- (void)setHeightForHeaderInSection:(CGFloat (^)(UITableView *, NSInteger))heightForHeaderInSection {
//    ZZBlockSetter(_heightForHeaderInSection, heightForHeaderInSection, ZZSection_heightForHeaderInSection);
//}
//- (void)setHeightForFooterInSection:(CGFloat (^)(UITableView *, NSInteger))heightForFooterInSection {
//    ZZBlockSetter(_heightForFooterInSection, heightForFooterInSection, ZZSection_heightForFooterInSection);
//}
//- (void)setEstimatedHeightForFooterInSection:(CGFloat (^)(UITableView *, NSInteger))estimatedHeightForFooterInSection {
//    ZZBlockSetter(_estimatedHeightForFooterInSection, estimatedHeightForFooterInSection, ZZSection_estimatedHeightForHeaderInSection);
//}
//- (void)setEstimatedHeightForHeaderInSection:(CGFloat (^)(UITableView *, NSInteger))estimatedHeightForHeaderInSection {
//    ZZBlockSetter(_estimatedHeightForHeaderInSection, estimatedHeightForHeaderInSection, ZZSection_estimatedHeightForFooterInSection);
//}
//- (void)setViewForHeaderInSection:(UIView * (^)(UITableView *, NSInteger))viewForHeaderInSection {
//    ZZBlockSetter(_viewForHeaderInSection, viewForHeaderInSection, ZZSection_viewForHeaderInSection);
//}
//- (void)setViewForFooterInSection:(UIView * (^)(UITableView *, NSInteger))viewForFooterInSection {
//    ZZBlockSetter(_viewForFooterInSection, viewForFooterInSection, ZZSection_viewForFooterInSection);
//}
//
//// MARK: section dataSource
//
//- (void)setTitleForHeaderInSection:(NSString * (^)(UITableView *, NSInteger))titleForHeaderInSection {
//    ZZBlockSetter(_titleForHeaderInSection, titleForHeaderInSection, ZZSection_titleForHeaderInSection);
//}
//- (void)setTitleForFooterInSection:(NSString * (^)(UITableView *, NSInteger))titleForFooterInSection {
//    ZZBlockSetter(_titleForFooterInSection, titleForFooterInSection, ZZSection_titleForFooterInSection);
//}
