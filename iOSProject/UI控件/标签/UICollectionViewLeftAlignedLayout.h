//
//  UICollectionViewLeftAlignedLayout.h
//  iOSProject
//
//  Created by mana on 2020/7/23.
//  Copyright © 2020 刘亚和. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UICollectionViewLayoutAttributes (LeftAligned)
 
- (void)leftAlignFrameWithSectionInset:(UIEdgeInsets)sectionInset;
 
@end
@protocol UICollectionViewDelegateLeftAlignedLayout <NSObject>

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section;

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section;
@end
@interface UICollectionViewLeftAlignedLayout : UICollectionViewLayout
@property (nonatomic) CGFloat minimumInteritemSpacing;
@property (nonatomic) UIEdgeInsets sectionInset;
@end

NS_ASSUME_NONNULL_END
