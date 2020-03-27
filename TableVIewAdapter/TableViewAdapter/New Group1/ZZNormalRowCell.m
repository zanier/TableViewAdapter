//
//  ZZNormalRowCell.m
//  TableVIewAdapter
//
//  Created by ZZ on 2020/3/14.
//  Copyright © 2020 zz. All rights reserved.
//

#import "ZZNormalRowCell.h"
#import "ZZNormalRowItem.h"

@implementation ZZNormalRowCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)reloadWithRowItem:(ZZTableRowItem *)rowItem {
    [super reloadWithRowItem:rowItem];
    ZZNormalRowItem *normalRowItem = (ZZNormalRowItem *)rowItem;
    self.textLabel.text = normalRowItem.title;
    self.textLabel.textColor = normalRowItem.titleColor;
    self.selected = normalRowItem.selected;
    self.highlighted = normalRowItem.highlighted;
    self.showsReorderControl = normalRowItem.showsReorderControl;
    self.shouldIndentWhileEditing = normalRowItem.shouldIndentWhileEditing;
    self.accessoryType = normalRowItem.accessoryType;
    self.accessoryView = normalRowItem.accessoryView;
    self.editingAccessoryType = normalRowItem.editingAccessoryType;
    self.editingAccessoryView = normalRowItem.editingAccessoryView;
    self.indentationLevel = normalRowItem.indentationLevel;
    self.indentationWidth = normalRowItem.indentationWidth;
    self.separatorInset = normalRowItem.separatorInset;
    self.editing = normalRowItem.editing;
    self.focusStyle = normalRowItem.focusStyle;
    self.userInteractionEnabledWhileDragging = normalRowItem.userInteractionEnabledWhileDragging;
}

@end
