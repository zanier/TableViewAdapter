//
//  ZZNormalSectionItem.h
//  TableVIewAdapter
//
//  Created by ZZ on 2020/3/14.
//  Copyright © 2020 zz. All rights reserved.
//

#import "ZZTableSectionItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZZNormalSectionItem : ZZTableSectionItem

@property (nonatomic, nullable, copy) NSString *headerText;

@property (nonatomic, nullable, copy) NSString *footerText;

@property (nonatomic, nullable, strong) UIView *headerView;

@property (nonatomic, nullable, strong) UIView *footerView;

@end

NS_ASSUME_NONNULL_END
