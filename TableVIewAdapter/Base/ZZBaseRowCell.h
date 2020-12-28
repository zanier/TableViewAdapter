//
//  ZZBaseRowCell.h
//  TableVIewAdapter
//
//  Created by ZZ on 2020/3/14.
//  Copyright © 2020 zz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZZTableViewCellProtocol.h"
#import "ZZNormalRowItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZZBaseRowCell : UITableViewCell <ZZTableViewCellProtocol>

@property (nonatomic, strong) ZZTableRowItem *rowItem;

@end

NS_ASSUME_NONNULL_END
