//
//  ZZTextFieldCell.m
//  TableVIewAdapter
//
//  Created by ZZ on 2020/3/14.
//  Copyright © 2020 zz. All rights reserved.
//

#import "ZZTextFieldCell.h"
#import "ZZTextFieldRow.h"

@interface ZZTextFieldCell ()

@property (nonatomic, strong) UIStackView *stackView;
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) ZZTextFieldRow *textFieldRow;

@end

@implementation ZZTextFieldCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupSubViews];
    }
    return self;
}

- (void)setupSubViews {
    _textField = [[UITextField alloc] init];
    _textField.frame = CGRectMake(CGRectGetWidth(self.contentView.bounds) - 16 - 100, 0, 100, 35);
    _textField.backgroundColor = [UIColor orangeColor];
    [self.contentView addSubview:_textField];
//    NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:_textField attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1 constant:0];
//    NSLayoutConstraint *bottomConstraint = [NSLayoutConstraint constraintWithItem:_textField attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
//    NSLayoutConstraint *leftConstraint = [NSLayoutConstraint constraintWithItem:_textField attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.textLabel attribute:NSLayoutAttributeRight multiplier:1 constant:50];
//    NSLayoutConstraint *rightConstraint = [NSLayoutConstraint constraintWithItem:_textField attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTrailing multiplier:1 constant:8];
//    topConstraint.active = YES;
//    bottomConstraint.active = YES;
//    leftConstraint.active = YES;
//    rightConstraint.active = YES;
}

- (void)setRowItem:(ZZTableRowItem *)rowItem {
    if (_textFieldRow == rowItem) {
        return;
    }
    if (rowItem && [rowItem isKindOfClass:[ZZTextFieldRow class]]) {
        _textFieldRow = (ZZTextFieldRow *)rowItem;
    } else {
        rowItem = nil;
    }
    [self reloadWithRowItem:_textFieldRow];
}

- (void)reloadWithRowItem:(ZZTableRowItem *)rowItem {
//    [super reloadWithRowItem:rowItem];
//    ZZTextFieldRow *textFieldRow = (ZZTextFieldRow *)rowItem;
//    self.textLabel.text = textFieldRow.title;
//    self.textLabel.textColor = textFieldRow.titleColor;
//    self.selected = normalRowItem.selected;
//    self.highlighted = normalRowItem.highlighted;
//    self.showsReorderControl = normalRowItem.showsReorderControl;
//    self.shouldIndentWhileEditing = normalRowItem.shouldIndentWhileEditing;
//    self.accessoryType = normalRowItem.accessoryType;
//    self.accessoryView = normalRowItem.accessoryView;
//    self.editingAccessoryType = normalRowItem.editingAccessoryType;
//    self.editingAccessoryView = normalRowItem.editingAccessoryView;
//    self.indentationLevel = normalRowItem.indentationLevel;
//    self.indentationWidth = normalRowItem.indentationWidth;
//    self.separatorInset = normalRowItem.separatorInset;
//    self.editing = normalRowItem.editing;
//    self.focusStyle = normalRowItem.focusStyle;
//    self.userInteractionEnabledWhileDragging = normalRowItem.userInteractionEnabledWhileDragging;
}

@end
