//
//  ViewController.m
//  TableVIewAdapter
//
//  Created by ZZ on 2019/11/25.
//  Copyright © 2019 zz. All rights reserved.
//

#import "ViewController.h"
#import "ZZTableAdapter.h"
#import "ZZNormalRowItem.h"
#import "ZZNormalSectionItem.h"
#import "NormalViewController.h"
#import "CustomCellViewController.h"
#import <objc/runtime.h>
#import <malloc/malloc.h>

@interface ViewController ()

@property (nonatomic, strong) ZZTableAdapter *adapter;

@end

@implementation ViewController

- (void)test {
    int a[] = {1,2,3,4,};
    NSData *data = [NSData dataWithBytes:(const void *)a length:40];
    NSLog(@"%@", data);
    NSLog(@"size_by_malloc_size --- %zd",
                  malloc_size((__bridge const void *)data));

    int b = 3;
    int d = 1 << b;
    NSLog(@"%d", d);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"ZZTableView";
    __weak typeof(self) weakSelf = self;
    
    
    ZZNormalRowItem *row0 = [[ZZNormalRowItem alloc] init];
    row0.title = @"Normal cell";
    row0.titleColor = [UIColor orangeColor];
    row0.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    row0.heightForRowAtIndexPath = ^CGFloat(UITableView * _Nonnull tableView, NSIndexPath * _Nonnull indexPath) {
        return 100;
    };
    row0.didSelectRowAtIndexPath = ^(UITableView * _Nonnull tableView, NSIndexPath * _Nonnull indexPath) {
//        [weakSelf test];
//        return ;
        [weakSelf.navigationController pushViewController:[NormalViewController new] animated:YES];
    };
    
    ZZNormalRowItem *row1 = [[ZZNormalRowItem alloc] init];
    row1.title = @"Custom cell";
    row1.titleColor = [UIColor redColor];
    row1.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    row1.didSelectRowAtIndexPath = ^(UITableView * _Nonnull tableView, NSIndexPath * _Nonnull indexPath) {
        [weakSelf.navigationController pushViewController:[CustomCellViewController new] animated:YES];
    };

    ZZNormalRowItem *row2 = [[ZZNormalRowItem alloc] init];
    row2.title = @"Builder";
    
    ZZNormalSectionItem *section0 = [[ZZNormalSectionItem alloc] init];
    [section0 addRowsFromArray:@[row0, row1, row2]];
    
    _adapter = [[ZZTableAdapter alloc] init];
    _adapter.didSelectRowAtIndexPath = ^(UITableView * _Nonnull tableView, NSIndexPath * _Nonnull indexPath) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    };
    [_adapter addSectionsFromArray:@[section0]];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    tableView.dataSource = _adapter;
    tableView.delegate = _adapter;
    [self.view addSubview:tableView];
}

@end
