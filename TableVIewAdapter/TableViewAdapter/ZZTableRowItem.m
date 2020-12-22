//
//  ZZTableRowItem.m
//  TableVIewAdapter
//
//  Created by ZZ on 2019/11/25.
//  Copyright © 2019 zz. All rights reserved.
//

#import "ZZTableRowItem.h"
#import "ZZTableAdapter.h"

@implementation ZZTableRowItem

- (void)didSetBlock:(BOOL)blockIfNonnull methodType:(ZZTableViewDelegateMethodType)methodOptions {
    [super didSetBlock:blockIfNonnull methodType:methodOptions];
    [self.sectionItem.adapter updateMethodOption:self.methodOptions addOrRemoveBlock:blockIfNonnull];
}

@end
