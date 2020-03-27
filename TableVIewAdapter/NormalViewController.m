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

- (void)viewDidLoad {
    [super viewDidLoad];
    
    ZZNormalRowItem *row0 = [[ZZNormalRowItem alloc] init];
    row0.title = @"row0";
    row0.titleColor = [UIColor orangeColor];
    row0.heightForRowAtIndexPath = ^CGFloat(UITableView *tableView, NSIndexPath *indexPath) {
        return 100;
    };
    row0.didSelectRowAtIndexPath = ^(UITableView * _Nonnull tableView, NSIndexPath * _Nonnull indexPath) {
        NSLog(@"did select row0");
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    };
    row0.didDeselectRowAtIndexPath = ^(UITableView * _Nonnull tableView, NSIndexPath * _Nonnull indexPath) {
        NSLog(@"did deselect row0");
    };

    ZZNormalRowItem *row1 = [[ZZNormalRowItem alloc] init];
    row1.title = @"row1";
    row1.titleColor = [UIColor blackColor];
    row1.heightForRowAtIndexPath = ^CGFloat(UITableView *tableView, NSIndexPath *indexPath) {
        return 45;
    };
    
    ZZNormalRowItem *row2 = [[ZZNormalRowItem alloc] init];
    row2.title = @"row2";
    row2.titleColor = [UIColor grayColor];
    row2.heightForRowAtIndexPath = ^CGFloat(UITableView *tableView, NSIndexPath *indexPath) {
        return 65;
    };
    
    ZZNormalSectionItem *section0 = [[ZZNormalSectionItem alloc] init];
    section0.headerView = [[FPSView alloc] initWithFrame:CGRectMake(20, 20, 80, 30)];
    [section0 addRowsFromArray:@[row0, row1, row2]];
    
    ZZNormalSectionItem *section1 = [[ZZNormalSectionItem alloc] init];
    for (int i = 0; i < 20; i++) {
        ZZNormalRowItem *rowI = [[ZZNormalRowItem alloc] init];
        rowI.title = [NSString stringWithFormat:@"row%i", i];
        rowI.titleColor = (i % 2 == 0) ? [UIColor grayColor] : [UIColor orangeColor];
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
