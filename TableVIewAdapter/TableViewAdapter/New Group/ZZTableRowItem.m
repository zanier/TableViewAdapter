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
    [self.sectionItem.adapter updateMethodOption1:self.methodOptions1 methodOption2:self.methodOptions2 addOrRemoveBlock:blockIfNonnull];
}

@end
