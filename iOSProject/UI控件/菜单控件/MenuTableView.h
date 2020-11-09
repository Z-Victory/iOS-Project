//
//  MenuTableView.h
//  iOSProject
//
//  Created by mana on 2020/8/12.
//  Copyright © 2020 刘亚和. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class MenuTableView;
@protocol MenuTableViewDelegate <NSObject>

/// 行数
- (NSInteger)numberOfMenu:(MenuTableView *)menuTableView;

/// title
/// @param menuTableView menuTableView
/// @param row 第几行
- (NSString *)titleForMenu:(MenuTableView *)menuTableView row:(NSInteger)row;

@end
@interface MenuTableView : UIView<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView * tableView;
@property (nonatomic, weak) id<MenuTableViewDelegate> delegate;
@property (nonatomic, assign) NSInteger menuTag;

@end

NS_ASSUME_NONNULL_END
