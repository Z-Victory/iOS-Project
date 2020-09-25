//
//  RecChannelCell.h
//  DookayProject
//
//  Created by mana on 2020/5/9.
//  Copyright © 2020 Dookay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuCollectModel.h"

@class MenuTableCollectCell;
@protocol MenuTableCollectCellDelegate <NSObject>

/// 个数
- (NSInteger)numberOfRowsCollectionViewCell:(MenuTableCollectCell *_Nullable)menuTableCollectCell;

- (NSString *_Nullable)collectionViewCell:(MenuTableCollectCell *_Nullable)menuTableCollectCell titleForItemAtIndexPath:(NSInteger)row;

/// 点击
/// @param menuTableCollectCell self
/// @param row 哪一行
- (void)didSelectRow:(MenuTableCollectCell *_Nullable)menuTableCollectCell row:(NSInteger)row;
@end
NS_ASSUME_NONNULL_BEGIN

@interface MenuTableCollectCell : UITableViewCell<UICollectionViewDelegate,UICollectionViewDataSource>
@property (strong, nonatomic) UICollectionView * collectionView;
//@property (strong, nonatomic) NSMutableArray * itemsArray;
@property (strong, nonatomic) UICollectionViewFlowLayout *layout;
@property (strong, nonatomic) UILabel * titleLabel;
//@property (strong, nonatomic) MenuCollectModel * model;
@property (nonatomic, weak) id<MenuTableCollectCellDelegate> delegate;

//- (void)setup:(CGFloat)width height:(CGFloat)height;
+ (instancetype)cellWithTableView:(UITableView *)tableView;
- (void)reloadCell;
@end

NS_ASSUME_NONNULL_END
