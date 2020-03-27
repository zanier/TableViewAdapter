//
//  ZZTableRowItem.h
//  TableVIewAdapter
//
//  Created by ZZ on 2019/11/25.
//  Copyright © 2019 zz. All rights reserved.
//

#import "ZZTableViewDelegator.h"
#import "ZZTableViewUtil.h"

@class ZZTableSectionItem;

NS_ASSUME_NONNULL_BEGIN

@interface ZZTableRowItem : ZZTableViewDelegator

@property (nonatomic, weak) Class cellClass;
@property (nonatomic, assign) UITableViewCellStyle cellStyle;
@property (nonatomic, weak) ZZTableSectionItem *sectionItem;
@property (nonatomic, nullable, assign) UITableViewCell *cell;
@property (nonatomic, copy) NSString *cellIdentifier;

@end

NS_ASSUME_NONNULL_END
