//
//  LYHCollectionViewCell.h
//  iOSProject
//
//  Created by mana on 2020/7/23.
//  Copyright © 2020 刘亚和. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TagModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TagSecondCell : UICollectionViewCell
@property (nonatomic ,strong) IBOutlet UILabel * label;
@property (nonatomic ,strong) TagModel * model;
@end

NS_ASSUME_NONNULL_END
