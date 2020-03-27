//
//  ZZTableViewDelegator.h
//  TableVIewAdapter
//
//  Created by ZZ on 2020/3/13.
//  Copyright © 2020 zz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZZTableViewUtil.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZZTableViewDelegator : NSObject

@property (nonatomic, strong) NSString *key;

@property (nonatomic, assign) ZZTableViewDelegateMethodType methodOptions;
- (void)didSetBlock:(BOOL)blockIfNonnull methodType:(ZZTableViewDelegateMethodType)methodOptions;

/// MARK: UITableViewDataSource

@property (nonatomic, nullable, copy) void (^willReloadCellForRow)(UITableView *tableView, UITableViewCell *cell, NSIndexPath *indexPath);

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
// MARK: section delegate method
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
// MARK: section datasource method
@property (nonatomic, nullable, copy) NSString *(^titleForHeaderInSection)(UITableView *tableView, NSInteger section);
@property (nonatomic, nullable, copy) NSString *(^titleForFooterInSection)(UITableView *tableView, NSInteger section);

@end

NS_ASSUME_NONNULL_END
