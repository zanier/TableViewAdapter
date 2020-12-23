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
@property (nonatomic, nullable, strong) id imageOrImageName;
@property (nonatomic, nullable, copy) NSString *title;
@property (nonatomic, nullable, copy) NSString *detailText;
@property (nonatomic, nullable, strong) UIFont *titleFont;
@property (nonatomic, nullable, strong) UIFont *detailTextFont;
@property (nonatomic, nullable, strong) UIColor *titleColor;
@property (nonatomic, nullable, strong) UIColor *detailTextColor;

/// MARK: new

@property (nonatomic, getter=isSelected) BOOL         selected;                   // set selected state (title, image, background). default is NO. animated is NO
@property (nonatomic, getter=isHighlighted) BOOL      highlighted;                // set highlighted state (title, image, background). default is NO. animated is NO
@property (nonatomic) BOOL showsReorderControl;        // default is NO
@property (nonatomic) BOOL shouldIndentWhileEditing;   // default is YES.  This is unrelated to the indentation level below.
@property (nonatomic, assign) UITableViewCellAccessoryType accessoryType;
@property (nonatomic, nullable, strong) UIView *accessoryView;
@property (nonatomic) UITableViewCellAccessoryType    editingAccessoryType;       // default is UITableViewCellAccessoryNone. use to set standard type
@property (nonatomic, nullable, strong) UIView       *editingAccessoryView;       // if set, use custom view. ignore editingAccessoryType. tracks if enabled can calls accessory action

@property (nonatomic) NSInteger                       indentationLevel;           // adjust content indent. default is 0
@property (nonatomic) CGFloat                         indentationWidth;           // width for each level. default is 10.0
@property (nonatomic) UIEdgeInsets                    separatorInset API_AVAILABLE(ios(7.0)) UI_APPEARANCE_SELECTOR API_UNAVAILABLE(tvos); // allows customization of the separator frame
@property (nonatomic, getter=isEditing) BOOL          editing;                    // show appropriate edit controls (+/- & reorder). By default -setEditing: calls setEditing:animated: with NO for animated.
@property (nonatomic) UITableViewCellFocusStyle       focusStyle API_AVAILABLE(ios(9.0)) UI_APPEARANCE_SELECTOR;
@property (nonatomic) BOOL userInteractionEnabledWhileDragging API_AVAILABLE(ios(11.0)) API_UNAVAILABLE(tvos, watchos);

@end

NS_ASSUME_NONNULL_END
