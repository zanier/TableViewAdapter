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
#import <mach/mach.h>

@interface ViewController () {
    NSTimer *_timer;
}

@property (nonatomic, strong) ZZTableAdapter *adapter;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"ZZTableView";
    __weak typeof(self) weakSelf = self;
    //[self printCPUUsage];
    
    ZZNormalRowItem *row0 = [[ZZNormalRowItem alloc] init];
    row0.cellStyle = UITableViewCellStyleSubtitle;
    row0.willReloadCellForRow = ^(UITableView * _Nonnull tableView, UITableViewCell * _Nonnull cell, NSIndexPath * _Nonnull indexPath) {
        cell.textLabel.text = @"Normal cell";
        cell.textLabel.textColor = [UIColor orangeColor];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    };
    row0.willReloadCellForRow = ^(UITableView * _Nonnull tableView, UITableViewCell * _Nonnull cell, NSIndexPath * _Nonnull indexPath) {
        cell.detailTextLabel.text = @"willReloadCellForRow detailTextLabel text";
    };
    row0.heightForRowAtIndexPath = ^CGFloat(UITableView * _Nonnull tableView, NSIndexPath * _Nonnull indexPath) {
        return 100;
    };
    row0.didSelectRowAtIndexPath = ^(UITableView * _Nonnull tableView, NSIndexPath * _Nonnull indexPath) {
        [weakSelf.navigationController pushViewController:[NormalViewController new] animated:YES];
    };
    
    ZZNormalRowItem *row1 = [[ZZNormalRowItem alloc] init];
    row1.willReloadCellForRow = ^(UITableView * _Nonnull tableView, UITableViewCell * _Nonnull cell, NSIndexPath * _Nonnull indexPath) {
        cell.textLabel.text = @"Custom cell";
        cell.textLabel.textColor = [UIColor redColor];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    };
    row1.didSelectRowAtIndexPath = ^(UITableView * _Nonnull tableView, NSIndexPath * _Nonnull indexPath) {
        [weakSelf.navigationController pushViewController:[CustomCellViewController new] animated:YES];
    };

    ZZNormalRowItem *row2 = [[ZZNormalRowItem alloc] init];
    row2.willReloadCellForRow = ^(UITableView * _Nonnull tableView, UITableViewCell * _Nonnull cell, NSIndexPath * _Nonnull indexPath) {
        cell.textLabel.text = @"none";
    };
    
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
    
    [self log];
}

- (void)log {
    NSLog(@"Size of class NSObject : %zu", class_getInstanceSize(NSObject.self));
    NSLog(@"Size of class UILabel : %zu", class_getInstanceSize(UILabel.self));
    
    NSLog(@"Size of class ZZTableViewDelegator : %zu", class_getInstanceSize(ZZTableViewDelegator.self));
    NSLog(@"Size of class ZZTableRowItem : %zu", class_getInstanceSize(ZZTableRowItem.self));
    NSLog(@"Size of class ZZNormalRowItem : %zu", class_getInstanceSize(ZZNormalRowItem.self));
    NSLog(@"Size of class ZZNormalSectionItem : %zu", class_getInstanceSize(ZZNormalSectionItem.self));
    NSLog(@"Size of class ZZTableAdapter : %zu", class_getInstanceSize(ZZTableAdapter.self));
}

- (void)printCPUUsage {
    static CGFloat maxUsage = 0;
    NSTimer *_timer = [NSTimer scheduledTimerWithTimeInterval:0.2 repeats:YES block:^(NSTimer * _Nonnull timer) {
        CGFloat cpuUsage = [ViewController cpuUsageForApp];
        if (maxUsage < cpuUsage) maxUsage = cpuUsage;
        printf("cpuUsage: %f\n, max: %f", cpuUsage, maxUsage);
    }];
    [_timer fire];
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}

// 获取 CPU 使用率
+ (CGFloat)cpuUsageForApp {
    kern_return_t           kr;
    thread_array_t          thread_list;
    mach_msg_type_number_t  thread_count;
    thread_info_data_t      thinfo;
    mach_msg_type_number_t  thread_info_count;
    thread_basic_info_t     basic_info_th;

    // 根据当前 task 获取所有线程
    kr = task_threads(mach_task_self(), &thread_list, &thread_count);
    if (kr != KERN_SUCCESS)
        return -1;

    float total_cpu_usage = 0;
    // 遍历所有线程
    for (int i = 0; i < thread_count; i++) {
        thread_info_count = THREAD_INFO_MAX;
        // 获取每一个线程信息
        kr = thread_info(thread_list[i], THREAD_BASIC_INFO, (thread_info_t)thinfo, &thread_info_count);
        if (kr != KERN_SUCCESS)
            return -1;

        basic_info_th = (thread_basic_info_t)thinfo;
        if (!(basic_info_th->flags & TH_FLAGS_IDLE)) {
            // cpu_usage : Scaled cpu usage percentage. The scale factor is TH_USAGE_SCALE.
            // 宏定义 TH_USAGE_SCALE 返回 CPU 处理总频率：
            total_cpu_usage += basic_info_th->cpu_usage / (float)TH_USAGE_SCALE;
        }
    }

    // 注意方法最后要调用 vm_deallocate，防止出现内存泄漏
    kr = vm_deallocate(mach_task_self(), (vm_offset_t)thread_list, thread_count * sizeof(thread_t));
    assert(kr == KERN_SUCCESS);

    return total_cpu_usage;
}

@end
