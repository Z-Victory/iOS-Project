//
//  LeeIrregularCollectionViewFlowLayout.h
//  iOSProject
//
//  Created by mana on 2020/7/23.
//  Copyright © 2020 刘亚和. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol LeeIrregularCollectionViewFlowLayoutDelegate <NSObject>

@required

// cell size
- (CGSize)LeeIrregularCollectionViewFlowLayout:(UICollectionViewLayout *)layout itemSizeForIndexPath:(NSIndexPath *)indexPath;

@optional

// headerview size
- (CGSize)LeeIrregularCollectionViewFlowLayout:(UICollectionViewLayout *)layout headerViewSizeForIndexPath:(NSIndexPath *)indexPath;

// footerview size
- (CGSize)LeeIrregularCollectionViewFlowLayout:(UICollectionViewLayout *)layout FooterViewSizeForIndexPath:(NSIndexPath *)indexPath;

// 横向间距
- (CGFloat)LeeIrregularCollectionViewFlowLayout:(UICollectionViewLayout*)layout itemMinimumLineSpacingForIndexPath:(NSIndexPath *)indexPath;

// 竖向间距
- (CGFloat)LeeIrregularCollectionViewFlowLayout:(UICollectionViewLayout*)layout ItemMinimumInteritemSpacingForIndexPath:(NSIndexPath *)indexPath;

// 内边距
- (UIEdgeInsets)LeeIrregularCollectionViewFlowLayout:(UICollectionViewLayout*)layout edgeInsetsInWaterflowLayoutForIndexPath:(NSIndexPath *)indexPath;


@end
@interface LeeIrregularCollectionViewFlowLayout : UICollectionViewLayout
@property (nonatomic,weak) id<LeeIrregularCollectionViewFlowLayoutDelegate> leeFlowLayoutdelegate;   //-> 代理
@end

NS_ASSUME_NONNULL_END
