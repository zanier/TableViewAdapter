//
//  ZZTextFieldRow.m
//  TableVIewAdapter
//
//  Created by ZZ on 2020/3/14.
//  Copyright © 2020 zz. All rights reserved.
//

#import "ZZTextFieldRow.h"

@implementation ZZTextFieldRow

- (Class)cellClass {
    return NSClassFromString(@"ZZTextFieldCell");
}

@end
