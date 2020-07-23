//
//  LeeIrregularCollectionViewFlowLayout.m
//  iOSProject
//
//  Created by mana on 2020/7/23.
//  Copyright © 2020 刘亚和. All rights reserved.
//

#import "LeeIrregularCollectionViewFlowLayout.h"

@interface LeeIrregularCollectionViewFlowLayout ()

@property (nonatomic,strong) NSMutableArray *attrsArray;        //-> 存放所有 cell headerview footer 的数组
@property (nonatomic,assign) CGFloat contentHeight;             //-> 当前高度
@property (nonatomic,assign) CGFloat currentX;                  //-> 当前cell 右边
@property (nonatomic,assign) CGFloat formerMaxY;                //-> 前一个attr Y 轴 达到的最大位置

@end

@implementation LeeIrregularCollectionViewFlowLayout


#pragma mark - override super method
/**
 * 第一步： 初始化
 */
- (void)prepareLayout{
    [super prepareLayout];
    self.contentHeight = 0.0f;
    self.currentX      = 0.0f;
    self.formerMaxY    = 0.0f;

    [self.attrsArray removeAllObjects];

    // 如果collectionview 的section == 0 直接returen
    NSInteger sectionNumber = [self.collectionView numberOfSections];
    if (sectionNumber == 0) {
        return;
    }
    
    // section > 0
    for (int i = 0; i < sectionNumber; i++) {
        NSIndexPath *headerFooterIndexPath = [NSIndexPath indexPathForItem:0 inSection:i];
        UICollectionViewLayoutAttributes *sectionHeaderAttri = [self layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader atIndexPath:headerFooterIndexPath];
        if (sectionHeaderAttri.frame.size.height > 0) {
            [self.attrsArray addObject:sectionHeaderAttri];
        }
        NSInteger itemNumber = [self.collectionView numberOfItemsInSection:i];
        for (int j = 0; j < itemNumber; j++) {
            NSIndexPath *itemIndexPath = [NSIndexPath indexPathForItem:j inSection:i];
            UICollectionViewLayoutAttributes *attrs = [self layoutAttributesForItemAtIndexPath:itemIndexPath];
            NSAssert(attrs.frame.size.height > 0 && attrs.frame.size.width > 0 , @"item size 的高度 或 宽度 为0，这里不允许为0 ");
            if (attrs.frame.size.height > 0 && attrs.frame.size.width > 0) {

            }
            [self.attrsArray addObject:attrs];
        }

        UICollectionViewLayoutAttributes *sectionFooterAttri = [self layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionFooter atIndexPath:headerFooterIndexPath];
        if (sectionFooterAttri.frame.size.height > 0) {
            [self.attrsArray addObject:sectionFooterAttri];
        }
    }
}

/**
 * 第二步： 决定cell的排布
 */
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect{
    return self.attrsArray;
}

/*!
 *  多次调用 只要滑出范围就会 调用
 *  当CollectionView的显示范围发生改变的时候，是否重新发生布局
 *  一旦重新刷新 布局，就会重新调用
 *  1.layoutAttributesForElementsInRect：方法
 *  2.preparelayout方法
 */
-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
    return YES;
}


