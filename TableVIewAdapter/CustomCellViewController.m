//
//  CustomCellViewController.m
//  TableVIewAdapter
//
//  Created by ZZ on 2020/3/14.
//  Copyright © 2020 zz. All rights reserved.
//

#import "CustomCellViewController.h"
#import "ZZTableAdapter.h"
#import "ZZNormalRowItem.h"
#import "ZZNormalSectionItem.h"
#import "ZZTextFieldRow.h"

@interface CustomCellViewController ()

@property (nonatomic, strong) ZZTableAdapter *adapter;

@end

@implementation CustomCellViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    ZZNormalRowItem *row0 = [[ZZNormalRowItem alloc] init];
    row0.title = @"row0";
    row0.titleColor = [UIColor orangeColor];
    
    ZZTextFieldRow *row1 = [[ZZTextFieldRow alloc] init];
    row1.willReloadCellForRow = ^(UITableView * _Nonnull tableView, UITableViewCell * _Nonnull cell, NSIndexPath * _Nonnull indexPath) {
        cell.textLabel.text = @"Switch Cell";
        cell.textLabel.textColor = [UIColor cyanColor];
    };
    
    ZZNormalSectionItem *section0 = [[ZZNormalSectionItem alloc] init];
    [section0 addRowsFromArray:@[row0, row1]];
    
    _adapter = [[ZZTableAdapter alloc] init];
    [_adapter addSectionsFromArray:@[section0]];
    _adapter.didSelectRowAtIndexPath = ^(UITableView * _Nonnull tableView, NSIndexPath * _Nonnull indexPath) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    };
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    tableView.dataSource = _adapter;
    tableView.delegate = _adapter;
    [self.view addSubview:tableView];

}

@end
