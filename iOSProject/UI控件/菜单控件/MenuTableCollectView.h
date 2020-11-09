//
//  MenuTableView.h
//  iOSProject
//
//  Created by mana on 2020/8/12.
//  Copyright © 2020 刘亚和. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuTableCollectCell.h"

typedef NS_ENUM(NSUInteger, MenuCollectUIStyle) {
    MenuCollectUIStyleFirst,
    MenuCollectUIStyleSecond,
};

@class MenuTableCollectView;
@protocol MenuTableCollectDelegate <NSObject>

/// 行数
- (NSInteger)numberOfMenuCollect:(MenuTableCollectView *_Nullable)menuTableCollectView;

/// style
- (MenuCollectUIStyle)uiStyleOfMenuCollect:(MenuTableCollectView *_Nullable)menuTableCollectView line:(NSInteger)line;

/// 每行有几个
/// @param row 第几行
- (NSInteger)numberOfItemInEachRow:(MenuTableCollectView *_Nullable)menuTableCollectView row:(NSInteger)row;

/// 每行名称
- (NSString *_Nullable)rowName:(MenuTableCollectView *_Nullable)menuTableCollectView row:(NSInteger)row;
/// title
/// @param menuTableCollectView menuTableCollectView
/// @param row 第几个
/// @param line 第几行
- (NSString *_Nullable)titleForMenuCollect:(MenuTableCollectView *_Nullable)menuTableCollectView line:(NSInteger)line row:(NSInteger)row;


/// 点击
/// @param menuTableCollectView self
/// @param row 哪一行
- (void)didSelectRow:(MenuTableCollectView *_Nullable)menuTableCollectView line:(NSInteger)line row:(NSInteger)row;
@end
NS_ASSUME_NONNULL_BEGIN

@interface MenuTableCollectView : UIView<UITableViewDelegate,UITableViewDataSource,MenuTableCollectCellDelegate>
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, weak) id<MenuTableCollectDelegate> delegate;
- (void)update:(NSInteger)line;
@end

NS_ASSUME_NONNULL_END
