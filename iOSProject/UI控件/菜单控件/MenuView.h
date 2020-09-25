//
//  MenuView.h
//  iOSProject
//
//  Created by mana on 2020/8/12.
//  Copyright © 2020 刘亚和. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YHFilterButton.h"
#import "YHFilterModel.h"
#import "MenuTableView.h"
#import "MenuTableCollectView.h"
#import "MenuContentView.h"

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSUInteger, MenuUIStyle) {
    MenuStyleTableView,
    MenuStyleHorizontal,
};
@class MenuView;
@protocol MenuViewDelegate <NSObject>

/// 顶部菜单数量
- (NSInteger)numberOfMenu:(MenuView *)menuview;

/*
 tableView
 */

/// 菜单title
- (NSString *)titleForMenu:(MenuView *)menuview index:(NSInteger)index;

/// contentview的tableview个数
- (NSInteger)numberOfTabelViews:(MenuView *)menuview index:(NSInteger)index;

///风格
- (MenuUIStyle)menu:(MenuView *)menu uiStyleForRowIndexPath:(NSIndexPath *)dropIndexPath columns:(NSInteger)columns;

///tableview的行数
- (NSInteger)numberOfTableViewRows:(MenuView *)menuview index:(NSInteger)index column:(NSInteger)column;

/// tableview每行的title
/// @param menuview 默认传self
/// @param index 第几个菜单
/// @param column 第几列
/// @param row 第几个
- (NSString *)titleForTableView:(MenuView *)menuview index:(NSInteger)index column:(NSInteger)column row:(NSInteger)row;

/// 点击
/// @param menuview self
/// @param line 哪一行
/// @param row 哪一个
- (void)didSelectRow:(MenuView *)menuview line:(NSInteger)line row:(NSInteger)row;
/*
 collect
 */
/// 行数
- (NSInteger)numberOfRowCollect:(MenuView *)menuview;

/// style
- (MenuCollectUIStyle)uiStyleOfEachCollect:(MenuView *)menuview line:(NSInteger)line;

/// 每行名称
- (NSString *_Nullable)rowNameOfEachCollect:(MenuView *)menuview line:(NSInteger)line;

///每行有几个
- (NSInteger)numberOfItemsEachRowInCollect:(MenuView *)menuview row:(NSInteger)row;

/// title
/// @param menuview menuview
/// @param row 第几个
/// @param line 第几行
- (NSString *_Nullable)titleForRowCollect:(MenuView *)menuview line:(NSInteger)line row:(NSInteger)row;


@end
@interface MenuView : UIView
{
    int index;
}
@property (nonatomic, weak) id<MenuViewDelegate> delegate;
@property (nonatomic, strong) UIView * topView;
@property (nonatomic, strong) UICollectionView * collectionView;
@property (nonatomic, strong) NSMutableArray * dataArray;
@property (nonatomic, strong) NSMutableArray * buttonArray;

- (instancetype)initWithFrame:(CGRect)frame;


- (void)update:(NSInteger)line;
@end

NS_ASSUME_NONNULL_END
