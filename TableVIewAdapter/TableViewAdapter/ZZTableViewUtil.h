//
//  ZZTableViewUtil.h
//  TableVIewAdapter
//
//  Created by ZZ on 2020/3/12.
//  Copyright © 2020 zz. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

//typedef NS_OPTIONS(unsigned long long, ZZTableViewDelegateMethodType) {
//    ZZTableViewDelegateMethodTypeNone = 0,
//    // row delegate
//    ZZRow_willDisplayCellForRow = 1 << 0,
//    ZZRow_didEndDisplayingCell = 1 << 1,
//    ZZRow_heightForRowAtIndexPath = 1 << 2,
//    ZZRow_estimatedHeightForRowAtIndexPath = 1 << 3,
//    ZZRow_accessoryButtonTappedForRowWithIndexPath = 1 << 4,
//    ZZRow_shouldHighlightRowAtIndexPath = 1 << 5,
//    ZZRow_didHighlightRowAtIndexPath = 1 << 6,
//    ZZRow_didUnhighlightRowAtIndexPath = 1 << 7,
//    ZZRow_willSelectRowAtIndexPath = 1 << 8,
//    ZZRow_willDeselectRowAtIndexPath = 1 << 9,
//    ZZRow_didSelectRowAtIndexPath = 1 << 10,
//    ZZRow_didDeselectRowAtIndexPath = 1 << 11,
//    ZZRow_editingStyleForRowAtIndexPath = 1 << 12,
//    ZZRow_titleForDeleteConfirmationButtonForRowAtIndexPath = 1 << 13,
//    ZZRow_editActionsForRowAtIndexPath = 1 << 14,
//    ZZRow_leadingSwipeActionsConfigurationForRowAtIndexPath = 1 << 15,
//    ZZRow_trailingSwipeActionsConfigurationForRowAtIndexPath = 1 << 16,
//    ZZRow_shouldIndentWhileEditingRowAtIndexPath = 1 << 17,
//    ZZRow_willBeginEditingRowAtIndexPath = 1 << 18,
//    ZZRow_didEndEditingRowAtIndexPath = 1 << 17,
//    ZZRow_indentationLevelForRowAtIndexPath = 1 << 18,
//    // section delegate
//    ZZSection_willDisplayHeaderView = 1 << 19,
//    ZZSection_willDisplayFooterView = 1 << 20,
//    ZZSection_didEndDisplayingHeaderView = 1 << 21,
//    ZZSection_didEndDisplayingFooterView = 1 << 22,
//    ZZSection_heightForHeaderInSection = 1 << 23,
//    ZZSection_heightForFooterInSection = 1 << 24,
//    ZZSection_estimatedHeightForHeaderInSection = 1 << 25,
//    ZZSection_estimatedHeightForFooterInSection = 1 << 26,
//    ZZSection_viewForHeaderInSection = 1 << 27,
//    ZZSection_viewForFooterInSection = 1 << 28,
//    // section datasource
//    ZZSection_titleForHeaderInSection = 1 << 29,
//    ZZSection_titleForFooterInSection = 1 << 30,
//};

typedef NS_OPTIONS(NSInteger, ZZTableViewDelegateMethodType) {
    ZZTableViewDelegateMethodTypeNone = -1,
    // row delegate
    ZZRow_willDisplayCellForRow = 0,
    ZZRow_didEndDisplayingCell = 1,
    ZZRow_heightForRowAtIndexPath = 2,
    ZZRow_estimatedHeightForRowAtIndexPath = 3,
    ZZRow_accessoryButtonTappedForRowWithIndexPath = 4,
    ZZRow_shouldHighlightRowAtIndexPath = 5,
    ZZRow_didHighlightRowAtIndexPath = 6,
    ZZRow_didUnhighlightRowAtIndexPath = 7,
    ZZRow_willSelectRowAtIndexPath = 8,
    ZZRow_willDeselectRowAtIndexPath = 9,
    ZZRow_didSelectRowAtIndexPath = 55,
    ZZRow_didDeselectRowAtIndexPath = 11,
    ZZRow_editingStyleForRowAtIndexPath = 12,
    ZZRow_titleForDeleteConfirmationButtonForRowAtIndexPath = 13,
    ZZRow_editActionsForRowAtIndexPath = 14,
    ZZRow_leadingSwipeActionsConfigurationForRowAtIndexPath = 15,
    ZZRow_trailingSwipeActionsConfigurationForRowAtIndexPath = 16,
    ZZRow_shouldIndentWhileEditingRowAtIndexPath = 17,
    ZZRow_willBeginEditingRowAtIndexPath = 18,
    ZZRow_didEndEditingRowAtIndexPath = 17,
    ZZRow_indentationLevelForRowAtIndexPath = 18,
    // section delegate
    ZZSection_willDisplayHeaderView = 19,
    ZZSection_willDisplayFooterView = 20,
    ZZSection_didEndDisplayingHeaderView = 21,
    ZZSection_didEndDisplayingFooterView = 22,
    ZZSection_heightForHeaderInSection = 23,
    ZZSection_heightForFooterInSection = 24,
    ZZSection_estimatedHeightForHeaderInSection = 25,
    ZZSection_estimatedHeightForFooterInSection = 26,
    ZZSection_viewForHeaderInSection = 27,
    ZZSection_viewForFooterInSection = 28,
    // section datasource
    ZZSection_titleForHeaderInSection = 29,
    ZZSection_titleForFooterInSection = 30,
};

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunused-function"

