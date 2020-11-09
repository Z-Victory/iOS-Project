//
//  NewTagCell.h
//  iOSProject
//
//  Created by mana on 2020/7/23.
//  Copyright © 2020 刘亚和. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TagModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface NewTagCell : UICollectionViewCell
@property (nonatomic ,strong) IBOutlet UIView * bgView;
@property (nonatomic ,strong) TagModel * model;
@property (nonatomic,strong) UIButton * deleteButton;
@property (nonatomic,copy) dispatch_block_t deleteBlock;
@end

NS_ASSUME_NONNULL_END
