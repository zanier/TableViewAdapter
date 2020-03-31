//
//  ZZNormalSectionItem.m
//  TableVIewAdapter
//
//  Created by ZZ on 2020/3/14.
//  Copyright © 2020 zz. All rights reserved.
//

#import "ZZNormalSectionItem.h"

@implementation ZZNormalSectionItem

- (void)setHeaderText:(NSString *)headerText {
    if (_headerText == headerText) {
        return;
    }
    _headerText = [headerText copy];
    self.titleForHeaderInSection = headerText ? ^NSString * _Nonnull(UITableView * _Nonnull tableView, NSInteger section) {
        return headerText;
    } : nil;
}

- (void)setFooterText:(NSString *)footerText {
    if (_footerText == footerText) {
        return;
    }
    _footerText = [footerText copy];
    self.titleForHeaderInSection = footerText ? ^NSString * _Nonnull(UITableView * _Nonnull tableView, NSInteger section) {
        return footerText;
    } : nil;
}

- (void)setHeaderView:(UIView *)headerView {
    if (_headerView == headerView) {
        return;
    }
    _headerView = headerView;
    if (_headerView) {
        __weak UIView *weakHeaderView = _headerView;
        self.viewForHeaderInSection = ^UIView * _Nonnull(UITableView * _Nonnull tableView, NSInteger section) {
            return weakHeaderView;
        };
        self.heightForHeaderInSection = ^CGFloat(UITableView * _Nonnull tableView, NSInteger section) {
            return CGRectGetHeight(weakHeaderView.bounds);
        };
        self.estimatedHeightForHeaderInSection = ^CGFloat(UITableView * _Nonnull tableView, NSInteger section) {
            return CGRectGetHeight(weakHeaderView.bounds);
        };
    } else {
        self.viewForHeaderInSection = nil;
        self.heightForHeaderInSection = nil;
        self.estimatedHeightForHeaderInSection = nil;
    }
}

- (void)setFooterView:(UIView *)footerView {
    if (_footerView == footerView) {
        return;
    }
    _footerView = footerView;
    if (footerView) {
        self.viewForFooterInSection = ^UIView * _Nonnull(UITableView * _Nonnull tableView, NSInteger section) {
            return footerView;
        };
        self.heightForFooterInSection = ^CGFloat(UITableView * _Nonnull tableView, NSInteger section) {
            return CGRectGetHeight(footerView.bounds);
        };
        self.estimatedHeightForFooterInSection = ^CGFloat(UITableView * _Nonnull tableView, NSInteger section) {
            return CGRectGetHeight(footerView.bounds);
        };
    } else {
        self.viewForHeaderInSection = nil;
        self.heightForHeaderInSection = nil;
        self.estimatedHeightForHeaderInSection = nil;
    }
}

@end