static ZZTableViewDelegateMethodType ZZMethodTypeWithSEL(SEL aSelector) {
    static NSDictionary *dict;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // row delegate method name
        NSString *didEndDisplayingCell = NSStringFromSelector(@selector(tableView:didEndDisplayingCell:forRowAtIndexPath:));
        NSString *heightForRowAtIndexPath = NSStringFromSelector(@selector(tableView:heightForRowAtIndexPath:));
        NSString *estimatedHeightForRowAtIndexPath = NSStringFromSelector(@selector(tableView:estimatedHeightForRowAtIndexPath:));
        NSString *accessoryButtonTappedForRowWithIndexPath = NSStringFromSelector(@selector(tableView:accessoryButtonTappedForRowWithIndexPath:));
        NSString *shouldHighlightRowAtIndexPath = NSStringFromSelector(@selector(tableView:shouldHighlightRowAtIndexPath:));
        NSString *didHighlightRowAtIndexPath = NSStringFromSelector(@selector(tableView:didHighlightRowAtIndexPath:));
        NSString *didUnhighlightRowAtIndexPath = NSStringFromSelector(@selector(tableView:didUnhighlightRowAtIndexPath:));
        NSString *willSelectRowAtIndexPath = NSStringFromSelector(@selector(tableView:willSelectRowAtIndexPath:));
        NSString *willDeselectRowAtIndexPath = NSStringFromSelector(@selector(tableView:willDeselectRowAtIndexPath:));
        NSString *didSelectRowAtIndexPath = NSStringFromSelector(@selector(tableView:didSelectRowAtIndexPath:));
        NSString *didDeselectRowAtIndexPath = NSStringFromSelector(@selector(tableView:didDeselectRowAtIndexPath:));
        NSString *editingStyleForRowAtIndexPath = NSStringFromSelector(@selector(tableView:editingStyleForRowAtIndexPath:));
        NSString *titleForDeleteConfirmationButtonForRowAtIndexPath = NSStringFromSelector(@selector(tableView:titleForDeleteConfirmationButtonForRowAtIndexPath:));
        NSString *editActionsForRowAtIndexPath = NSStringFromSelector(@selector(tableView:editActionsForRowAtIndexPath:));
        NSString *leadingSwipeActionsConfigurationForRowAtIndexPath = NSStringFromSelector(@selector(tableView:leadingSwipeActionsConfigurationForRowAtIndexPath:));
        NSString *trailingSwipeActionsConfigurationForRowAtIndexPath = NSStringFromSelector(@selector(tableView:trailingSwipeActionsConfigurationForRowAtIndexPath:));
        NSString *willBeginEditingRowAtIndexPath = NSStringFromSelector(@selector(tableView:willBeginEditingRowAtIndexPath:));
        NSString *didEndEditingRowAtIndexPath = NSStringFromSelector(@selector(tableView:didEndEditingRowAtIndexPath:));
        NSString *indentationLevelForRowAtIndexPath = NSStringFromSelector(@selector(tableView:indentationLevelForRowAtIndexPath:));
        // section delegate method name
        NSString *willDisplayHeaderView = NSStringFromSelector(@selector(tableView:willDisplayHeaderView:forSection:));
        NSString *willDisplayFooterView = NSStringFromSelector(@selector(tableView:willDisplayFooterView:forSection:));
        NSString *didEndDisplayingHeaderView = NSStringFromSelector(@selector(tableView:didEndDisplayingHeaderView:forSection:));
        NSString *didEndDisplayingFooterView = NSStringFromSelector(@selector(tableView:didEndDisplayingFooterView:forSection:));
        NSString *heightForHeaderInSection = NSStringFromSelector(@selector(tableView:heightForHeaderInSection:));
        NSString *heightForFooterInSection = NSStringFromSelector(@selector(tableView:heightForFooterInSection:));
        NSString *estimatedHeightForHeaderInSection = NSStringFromSelector(@selector(tableView:estimatedHeightForHeaderInSection:));
        NSString *estimatedHeightForFooterInSection = NSStringFromSelector(@selector(tableView:estimatedHeightForFooterInSection:));
        NSString *viewForHeaderInSection = NSStringFromSelector(@selector(tableView:viewForHeaderInSection:));
        NSString *viewForFooterInSection = NSStringFromSelector(@selector(tableView:viewForFooterInSection:));
        // section datasource method name
        NSString *titleForHeaderInSection = NSStringFromSelector(@selector(tableView:titleForHeaderInSection:));
        NSString *titleForFooterInSection = NSStringFromSelector(@selector(tableView:titleForFooterInSection:));
        // save into dict
        dict = @{
            // row delegate
            didEndDisplayingCell : @(ZZRow_didEndDisplayingCell),
            heightForRowAtIndexPath : @(ZZRow_heightForRowAtIndexPath),
            estimatedHeightForRowAtIndexPath : @(ZZRow_estimatedHeightForRowAtIndexPath),
            accessoryButtonTappedForRowWithIndexPath : @(ZZRow_accessoryButtonTappedForRowWithIndexPath),
            shouldHighlightRowAtIndexPath : @(ZZRow_shouldHighlightRowAtIndexPath),
            didHighlightRowAtIndexPath : @(ZZRow_didHighlightRowAtIndexPath),
            didUnhighlightRowAtIndexPath : @(ZZRow_didUnhighlightRowAtIndexPath),
            willSelectRowAtIndexPath : @(ZZRow_willSelectRowAtIndexPath),
            willDeselectRowAtIndexPath : @(ZZRow_willDeselectRowAtIndexPath),
            didSelectRowAtIndexPath : @(ZZRow_didSelectRowAtIndexPath),
            didDeselectRowAtIndexPath : @(ZZRow_didDeselectRowAtIndexPath),
            editingStyleForRowAtIndexPath : @(ZZRow_editingStyleForRowAtIndexPath),
            titleForDeleteConfirmationButtonForRowAtIndexPath : @(ZZRow_titleForDeleteConfirmationButtonForRowAtIndexPath),
            editActionsForRowAtIndexPath : @(ZZRow_editActionsForRowAtIndexPath),
            leadingSwipeActionsConfigurationForRowAtIndexPath : @(ZZRow_leadingSwipeActionsConfigurationForRowAtIndexPath),
            trailingSwipeActionsConfigurationForRowAtIndexPath : @(ZZRow_trailingSwipeActionsConfigurationForRowAtIndexPath),
            willBeginEditingRowAtIndexPath : @(ZZRow_willBeginEditingRowAtIndexPath),
            didEndEditingRowAtIndexPath : @(ZZRow_didEndEditingRowAtIndexPath),
            indentationLevelForRowAtIndexPath : @(ZZRow_indentationLevelForRowAtIndexPath),
            // section delegate
            willDisplayHeaderView : @(ZZSection_willDisplayHeaderView),
            willDisplayFooterView : @(ZZSection_willDisplayFooterView),
            didEndDisplayingHeaderView : @(ZZSection_didEndDisplayingHeaderView),
            didEndDisplayingFooterView : @(ZZSection_didEndDisplayingFooterView),
            heightForHeaderInSection : @(ZZSection_heightForHeaderInSection),
            heightForFooterInSection : @(ZZSection_heightForFooterInSection),
            estimatedHeightForHeaderInSection : @(ZZSection_estimatedHeightForHeaderInSection),
            estimatedHeightForFooterInSection : @(ZZSection_estimatedHeightForFooterInSection),
            viewForHeaderInSection : @(ZZSection_viewForHeaderInSection),
            viewForFooterInSection : @(ZZSection_viewForFooterInSection),
            // section datasource
            titleForHeaderInSection : @(ZZSection_titleForHeaderInSection),
            titleForFooterInSection : @(ZZSection_titleForFooterInSection),
        };
    });
    NSNumber *typeValue = dict[NSStringFromSelector(aSelector)];
    //ZZTableViewDelegateMethodType type = [typeValue unsignedIntegerValue];
    if (typeValue) return (ZZTableViewDelegateMethodType)[typeValue unsignedIntegerValue];
    return ZZTableViewDelegateMethodTypeNone;
}

static BOOL ZZMethodTypeCanRespond(ZZTableViewDelegateMethodType type, NSUInteger option1, NSUInteger option2) {
    if (type < 32) {
        NSUInteger option = 1 << (type);
        return option1 & option;
    } else if (type < 64) {
        NSUInteger option = 1 << (type - 32);
        return option2 & option;
    }
    return NO;
}


#pragma clang diagnostic pop

NS_ASSUME_NONNULL_END
