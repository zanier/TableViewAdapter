//
//  NormalViewController.m
//  TableVIewAdapter
//
//  Created by ZZ on 2020/3/14.
//  Copyright © 2020 zz. All rights reserved.
//

#import "NormalViewController.h"
#import "ZZTableAdapter.h"
#import "ZZNormalRowItem.h"
#import "ZZNormalSectionItem.h"
#import "FPSView.h"

@interface NormalViewController ()

@property (nonatomic, strong) ZZTableAdapter *adapter;

@end

@implementation NormalViewController

- (void)dealloc {
    NSLog(@"[%@ %@]", NSStringFromClass(self.class), NSStringFromSelector(_cmd));
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"NormalViewController";
    __weak typeof(self) weakSelf = self;
    ZZNormalRowItem *row0 = [[ZZNormalRowItem alloc] init];
    row0.cellStyle = UITableViewCellStyleSubtitle;
    row0.willReloadCellForRow = ^(UITableView * _Nonnull tableView, UITableViewCell * _Nonnull cell, NSIndexPath * _Nonnull indexPath) {
        cell.textLabel.text = @"row0";
        cell.textLabel.textColor = [UIColor orangeColor];
        cell.detailTextLabel.text = weakSelf.title;
    };
    row0.heightForRowAtIndexPath = ^CGFloat(UITableView *tableView, NSIndexPath *indexPath) {
        return 100;
    };
    row0.didSelectRowAtIndexPath = ^(UITableView * _Nonnull tableView, NSIndexPath * _Nonnull indexPath) {
        NSLog(@"did select row0");
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    };

    ZZNormalRowItem *row1 = [[ZZNormalRowItem alloc] init];
    row1.willReloadCellForRow = ^(UITableView * _Nonnull tableView, UITableViewCell * _Nonnull cell, NSIndexPath * _Nonnull indexPath) {
        cell.textLabel.text = @"row1";
        cell.textLabel.textColor = [UIColor blackColor];
    };
    row1.heightForRowAtIndexPath = ^CGFloat(UITableView *tableView, NSIndexPath *indexPath) {
        return 45;
    };

    ZZNormalRowItem *row2 = [[ZZNormalRowItem alloc] init];
    row2.willReloadCellForRow = ^(UITableView * _Nonnull tableView, UITableViewCell * _Nonnull cell, NSIndexPath * _Nonnull indexPath) {
        cell.textLabel.text = @"row2";
        cell.textLabel.textColor = [UIColor grayColor];
    };
    row2.heightForRowAtIndexPath = ^CGFloat(UITableView *tableView, NSIndexPath *indexPath) {
        return 65;
    };
    row2.didEndDisplayingCell = ^(UITableView * _Nonnull tableView, UITableViewCell * _Nonnull cell, NSIndexPath * _Nonnull indexPath) {
        NSLog(@"did End Displaying Cell row2");
    };
    
    row1.didSelectRowAtIndexPath = ^(UITableView * _Nonnull tableView, NSIndexPath * _Nonnull indexPath) {
        NSLog(@"did deselect row1");
        if (row2.didEndDisplayingCell) {
            row2.didEndDisplayingCell = nil;
        } else {
            row2.didEndDisplayingCell = ^(UITableView * _Nonnull tableView, UITableViewCell * _Nonnull cell, NSIndexPath * _Nonnull indexPath) {
                NSLog(@"did End Displaying Cell row2");
            };
        }
        [tableView reloadData];
    };
    
    ZZNormalSectionItem *section0 = [[ZZNormalSectionItem alloc] init];
    section0.headerView = [[FPSView alloc] initWithFrame:CGRectMake(20, 20, 80, 30)];
    [section0 addRowsFromArray:@[row0, row1, row2]];
    
    ZZNormalSectionItem *section1 = [[ZZNormalSectionItem alloc] init];
    for (int i = 0; i < 200; i++) {
        ZZNormalRowItem *rowI = [[ZZNormalRowItem alloc] init];
        rowI.willReloadCellForRow = ^(UITableView * _Nonnull tableView, UITableViewCell * _Nonnull cell, NSIndexPath * _Nonnull indexPath) {
            cell.textLabel.text = [NSString stringWithFormat:@"row%i", i];
            cell.textLabel.textColor = (i % 2 == 0) ? [UIColor grayColor] : [UIColor orangeColor];
        };
        [section1 addRow:rowI];
    }

    _adapter = [[ZZTableAdapter alloc] init];
    [_adapter addSectionsFromArray:@[section0, section1]];
    _adapter.didSelectRowAtIndexPath = ^(UITableView * _Nonnull tableView, NSIndexPath * _Nonnull indexPath) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    };
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    tableView.dataSource = _adapter;
    tableView.delegate = _adapter;
    [self.view addSubview:tableView];
}

@end
