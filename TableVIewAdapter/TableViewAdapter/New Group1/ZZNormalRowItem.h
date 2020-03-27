//
//  ZZNormalRowItem.h
//  TableVIewAdapter
//
//  Created by ZZ on 2020/3/14.
//  Copyright © 2020 zz. All rights reserved.
//

#import "ZZTableRowItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZZNormalRowItem : ZZTableRowItem

@property (nonatomic, assign) CGFloat cellHeight;

/**
 设置cell图片，默认使用“iconName”图片名来保存，若设置了具体的图片“iconImage”，则优先使用图片。
 传入的图片可进行特殊的图片处理。
 */
@property (nonatomic, copy) NSString *iconName;
@property (nonatomic, strong) UIImage *iconImage;

///**
// 设置cell的标题与副标题。若设置副标题则cellStyle类型默认为UITableViewCellStyleValue1，如需改变类型，则重新设置cellStyle。
// */
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *detailText;

@property (nonatomic, copy) UIColor *titleColor;
@property (nonatomic, copy) UIColor *detailTextColor;

/// MARK: new

@property (nonatomic, getter=isSelected) BOOL         selected;                   // set selected state (title, image, background). default is NO. animated is NO
@property (nonatomic, getter=isHighlighted) BOOL      highlighted;                // set highlighted state (title, image, background). default is NO. animated is NO
@property (nonatomic) BOOL showsReorderControl;        // default is NO
@property (nonatomic) BOOL shouldIndentWhileEditing;   // default is YES.  This is unrelated to the indentation level below.
@property (nonatomic, assign) UITableViewCellAccessoryType accessoryType;
@property (nonatomic, strong) UIView *accessoryView;
@property (nonatomic) UITableViewCellAccessoryType    editingAccessoryType;       // default is UITableViewCellAccessoryNone. use to set standard type
@property (nonatomic, strong, nullable) UIView       *editingAccessoryView;       // if set, use custom view. ignore editingAccessoryType. tracks if enabled can calls accessory action

@property (nonatomic) NSInteger                       indentationLevel;           // adjust content indent. default is 0
@property (nonatomic) CGFloat                         indentationWidth;           // width for each level. default is 10.0
@property (nonatomic) UIEdgeInsets                    separatorInset API_AVAILABLE(ios(7.0)) UI_APPEARANCE_SELECTOR API_UNAVAILABLE(tvos); // allows customization of the separator frame
@property (nonatomic, getter=isEditing) BOOL          editing;                    // show appropriate edit controls (+/- & reorder). By default -setEditing: calls setEditing:animated: with NO for animated.
@property (nonatomic) UITableViewCellFocusStyle       focusStyle API_AVAILABLE(ios(9.0)) UI_APPEARANCE_SELECTOR;
@property (nonatomic) BOOL userInteractionEnabledWhileDragging API_AVAILABLE(ios(11.0)) API_UNAVAILABLE(tvos, watchos);

@end

NS_ASSUME_NONNULL_END