- (UICollectionViewLayoutAttributes *)layoutAttributesForSupplementaryViewOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath{

    CGSize supplementaryViewSize = CGSizeZero;
    UICollectionViewLayoutAttributes *attrs = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:elementKind withIndexPath:indexPath];

    if ([elementKind isEqualToString:UICollectionElementKindSectionHeader]) {
        if (self.leeFlowLayoutdelegate && [self.leeFlowLayoutdelegate respondsToSelector:@selector(LeeIrregularCollectionViewFlowLayout:headerViewSizeForIndexPath:)]) {
            supplementaryViewSize = [self.leeFlowLayoutdelegate LeeIrregularCollectionViewFlowLayout:self headerViewSizeForIndexPath:indexPath];
        }

    }else if ([elementKind isEqualToString:UICollectionElementKindSectionFooter]){
        if (self.leeFlowLayoutdelegate && [self.leeFlowLayoutdelegate respondsToSelector:@selector(LeeIrregularCollectionViewFlowLayout:FooterViewSizeForIndexPath:)]) {
            supplementaryViewSize = [self.leeFlowLayoutdelegate LeeIrregularCollectionViewFlowLayout:self FooterViewSizeForIndexPath:indexPath];
        }
    }

    CGRect frame =  attrs.frame;
    frame.size = supplementaryViewSize;
    frame.origin.y = self.contentHeight;
    attrs.frame = frame;
    self.contentHeight += supplementaryViewSize.height;
    return attrs;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{

    UICollectionViewLayoutAttributes *attrs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    CGFloat collectionViewW = self.collectionView.frame.size.width;
    CGSize itemSize = [self.leeFlowLayoutdelegate LeeIrregularCollectionViewFlowLayout:self itemSizeForIndexPath:indexPath];

    CGFloat itemLineSpacing = 10.0f;
    if (self.leeFlowLayoutdelegate && [self.leeFlowLayoutdelegate respondsToSelector:@selector(LeeIrregularCollectionViewFlowLayout:itemMinimumLineSpacingForIndexPath:)]) {
        itemLineSpacing = [self.leeFlowLayoutdelegate LeeIrregularCollectionViewFlowLayout:self itemMinimumLineSpacingForIndexPath:indexPath];
    }
    CGFloat interItemSpacing = 10.0f;
    if (self.leeFlowLayoutdelegate && [self.leeFlowLayoutdelegate respondsToSelector:@selector(LeeIrregularCollectionViewFlowLayout:ItemMinimumInteritemSpacingForIndexPath:)]) {
        interItemSpacing = [self.leeFlowLayoutdelegate LeeIrregularCollectionViewFlowLayout:self itemMinimumLineSpacingForIndexPath:indexPath];
    }
    UIEdgeInsets sectionEdge =UIEdgeInsetsMake(10.f, 10.f, 10.f, 10.f);
    if (self.leeFlowLayoutdelegate && [self.leeFlowLayoutdelegate respondsToSelector:@selector(LeeIrregularCollectionViewFlowLayout:edgeInsetsInWaterflowLayoutForIndexPath:)]) {
        sectionEdge = [self.leeFlowLayoutdelegate LeeIrregularCollectionViewFlowLayout:self edgeInsetsInWaterflowLayoutForIndexPath:indexPath];
    }

    NSInteger itemNumber = [self.collectionView numberOfItemsInSection:indexPath.section];
    if (itemNumber == 0) {
        attrs.frame = CGRectZero;
        return attrs;
    }

    CGRect currentFrame = attrs.frame;
    currentFrame.size = itemSize;

    CGFloat maxWidth = MIN(currentFrame.size.width, collectionViewW - sectionEdge.left - sectionEdge.right);
    currentFrame.size.width = maxWidth;

    if (indexPath.row == 0) {
        self.contentHeight += sectionEdge.top;
        currentFrame.origin.x = sectionEdge.left;
        currentFrame.origin.y = self.contentHeight;
    }else{
        if (self.currentX + itemLineSpacing + itemSize.width + sectionEdge.right <= collectionViewW) { //本行
            currentFrame.origin.x = self.currentX + itemLineSpacing;
            currentFrame.origin.y = self.contentHeight;
        }else{ //下一行
            self.contentHeight = self.formerMaxY + interItemSpacing;
            currentFrame.origin.x = sectionEdge.left;
            currentFrame.origin.y = self.contentHeight;
        }
    }

    attrs.frame = currentFrame;
    self.currentX = CGRectGetMaxX(attrs.frame);

    self.formerMaxY = MAX(CGRectGetMaxY(attrs.frame), self.formerMaxY);
    if (indexPath.row == (itemNumber -1) ) {
        self.contentHeight  = MAX(CGRectGetMaxY(attrs.frame) + sectionEdge.bottom,  self.formerMaxY + sectionEdge.bottom);
    }

    return attrs;
}

- (CGSize)collectionViewContentSize{
    return CGSizeMake(self.collectionView.frame.size.width, self.contentHeight);
}


#pragma mark - setter $ getter
- (NSMutableArray *)attrsArray{
    if (!_attrsArray) {
        _attrsArray = [NSMutableArray arrayWithCapacity:1];
    }
    return _attrsArray;
}
@end
